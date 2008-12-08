Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54116DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 05:06:32 +1100 (EST)
Date: Mon, 8 Dec 2008 12:09:36 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jhsiao@amcc.com
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v4]
Message-Id: <20081208120936.28721efb.kim.phillips@freescale.com>
In-Reply-To: <1228519451.5444.59.camel@jhsiao-usb>
References: <1228256232.4770.47.camel@jhsiao-usb>
	<20081204193256.12dbc306.kim.phillips@freescale.com>
	<1228519451.5444.59.camel@jhsiao-usb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 05 Dec 2008 15:24:11 -0800
James Hsiao <jhsiao@amcc.com> wrote:

> Without the check, nbytes could become negative. The aead test case
> with .np will crash(ie. gcm tests), those test  have sg->length >
> nbytes.
> 
> About aad_len, we didn't release code that use aad yet. We did test this
> function with aad_len none zero(the gcm tests).

ok - btw, it would be nice if these submissions were more
self-consistent, that way we could see how aad_len is being assigned.

> About the irq_disable or spin_lock. 
> The driver could be used by a kernel thread and esp4 at same time. As I
> know process is preemptable. When the driver is used by a process it is
> possible to be preempted. The hardware require scatter/gather descriptor
> to be consecutive. So, if the process get a gather descriptor and then
> it is preempted by another process or esp4 which get a gather descriptor
> and return to the original process, the origianl process could get a non
> consecutive gather descriptor.   
> So, if spin_lock is recommended then I have to use spin_lock_irq_save,
> which use irq_disable too. Do you think that is acceptable? 

yes.

Thanks,

Kim
