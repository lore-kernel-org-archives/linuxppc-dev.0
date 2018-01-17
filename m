Return-Path: <srs0=dxb3=em=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMFyV4Z1yzF0Tn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 05:30:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zMFyV3bHdz8tCp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 05:30:42 +1100 (AEDT)
Subject: Re: [PATCH 3/5] powerpc/ftw: Implement a simple FTW driver
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1516157443-17716-4-git-send-email-sukadev@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e2d57c8c-9667-3b56-8d11-40d5430c9f05@infradead.org>
Date: Wed, 17 Jan 2018 10:30:37 -0800
MIME-Version: 1.0
In-Reply-To: <1516157443-17716-4-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/18 18:50, Sukadev Bhattiprolu wrote:
> The Fast Thread Wake-up (FTW) driver provides user space applications an
> interface to the low latency Core-to-Core wakeup functionality in POWER9.
> 
> This mechanism allows a thread on one core to efficiently send a message
> to a "waiting thread" on another core on the same chip, using the Virtual
> Accelrator Switchboard (VAS) subsystem.
> 
> This initial FTW driver implements the ioctl and mmap operations on an
> FTW device node. Using these operations, a pair of application threads
> can establish a "communication channel" and use the COPY, PASTE and WAIT
> instructions to wait/wake up.
> 
> PATCH 5/5 documents the API and includes an example of the usage.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v2]
> 	- [Michael Neuling] Rename from drop "nx" from name "nx-ftw".
> 	- [Michael Neuling] Use a single VAS_FTW_SETUP ioctl to simplify
> 	  interface.
> 	- [Michael Ellerman] To work with paste emulation patch, mark
> 	  PTE dirty in ->mmap() to ensure there is no fault on paste
> 	  (the emulation patch must disable pagefaults when updating
> 	  thread reconfig registers).
> 	- Check return value from set_thread_tidr().
> 	- Move driver drivers/misc/ftw.
> 
> ---
>  drivers/misc/Kconfig      |   1 +
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/ftw/Kconfig  |  16 +++
>  drivers/misc/ftw/Makefile |   4 +
>  drivers/misc/ftw/ftw.c    | 346 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 368 insertions(+)
>  create mode 100644 drivers/misc/ftw/Kconfig
>  create mode 100644 drivers/misc/ftw/Makefile
>  create mode 100644 drivers/misc/ftw/ftw.c

> +static long ftw_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +
> +	case FTW_SETUP:
> +		return ftw_ioc_ftw_setup(fp, arg);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

Nit:  some versions of gcc (or maybe clang) complain about a typed function
not always having a return value in code like above, so it is often done as:

> +static long ftw_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +
> +	case FTW_SETUP:
> +		return ftw_ioc_ftw_setup(fp, arg);
> +
> +	default:
> +		break;
> +	}

	return -EINVAL;
> +}

Do you expect to implement more ioctls?  If not, just change the switch to
an if ().

-- 
~Randy
