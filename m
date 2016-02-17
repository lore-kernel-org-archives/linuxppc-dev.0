Return-Path: <seroyer@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2247D1A03D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 08:18:32 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <seroyer@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 16:18:30 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 47C206E803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 16:05:19 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HLIRRG33816598
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 21:18:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HLIQpQ003214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 16:18:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 17 Feb 2016 15:18:26 -0600
From: Steven Royer <seroyer@linux.vnet.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Steven Royer <seroyer@us.ibm.com>
Subject: Re: [PATCH] add POWER Virtual Management Channel driver
In-Reply-To: <20160216221822.GA32255@kroah.com>
References: <1455655393-3137-1-git-send-email-seroyer@linux.vnet.ibm.com>
 <20160216221822.GA32255@kroah.com>
Message-ID: <e2c42d22f68dbb943363bfb6e06c8f79@imap.linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-02-16 16:18, Greg Kroah-Hartman wrote:
> On Tue, Feb 16, 2016 at 02:43:13PM -0600, Steven Royer wrote:
>> From: Steven Royer <seroyer@us.ibm.com>
>> 
>> The ibmvmc driver is a device driver for the POWER Virtual Management
>> Channel virtual adapter on the PowerVM platform.  It is used to
>> communicate with the hypervisor for virtualization management.  It
>> provides both request/response and asynchronous message support 
>> through
>> the /dev/ibmvmc node.
> 
> What is the protocol for that device node?
The protocol is not currently published.  I am pushing on getting it 
published, but that process will take time.  If you have a PowerVM 
system with NovaLink, it would not be hard to reverse engineer it...  If 
you don't have a PowerVM system, then this driver isn't interesting 
anyway...
> 
> Where is the documentation here?  Why does this have to be a character
> device?  Why can't it fit in with other drivers of this type?
This is a character device for historical reasons.  The short version is 
that this driver is a clean-room rewrite of an AIX driver which made it 
a character device.  The user space application was ported from AIX to 
Linux and it is convenient to have the AIX and Linux drivers match 
behavior where possible.
> 
>> 
>> Signed-off-by: Steven Royer <seroyer@linux.vnet.ibm.com>
>> ---
>> This is used by the PowerVM NovaLink project.  You can see development 
>> history on github:
>> https://github.com/powervm/ibmvmc
>> 
>>  Documentation/ioctl/ioctl-number.txt |    1 +
>>  MAINTAINERS                          |    5 +
>>  arch/powerpc/include/asm/hvcall.h    |    3 +-
>>  drivers/misc/Kconfig                 |    9 +
>>  drivers/misc/Makefile                |    1 +
>>  drivers/misc/ibmvmc.c                | 1882 
>> ++++++++++++++++++++++++++++++++++
>>  drivers/misc/ibmvmc.h                |  203 ++++
>>  7 files changed, 2103 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/misc/ibmvmc.c
>>  create mode 100644 drivers/misc/ibmvmc.h
>> 
>> diff --git a/Documentation/ioctl/ioctl-number.txt 
>> b/Documentation/ioctl/ioctl-number.txt
>> index 91261a3..d5f5f4f 100644
>> --- a/Documentation/ioctl/ioctl-number.txt
>> +++ b/Documentation/ioctl/ioctl-number.txt
>> @@ -324,6 +324,7 @@ Code  Seq#(hex)	Include File		Comments
>>  0xCA	80-8F	uapi/scsi/cxlflash_ioctl.h
>>  0xCB	00-1F	CBM serial IEC bus	in development:
>>  					<mailto:michael.klein@puffin.lb.shuttle.de>
>> +0xCC	00-0F	drivers/misc/ibmvmc.h	pseries VMC driver
>>  0xCD	01	linux/reiserfs_fs.h
>>  0xCF	02	fs/cifs/ioctl.c
>>  0xDB	00-0F	drivers/char/mwave/mwavepub.h
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index cc2f753..c39dca2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5353,6 +5353,11 @@ L:	netdev@vger.kernel.org
>>  S:	Supported
>>  F:	drivers/net/ethernet/ibm/ibmvnic.*
>> 
>> +IBM Power Virtual Management Channel Driver
>> +M:	Steven Royer <seroyer@linux.vnet.ibm.com>
>> +S:	Supported
>> +F:	drivers/misc/ibmvmc.*
>> +
>>  IBM Power Virtual SCSI Device Drivers
>>  M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>>  L:	linux-scsi@vger.kernel.org
>> diff --git a/arch/powerpc/include/asm/hvcall.h 
>> b/arch/powerpc/include/asm/hvcall.h
>> index e3b54dd..1ee6f2b 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -274,7 +274,8 @@
>>  #define H_COP			0x304
>>  #define H_GET_MPP_X		0x314
>>  #define H_SET_MODE		0x31C
>> -#define MAX_HCALL_OPCODE	H_SET_MODE
>> +#define H_REQUEST_VMC		0x360
>> +#define MAX_HCALL_OPCODE	H_REQUEST_VMC
>> 
>>  /* H_VIOCTL functions */
>>  #define H_GET_VIOA_DUMP_SIZE	0x01
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 054fc10..f8d9113 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -526,6 +526,15 @@ config VEXPRESS_SYSCFG
>>  	  bus. System Configuration interface is one of the possible means
>>  	  of generating transactions on this bus.
>> 
>> +config IBMVMC
>> +	tristate "IBM Virtual Management Channel support"
>> +	depends on PPC_PSERIES
>> +	help
>> +	  This is the IBM POWER Virtual Management Channel
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called ibmvmc.
>> +
>>  source "drivers/misc/c2port/Kconfig"
>>  source "drivers/misc/eeprom/Kconfig"
>>  source "drivers/misc/cb710/Kconfig"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 537d7f3..08336b3 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -56,3 +56,4 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
>>  obj-$(CONFIG_ECHO)		+= echo/
>>  obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
>>  obj-$(CONFIG_CXL_BASE)		+= cxl/
>> +obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
>> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
>> new file mode 100644
>> index 0000000..fb943b7
>> --- /dev/null
>> +++ b/drivers/misc/ibmvmc.c
>> @@ -0,0 +1,1882 @@
>> +/*
>> + * IBM Power Systems Virtual Management Channel Support.
>> + *
>> + * Copyright (c) 2004, 2016 IBM Corp.
>> + *   Dave Engebretsen engebret@us.ibm.com
>> + *   Steven Royer seroyer@linux.vnet.ibm.com
>> + *   Adam Reznechek adreznec@linux.vnet.ibm.com
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
> 
> I have to ask, but do you really mean "or any later version"?
This actually matches closely to other similar PowerVM virtual device 
drivers, like ibmvscsi or ibmveth.
> 
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/major.h>
>> +#include <linux/string.h>
>> +#include <linux/fcntl.h>
>> +#include <linux/slab.h>
>> +#include <linux/poll.h>
>> +#include <linux/init.h>
>> +#include <linux/fs.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/percpu.h>
>> +#include <linux/delay.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/io.h>
>> +#include <linux/device.h>
>> +
>> +#include <asm/byteorder.h>
>> +#include <asm/irq.h>
>> +#include <asm/vio.h>
> 
> Why are these asm files needed?
I did that research once before and I think I need them, but I don't 
recall the details now.  I'll revisit.
> 
>> +
>> +#include "ibmvmc.h"
> 
> Why do you have a .h file for a single-file driver?  That shouldn't be
> needed at all, unless you have an odd user api, and if so, it better be
> documented...
I did this to match other PowerVM drivers, like ibmveth.  I'm not 
particularly attached to this model and am willing to change if you 
prefer.
> 
>> +
>> +#define IBMVMC_DRIVER_VERSION "1.0"
>> +
>> +MODULE_DESCRIPTION("IBM VMC");
>> +MODULE_AUTHOR("Steven Royer <seroyer@linux.vnet.ibm.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_VERSION(IBMVMC_DRIVER_VERSION);
>> +
>> +
>> +/*
>> + * Static global variables
>> + */
>> +static DECLARE_WAIT_QUEUE_HEAD(ibmvmc_read_wait);
>> +
>> +static const char ibmvmc_driver_name[] = "ibmvmc";
>> +static const char ibmvmc_workq_name[] = "ibmvmc";
>> +
>> +static struct ibmvmc_struct ibmvmc;
>> +static struct ibmvmc_hmc hmcs[MAX_HMCS];
>> +static struct crq_server_adapter ibmvmc_adapter;
>> +static dev_t ibmvmc_chrdev;
>> +
>> +static int ibmvmc_max_buf_pool_size = DEFAULT_BUF_POOL_SIZE;
>> +static int ibmvmc_max_hmcs = DEFAULT_HMCS;
>> +static int ibmvmc_max_mtu = DEFAULT_MTU;
>> +static struct class *ibmvmc_class;
>> +struct device *ibmvmc_dev;
> 
> Those are huge flags to me, why would you ever have a static pointer to
> a device?  You should never deal with a "raw" struct device, unless
> something is really odd...
Agree.  I'll fix this.
> 
>> +
>> +/* Module parameters */
>> +module_param_named(buf_pool_size, ibmvmc_max_buf_pool_size,
>> +		   int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(buf_pool_size, "Buffer pool size");
>> +module_param_named(max_hmcs, ibmvmc_max_hmcs, int, S_IRUGO | 
>> S_IWUSR);
>> +MODULE_PARM_DESC(max_hmcs, "Max HMCs");
>> +module_param_named(max_mtu, ibmvmc_max_mtu, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(max_mtu, "Max MTU");
>> +
>> +
>> +static inline long h_copy_rdma(s64 length, u64 sliobn, u64 slioba,
>> +	u64 dliobn, u64 dlioba)
>> +{
>> +	long rc = 0;
>> +
>> +	/* Ensure all writes to source memory are visible before hcall */
>> +	mb();
>> +	pr_debug("ibmvmc: h_copy_rdma(0x%llx, 0x%llx, 0x%llx, 0x%llx, 
>> 0x%llx\n",
>> +			length, sliobn, slioba, dliobn, dlioba);
> 
> It's a driver, use dev_dbg() please.
Agree.
> 
>> +	rc = plpar_hcall_norets(H_COPY_RDMA, length, sliobn, slioba,
>> +			dliobn, dlioba);
>> +	pr_debug("ibmvmc: h_copy_rdma rc = 0x%lx\n", rc);
>> +
>> +	return rc;
>> +}
>> +
>> +static inline void h_free_crq(uint32_t unit_address)
>> +{
>> +	long rc = 0;
>> +
>> +	do {
>> +		if (H_IS_LONG_BUSY(rc))
>> +			msleep(get_longbusy_msecs(rc));
>> +
>> +		rc = plpar_hcall_norets(H_FREE_CRQ, unit_address);
>> +	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
> 
> endless loop?  Not good.
This is actually required on PowerVM.  This is a purely virtual device.  
If you look at other PowerVM drivers, you'll see more or less identical 
code.  i.e., ibmvscsi.
> 
>> +}
>> +
>> +/**
>> + * h_request_vmc: - request a hypervisor virtual management channel 
>> device
>> + * @vmc_index: drc index of the vmc device created
>> + *
>> + * Requests the hypervisor create a new virtual management channel 
>> device,
>> + * allowing this partition to send hypervisor virtualization control 
>> commands.
>> + *
>> + */
>> +static inline long h_request_vmc(u32 *vmc_index)
>> +{
>> +	long rc = 0;
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>> +
>> +	do {
>> +		if (H_IS_LONG_BUSY(rc))
>> +			msleep(get_longbusy_msecs(rc));
>> +
>> +		/* Call to request the VMC device from phyp */
>> +		rc = plpar_hcall(H_REQUEST_VMC, retbuf);
>> +		pr_debug("ibmvmc: h_request_vmc rc = 0x%lx\n", rc);
>> +		*vmc_index = retbuf[0];
>> +	} while ((rc == H_BUSY) || (H_IS_LONG_BUSY(rc)));
> 
> Another endless loop?  Your hardware must never fail :)
> 
>> +
>> +	return rc;
>> +}
>> +
>> +/* routines for managing a command/response queue */
>> +/**
>> + * ibmvmc_handle_event: - Interrupt handler for crq events
>> + * @irq:        number of irq to handle, not used
>> + * @dev_instance: crq_server_adapter that received interrupt
>> + *
>> + * Disables interrupts and schedules ibmvmc_task
>> + * Always returns IRQ_HANDLED
>> + */
>> +static irqreturn_t ibmvmc_handle_event(int irq, void *dev_instance)
>> +{
>> +	struct crq_server_adapter *adapter =
>> +		(struct crq_server_adapter *)dev_instance;
>> +
>> +	vio_disable_interrupts(to_vio_dev(adapter->dev));
>> +	queue_work(adapter->work_queue, &adapter->work);
>> +
>> +	return IRQ_HANDLED;
> 
> No shared interrupt handling?
I'll do some investigation here, but again, this matches almost exactly 
how other similar PowerVM drivers work (ibmvscsi).
> 
>> +}
>> +
>> +	/* Dynamically allocate ibmvmc major number */
>> +	if (alloc_chrdev_region(&ibmvmc_chrdev, 0, VMC_NUM_MINORS,
>> +		ibmvmc_driver_name)) {
>> +		pr_err("ibmvmc: unable to allocate a dev_t\n");
>> +		rc = -EIO;
>> +		goto alloc_chrdev_failed;
>> +	}
> 
> A whole major number for one minor?  Use the misc class instead please.
Agree.
> 
> And finally, you only have a self-sign-off here, which is fine for
> trivial stuff, but I want to see that other people actually believe 
> this
> code is correct and they agree with it.  Get others to review it first
> before making the community (i.e. me) do their work for them.  IBM has 
> a
> whole bunch of people that do this as part of their job, don't ignore
> them...
Sorry, this was my fault.  It was reviewed at IBM but I neglected to 
include the sign-off statements.  Thanks for taking the time to review 
this.
> 
> bah.
> 
> greg k-h
