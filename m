Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 61D09DDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 23:10:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Mem-2-Mem DMA - Generalized API
Date: Sat, 7 Jul 2007 15:08:03 +0200
References: <20070624193932.GA11797@clifford.at>
	<20070625180110.GH20463@clifford.at>
	<20070704090554.GA30693@clifford.at>
In-Reply-To: <20070704090554.GA30693@clifford.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071508.04143.arnd@arndb.de>
Cc: Clifford Wolf <clifford@clifford.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 04 July 2007, Clifford Wolf wrote:
> Ok, so here comes the first implementation:
> (I also have other projects, so it took a while.. ;-)
>
>         http://www.clifford.at/priv/dmatransfer-20070704.diff
>
> This is just for the MPC8349 DMA now, registers are still hardcoded in the
> driver instead of beeing taken from the platform files and support for
> scatter-gather is still missing and the Kconfig integration isn't checking
> if we are building for the mpc8349 (or even ppc) yet. But I think the
> direction of the API is pretty clear.

Is this a superset of what the dmaengine API can do? If not, I would
guess that things can get really confusing for the user.
Is it possible to wrap the existing dmaengine code inside of a
dmatransfer implementation?

You should probably have the authors of the dmaengine on Cc in
your next version of the driver, if you indend to replace their
code.

> +
> +/*** A dmatransfer is described using input and output chunks ***/
> +
> +// set one of this bits in fifo mode an none in linear mode

Please follow the common kernel commenting style, which allows

/* one-line comment */

/*
 * multi-line
 * comment
 */

/**
 * identifier - description in kerneldoc format
 * @name: struct member or function argument
 * @name2: another one
 *
 * long description here
 */

> +struct dmatransfer
> +{
> +	struct kref refcount;
> +
> +	// callbacks (may be called in interrupt context)
> +	dmatransfer_progress_callback_t progress_callback;
> +	dmatransfer_finish_callback_t finish_callback;
> +	dmatransfer_release_callback_t release_callback;
> +
> +	// private data from the requestor
> +	union {
> +		void *data_voidp;
> +		__u32 data_u32;
> +		__u64 data_u64;
> +	} data;

This could simply be an unsigned long, I guess. We tend to
use unsigned long for generic data, unless it always is a pointer.

> +	__u32 flags;
> +
> +	// how many input and output junks
> +	int n_input_chunks;
> +	int n_output_chunks;

unsigned?

> +	// these are used internally in dmatransfer_request_*
> +	enum {
> +		DMATRANSFER_ASYNC,
> +		DMATRANSFER_WAITING,
> +		DMATRANSFER_FINISHED
> +	} status;
> +	wait_queue_head_t wq;
> +
> +	// these are used internally in the backends
> +	struct dmatransfer_backend *backend;
> +	struct list_head backend_spool;
> +	void *backend_data_voidp;
> +
> +	// this array first contains all input and output chunk descriptions (in
> this order) +	struct dmatransfer_chunk chunks[];
> +};



> +
> +// This functions may return -EINVAL when the requested transfer can't be
> +// done in hardware and DMATRANSFER_DMAONLY is set and -EAGAIN if there
> are +// no free DMA channels and DMATRANSFER_NOSPOOL is set for the
> transfer. +extern int dmatransfer_request_async(struct dmatransfer
> *transfer); 

Put the description in front of the function definition in kerneldoc format

> +extern int dmatransfer_request_wait(struct dmatransfer *transfer); 
> +extern struct dmatransfer *dmatransfer_malloc(int chunks_n, int flags);

maybe better dmatransfer_alloc instead of dmatransfer_malloc?
To me, malloc sort of implies that it only does a pure allocation,
not also the initialization.

> +extern void dmatransfer_release(struct kref *kref);

There is a recent tendency to always leave out the 'extern' keyword
for function declarations.

> +/*** Backend drivers register themself using this struct ***/
> +
> +enum dmatransfer_quality {
> +	DMATRANSFER_QUALITY_NO = 0,
> +	DMATRANSFER_QUALITY_SOFT = 1,
> +	DMATRANSFER_QUALITY_SPOOL = 2,
> +	DMATRANSFER_QUALITY_GOOD = 3,
> +	DMATRANSFER_QUALITY_BEST = 4,
> +};
> +
> +struct dmatransfer_backend
> +{
> +	enum dmatransfer_quality (*check)(struct dmatransfer *transfer);
> +	void (*perform)(struct dmatransfer *transfer);
> +
> +	// performing transfers is 'reading' and unregistering is 'writing'
> +	struct rw_semaphore unreg_sem;
> +
> +	// internally used by the dmatransfer core
> +	struct list_head backend_list;
> +};
> +
> +extern void dmatransfer_finish(struct dmatransfer *transfer);
> +
> +extern void dmatransfer_register_backend(struct dmatransfer_backend
> *backend); +
> +// This function may sleep until all pending dma transfers for this
> backend +// have been finished.
> +extern void dmatransfer_unregister_backend(struct dmatransfer_backend
> *backend); +
> +#endif /* DMATRANSFER_H */
> +


