Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9811E1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 11:32:40 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Fri, 26 Sep 2014 11:32:38 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 81D482CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 11:32:36 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8Q1EM0W262410
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 11:14:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8Q1WZF8022083
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 11:32:36 +1000
Message-ID: <1411695162.2783.53.camel@cyril>
Subject: Re: [PATCH v2 2/3] powerpc/pseries: create rtas buffer accessor
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 26 Sep 2014 11:32:42 +1000
In-Reply-To: <54249B94.2070908@linux.vnet.ibm.com>
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
 <1411627290-20302-3-git-send-email-cyril.bur@au1.ibm.com>
 <54249B94.2070908@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-25 at 15:47 -0700, Tyrel Datwyler wrote:
> On 09/24/2014 11:41 PM, Cyril Bur wrote:
> > Added simple accessor functions for rtas in memory buffers which performs
> > accesses of appropriate type and performs endian conversions.
> > 
> > Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/Makefile      |   4 +-
> >  arch/powerpc/platforms/pseries/pseries.h     |  41 +++++++++
> >  arch/powerpc/platforms/pseries/rtas_buffer.c | 126 +++++++++++++++++++++++++++
> >  3 files changed, 170 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/powerpc/platforms/pseries/rtas_buffer.c
> 
> Maybe Michael has an opinion here, but seems to me since this is all
> RTAS related it would make sense for this code to belong in
> kernel/rtas.c and include/asm/rtas.h.
> 
Could quite possibly go there, I wanted to get the code looked at first
but I'll take a look if it could be used more generally and if so move.

Thanks

