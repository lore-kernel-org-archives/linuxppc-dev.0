Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 519D5B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Feb 2011 06:39:31 +1100 (EST)
Date: Wed, 16 Feb 2011 13:24:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: Using CONFIG_PHYSICAL_START
Message-ID: <20110216132403.3466a83e@schlenkerla>
In-Reply-To: <4D5C10B9.9010702@mentor.com>
References: <4D5C10B9.9010702@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Feb 2011 12:00:25 -0600
Meador Inge <meador_inge@mentor.com> wrote:

> Hi Kumar,
> 
> Quick question about the support for booting at a non-zero base address 
> (as committed here: 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=37dd2badcfcec35f5e21a0926968d77a404f03c3). 
>   Is booting from a non-zero address as simple as changing 
> "CONFIG_PHYSICAL_START" (assuming it meets the alignment constraints, of 
> course)?

Another option is to turn on CONFIG_RELOCATABLE.  Note that you'll still
have the same alignment constraints; it doesn't generate a truly relocatable
binary (the effective addresses are fixed).  But you don't have to specify
the physical address at compile-time.  This allows you to use the same
kernel image for multiple AMP partitions.

> For example, I want to boot from a non-zero address on the P1022DS.  I 
> should just be able to change "CONFIG_PHYSICAL_START" to, say, 
> 0x08000000, and it should work, right?  Any other bits that need to be 
> done (i.e. U-Boot or device tree magic)?

You'll want the memory node adjusted for your restricted address range
(I'm assuming that this is why you want to start at non-zero, and that
you're not trying to have the kernel be located in the middle of its
partition).

There are some special u-boot variables (bootm_low/bootm_size) that govern
placement of the kernel, fdt, etc.

-Scott
