Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id EA38BDDF00
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Apr 2007 16:27:11 +1000 (EST)
Date: Mon, 23 Apr 2007 08:27:06 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: RonLee <rlee@osii.com>
Subject: Re: mpc5200 linux 2.4 wakeup interrupt problem
Message-ID: <20070423062706.GW18236@moe.telargo.com>
References: <10111122.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10111122.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 20/04/07 15:07 -0700, RonLee wrote:
> 
> Hello,
>  
> I am running linux on a mpc5200 chip and Im having problems with the
> mpc5200's simple and wakeup interrupts.  The version of Linux I am starting
> with is linuxppc_2_4_devel_1_0_0 from Denx.  Modifications have been made to
> the kernel, but none for enabling the wakeup register set and/or the wakeup
> interrupts.
>  
> Does a patch exist to enable this behavior?  Can anyone point me in the
> right direction if I would like to enable the wakeup interrupts myself?
>  
> I noticed the behavior when attempting to write a device driver to interface
> with the psc1_4 pin on the mpc5200 chip.  I am able to get the chip to
> generate interrupts, but when the interrupts occur I get the following error
> message in /proc/kmsg "Unhandled interrupt c, disabled".  After getting this
> error, I installed an interrupt handler on IRQ 12 (hex c).  This caused the
> kernel to lock up.

Maybe you forgot to acknowledge the IRQ (and so it always reenters your
handler). For gpio wakeup interrupts see wkup_istat (MBAR+0xc24).

HTH

	Domen
>  
> Thanks for any help,
> -Ron