> +#include <linux/dmatransfer.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +
> +static rwlock_t backend_list_lock = RW_LOCK_UNLOCKED;
> +static LIST_HEAD(backend_list);
> +
> +static int dmatransfer_request_worker(struct dmatransfer *transfer)
> +{
> +	enum dmatransfer_quality best_quality = DMATRANSFER_QUALITY_NO;
> +	struct dmatransfer_backend *best_backend = 0;
> +	int error_ret = -EINVAL;
> +	struct list_head *p;
> +
> +	// WARNING:
> +	// There is a non-critical race in this codepath: backend->check() may
> return +	// that the DMA request can be performed without spooling for two
> concurrently +	// running dmatransfer_request_worker() instances. If the
> backend has only one +	// free channel this will result in one request
> beeing executed without spooling +	// and the other one beeing spooled. So
> DMATRANSFER_NOSPOOL does not guarantee +	// that the request isn't spooled
> - just that we _try_ to avoid spooling. +

You appear to have a lot of overly long lines. Try to limit your code to less
than 80 characters per line.

> +struct dmatransfer *dmatransfer_malloc(int chunks_n, int flags)
> +{
> +	size_t transfer_size = sizeof(struct dmatransfer) + 2*sizeof(struct
> dmatransfer_chunk); +	struct dmatransfer *transfer = kmalloc(transfer_size,
> flags);
> +	memset(transfer, 0, transfer_size);

Use kzalloc instead kmalloc+memset.

> +void dmatransfer_register_backend(struct dmatransfer_backend *backend)
> +{
> +	unsigned long irqflags;
> +
> +	init_rwsem(&backend->unreg_sem);
> +
> +	write_lock_irqsave(&backend_list_lock, irqflags);
> +	INIT_LIST_HEAD(&backend->backend_list);
> +	list_add(&backend->backend_list, &backend_list);
> +	write_unlock_irqrestore(&backend_list_lock, irqflags);
> +}
> +
> +void dmatransfer_unregister_backend(struct dmatransfer_backend *backend)
> +{
> +	unsigned long irqflags;
> +	write_lock_irqsave(&backend_list_lock, irqflags);
> +	list_del(&backend->backend_list);
> +	write_unlock_irqrestore(&backend_list_lock, irqflags);
> +
> +	// make sure all pending requests have finished before returning
> +	down_write(&backend->unreg_sem);
> +	up_write(&backend->unreg_sem);
> +}

This usage of rw semaphores looks fishy. 

> +EXPORT_SYMBOL(dmatransfer_request_async);
> +EXPORT_SYMBOL(dmatransfer_request_wait);
> +
> +EXPORT_SYMBOL(dmatransfer_malloc);
> +EXPORT_SYMBOL(dmatransfer_release);
> +
> +EXPORT_SYMBOL(dmatransfer_finish);
> +
> +EXPORT_SYMBOL(dmatransfer_register_backend);
> +EXPORT_SYMBOL(dmatransfer_unregister_backend);

Please put the EXPORT_SYMBOL lines directly below the respective symbol definitions.
Also, make them EXPORT_SYMBOL_GPL() or explain why you don't. For new subsystems,
we normally don't use non-GPL exports any more.

> +#define CHANNEL_N 4
> +
> +static LIST_HEAD(spool);
> +static struct dmatransfer *spool_current_transfers[CHANNEL_N];
> +static spinlock_t spool_lock = SPIN_LOCK_UNLOCKED;

use DEFINE_SPINLOCK instead of assigning to SPIN_LOCK_UNLOCKED.

> +#define BIT(_name, _n) (1<<(_n))

I personally don't like such macros. Why don't you just define named
constants for the bits in there right position?

s/BIT(TE, 7)/DMASR_TE/

> +		iowrite32(transfer->chunks[0].bus_address,
> reg_map[i]+REG_OFFSET_DMASAR);
> +		iowrite32(transfer->chunks[1].bus_address,
> reg_map[i]+REG_OFFSET_DMADAR); +		iowrite32(transfer->chunks[1].bytecount, 
>  reg_map[i]+REG_OFFSET_DMABCR); +
> +		iowrite32(BIT(TE, 7) | BIT(EOSI, 1) | BIT(EOCDI, 0),
> reg_map[i]+REG_OFFSET_DMASR); +
> +		dmamr = 0;
> +		dmamr |= BIT(EOTIE, 7);
> +		dmamr |= BIT(CTM, 2);
> +		iowrite32(dmamr, reg_map[i]+REG_OFFSET_DMAMR);
> +
> +		dmamr |= BIT(CS, 0);
> +		iowrite32(dmamr, reg_map[i]+REG_OFFSET_DMAMR);
> +	}
> +}

iowrite32 is currently only well-defined for PCI devices, which I believe
this devide is not. Use out_be32 or out_le32 instead.

> +		if ((dmasr & (BIT(TE, 7) | BIT(EOCDI, 0))) != 0) {
> +			if ((dmasr & BIT(TE, 7)) != 0) {
> +				printk(KERN_ERR "MPC8349 DMA Transfer Error on DMA channel #%d.\n",
> i); +				BUG();
> +			} 

BUG() may be a little harsh here, especially since you are holding spinlocks.
It would be better to try to recover here, unless you expect actual data
corruption, in which case a full panic() might be more appropriate.

	Arnd <><
