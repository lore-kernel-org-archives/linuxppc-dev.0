Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8B44DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 05:04:34 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A166@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A166@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E54085E-FFA1-4C06-A130-3DFB21EB523A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: understanding an IO question
Date: Wed, 21 Feb 2007 12:03:36 -0600
To: Charles Krinke <ckrinke@istor.com>
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

> Dear Kumar:
>
> I hope all is well with you and I appreciate your taking time to  
> have a
> mini-dialog with me today.

No problem.  If you're ever in Austin, buy me a beer ;)
> Here's the deal. First of all, we are using the linux-2.6.17.11 code
> base from kernel.org, which was the latest one when this project
> started. We have validated that our driver, with no modifications,  
> works
> fine on our existing production 8241 board with this kernel. This  
> driver
> does use ioremap_nocache(), request_region() and other common
> driver-type calls, so I suspect the issue is the kernel is not setup
> quite right for the driver, not that the driver needs modification for
> the kernel.
>
> Starting from that premise, I know that we depend on outbound address
> translation windows and any necessary TLB setup to get access to  
> the CPU
> address region around 0x8400_0000.
>
> The reason for the outbound address translation windows has to do with
> the fact that we use a DAC (Dual Address Cycle) to a 64bit PCI address
> at 0x1_0000_0000 or 0x3_0000_0000 depending on whether we are
> writing/reading to the window at 0x8800_0000 or 0x8400_0000.

This does all seem odd.  The fact that it works fine from u-boot but  
not the kernel gets me.

> One thing that puzzles me is that a 'cat /proc/iomem' shows a PCI  
> window
> is setup in Linux, like this
>
>>> cat /proc/iomem
>>> 80000000-9fffffff : PCI1 host bridge
>
> I don't see anywhere in the Linux-2.6.17.11 code base where this  
> window
> is setup. Perhaps you could point me towards the section of code where
> this is done.

This is done in arch/ppc/syslib/ppc85xx_setup.c in mpc85xx_setup_hose 
().  And now that I look at it I think I was lying before about not  
setting up outbound windows.  (I'm thinking newer kernels).

Maybe something in mpc85xx_setup_hose() is causing you issues.  I'd  
suggest dumping the pci law* from u-boot and doing the same in the  
kernel and make sure they match.

> On the ioremap()/ioremap_nocache() issue. I did look at the source in
> the kernel for ioremp_nocache() and it is #defined to be ioremap(),  
> so I
> think it is safe to assume they are the same.

Ok, just thinking of what might be going on.

- k
