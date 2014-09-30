Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EE7F1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:26:57 +1000 (EST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE4B11400E0
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2014 15:26:56 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 10:56:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3AFCFE0045
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2014 10:59:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U5T8NU5308672
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2014 10:59:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U5Qn2D028775
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2014 10:56:50 +0530
Message-ID: <542A3E51.5030701@linux.vnet.ibm.com>
Date: Tue, 30 Sep 2014 10:53:29 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc, powernv: Add OPAL platform event driver
References: <1411986209-16800-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1411986209-16800-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09/29/2014 03:53 PM, Anshuman Khandual wrote:
> This patch creates a new OPAL platform event character driver
> which will give userspace clients the access to these events
> and process them effectively. Following platforms events are
> currently supported with this platform driver.
>
> 	(1) Environmental and Power Warning (EPOW)
> 	(2) Delayed Power Off (DPO)
>
> The user interface for this driver is /dev/opal_event character
> device file where the user space clients can poll and read for
> new opal platform events. The expected sequence of events driven
> from user space should be like the following.
>
> 	(1) Open the character device file
> 	(2) Poll on the file for POLLIN event
> 	(3) When unblocked, must attempt to read PLAT_EVENT_MAX_SIZE size
> 	(4) Kernel driver will pass at most one opal_plat_event structure
> 	(5) Poll again for more new events
>
> The driver registers for OPAL messages notifications corresponding to
> individual OPAL events. When any of those event messages arrive in the
> kernel, the callbacks are called to process them which in turn unblocks
> the polling thread on the character device file. The driver also registers
> a timer function which will be called after a threshold amount of time to
> shutdown the system. The user space client receives the timeout value for
> all individual OPAL platform events and hence must prepare the system and
> eventually shutdown. In case the user client does not shutdown the system,
> the timer function will be called after the threshold and shutdown the
> system explicitly.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Reviewed-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

- Neelesh

> ---
>   arch/powerpc/include/asm/opal.h                    |  45 +-
>   .../include/uapi/asm/opal_platform_events.h        |  90 +++
>   arch/powerpc/platforms/powernv/Makefile            |   2 +-
>   .../platforms/powernv/opal-platform-events.c       | 737 +++++++++++++++++++++
>   arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
>   arch/powerpc/platforms/powernv/opal.c              |   8 +-
>   6 files changed, 880 insertions(+), 3 deletions(-)
>   create mode 100644 arch/powerpc/include/uapi/asm/opal_platform_events.h
>   create mode 100644 arch/powerpc/platforms/powernv/opal-platform-events.c
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 86055e5..c134137 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -151,6 +151,7 @@ struct opal_sg_list {
>   #define OPAL_HANDLE_HMI				98
>   #define OPAL_REGISTER_DUMP_REGION		101
>   #define OPAL_UNREGISTER_DUMP_REGION		102
> +#define OPAL_GET_DPO_STATUS			105
>   
>   #ifndef __ASSEMBLY__
>   
> @@ -249,6 +250,7 @@ enum OpalMessageType {
>   	OPAL_MSG_EPOW,
>   	OPAL_MSG_SHUTDOWN,
>   	OPAL_MSG_HMI_EVT,
> +	OPAL_MSG_DPO,
>   	OPAL_MSG_TYPE_MAX,
>   };
>   
> @@ -417,6 +419,46 @@ struct opal_msg {
>   	__be64 params[8];
>   };
>   
> +/*
> + * EPOW status sharing (OPAL and the host)
> + *
> + * The host will pass on OPAL, a buffer of length OPAL_SYSEPOW_MAX
> + * with individual elements being 16 bits wide to fetch the system
> + * wide EPOW status. Each element in the buffer will contain the
> + * EPOW status in it's bit representation for a particular EPOW sub
> + * class as defiend here. So multiple detailed EPOW status bits
> + * specific for any sub class can be represented in a single buffer
> + * element as it's bit representation.
> + */
> +
> +/* System EPOW type */
> +enum OpalSysEpow {
> +	OPAL_SYSEPOW_POWER	= 0,	/* Power EPOW */
> +	OPAL_SYSEPOW_TEMP	= 1,	/* Temperature EPOW */
> +	OPAL_SYSEPOW_COOLING	= 2,	/* Cooling EPOW */
> +	OPAL_SYSEPOW_MAX	= 3,	/* Max EPOW categories */
> +};
> +
> +/* Power EPOW */
> +enum OpalSysPower {
> +	OPAL_SYSPOWER_UPS	= 0x0001, /* System on UPS power */
> +	OPAL_SYSPOWER_CHNG	= 0x0002, /* System power config change */
> +	OPAL_SYSPOWER_FAIL	= 0x0004, /* System impending power failure */
> +	OPAL_SYSPOWER_INCL	= 0x0008, /* System incomplete power */
> +};
> +