> -Tyrel
> 
> > 
> > diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> > index 0348079..7eb7c46 100644
> > --- a/arch/powerpc/platforms/pseries/Makefile
> > +++ b/arch/powerpc/platforms/pseries/Makefile
> > @@ -3,7 +3,9 @@ ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
> >  
> >  obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
> >  			   setup.o iommu.o event_sources.o ras.o \
> > -			   firmware.o power.o dlpar.o mobility.o rng.o
> > +			   firmware.o power.o dlpar.o mobility.o \
> > +			   rng.o rtas_buffer.o
> > +
> >  obj-$(CONFIG_SMP)	+= smp.o
> >  obj-$(CONFIG_SCANLOG)	+= scanlog.o
> >  obj-$(CONFIG_EEH)	+= eeh_pseries.o
> > diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> > index 361add6..f24e352 100644
> > --- a/arch/powerpc/platforms/pseries/pseries.h
> > +++ b/arch/powerpc/platforms/pseries/pseries.h
> > @@ -66,4 +66,45 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
> >  
> >  unsigned long pseries_memory_block_size(void);
> >  
> > +/* Manipulation of the in memory data returned from an RTAS call */
> > +
> > +/* Data pointed to by ptr is in big endian */
> > +struct rtas_buffer {
> > +	void *ptr;
> > +	int len;
> > +	int pos;
> > +};
> > +
> > +/* Buffer is already zeroed */
> > +int make_rtas_buf(struct rtas_buffer *b, size_t size);
> > +void free_rtas_buf(struct rtas_buffer *b);
> > +
> > +/* Return pointer to the buffer being used */
> > +void *get_rtas_buf(struct rtas_buffer *b);
> > +
> > +/* Checks if the buffer exists and the read position is less than the length*/
> > +bool check_rtas_buf(struct rtas_buffer *b);
> > +size_t get_rtas_buf_size(struct rtas_buffer *b);
> > +
> > +/* Advance the internal position of the buffer by size bytes */
> > +bool advance_rtas_buf(struct rtas_buffer *b, size_t size);
> > +
> > +/* Put a value val into the buffer at position pos. Function expect val in cpu
> > + * endian. Returns true if the write to the buffer was successful.
> > + */
> > +bool put_rtas_buf_32(struct rtas_buffer *b, u32 val, int pos);
> > +
> > +/* Grab the byte at the current position of the buffer without incrementing
> > + * the internal position of the buffer */
> > +bool peek_rtas_buf(struct rtas_buffer *b, u8 *c);
> > +
> > +/* Accessor functions return true if access succeeded and value is written to
> > + * val in cpu endian. Automatically advances its reference into the buffer by
> > + * the requested amount.
> > + */
> > +bool get_rtas_buf_32(struct rtas_buffer *b, u32 *val);
> > +bool get_rtas_buf_64(struct rtas_buffer *b, u64 *val);
> > +bool get_rtas_buf_mem(struct rtas_buffer *b, void **p, size_t len);
> > +bool get_rtas_buf_str(struct rtas_buffer *b, char **s);
> > +
> >  #endif /* _PSERIES_PSERIES_H */
> > diff --git a/arch/powerpc/platforms/pseries/rtas_buffer.c b/arch/powerpc/platforms/pseries/rtas_buffer.c
> > new file mode 100644
> > index 0000000..f06b73c
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/pseries/rtas_buffer.c
> > @@ -0,0 +1,126 @@
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +
> > +#include "pseries.h"
> > +
> > +
> > +int make_rtas_buf(struct rtas_buffer *b, size_t sz)
> > +{
> > +	b->ptr = kzalloc(sz, GFP_KERNEL);
> > +	b->len = sz;
> > +	b->pos = 0;
> > +	return (!b->ptr) ? -ENOMEM : 0;
> > +}
> > +
> > +void free_rtas_buf(struct rtas_buffer *b)
> > +{
> > +	kfree(b->ptr);
> > +}
> > +
> > +void *get_rtas_buf(struct rtas_buffer *b)
> > +{
> > +	return (b) ? b->ptr : NULL;
> > +}
> > +
> > +size_t get_rtas_buf_size(struct rtas_buffer *b)
> > +{
> > +	return (b) ? b->len : 0;
> > +}
> > +
> > +bool check_rtas_buf(struct rtas_buffer *b)
> > +{
> > +	return (b && b->ptr && b->pos < b->len);
> > +}
> > +
> > +static inline void *buf_pos(struct rtas_buffer *b)
> > +{
> > +	return (b && b->ptr) ? b->ptr + b->pos : NULL;
> > +}
> > +
> > +bool peek_rtas_buf(struct rtas_buffer *b, u8 *c)
> > +{
> > +	if (!b || !c || b->pos >= b->len)
> > +		return false;
> > +
> > +	*c = *(u8 *)buf_pos(b);
> > +
> > +	return true;
> > +}
> > +
> > +bool put_rtas_buf_32(struct rtas_buffer *b, u32 val, int pos)
> > +{
> > +	if (!b || b->pos >= b->len)
> > +		return false;
> > +
> > +	*((__be32 *)buf_pos(b)) = cpu_to_be32(val);
> > +
> > +	return true;
> > +}
> > +
> > +bool get_rtas_buf_32(struct rtas_buffer *b, u32 *val)
> > +{
> > +	if (!b || !val || b->len - b->pos < sizeof(u32))
> > +		return false;
> > +
> > +	*val = be32_to_cpu(*((__be32 *)buf_pos(b)));
> > +	b->pos += sizeof(u32);
> > +	return true;
> > +}
> > +
> > +bool get_rtas_buf_64(struct rtas_buffer *b, u64 *val)
> > +{
> > +	if (!b || !val || b->len - b->pos < sizeof(u64))
> > +		return false;
> > +
> > +	*val = be64_to_cpu(*((__be64 *)buf_pos(b)));
> > +	b->pos += sizeof(u64);
> > +	return true;
> > +}
> > +
> > +bool get_rtas_buf_str(struct rtas_buffer *b, char **s)
> > +{
> > +	int i;
> > +	if (!b || !s)
> > +		return false;
> > +
> > +	/* Get length of string */
> > +	i = b->pos;
> > +	while (i < b->len) {
> > +		if (*(char *)(b->ptr + i) == '\0') {
> > +			*s = (char *)buf_pos(b);
> > +			if (!*s)
> > +				return false;
> > +
> > +			b->pos = i + 1;
> > +			return true;
> > +		}
> > +		i++;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +bool get_rtas_buf_mem(struct rtas_buffer *b, void **p, size_t len)
> > +{
> > +	if (!b || !p || b->len - b->pos < len)
> > +		return false;
> > +
> > +	*p = buf_pos(b);
> > +	if (!*p)
> > +		return false;
> > +
> > +	b->pos += len;
> > +
> > +	return true;
> > +}
> > +
> > +bool advance_rtas_buf(struct rtas_buffer *b, size_t len)
> > +{
> > +	if (!b || b->len - b->pos < len)
> > +		return false;
> > +
> > +	b->pos += len;
> > +
> > +	return true;
> > +}
> > +
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
