Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D6362BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 06:59:26 +1000 (EST)
In-Reply-To: <000301c4b147$24be4460$5201a8c0@GEG2400>
References: <000301c4b147$24be4460$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <13F5C6B8-1D5B-11D9-88FA-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 13 Oct 2004 17:01:39 -0400
To: "Laurent Lagrange" <lagrange@fr.oleane.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8560 problem to launch user application like /sbin/init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 13, 2004, at 1:07 PM, Laurent Lagrange wrote:

> The console is mapped on SCC1 port.
> CCSRBAR is mapped at 0xF8000000 and immr at 0xF8080000.

I would suggest using the standard memory map the rest of
us use for 8560.  It makes the porting lots easier.

> I open 2 TLBs on memory and a big TLB for all IOs included CSSRBAR.
> Due to IO TLB, I don't io_remap cpm2_immr.

How do you to this?  The linux ppc kernel already manages all
of this mapping for you.

> All things run fine until I launch the /sbin/init file from a nfs 
> networK.

Seems like a memory mapping problem.  If you are using an 8260
file system, have you also enabled the math emulation in the kernel?

> I don't know if uboot sets other things than TLBs to access IOs
> and if my own boot is incomplete.
> I don't know if cpm must be io_remapped instead of using TLBs.

The u-boot will configure all of the LAWs, and like your boot rom
will also configure some of the TLBs for main memory mapping.
The Linux kernel will change all of the TLBs using the boot rom
TLB maps as a hint.

> Any ideas would be welcome.

Download linuxppc-2.4 from BitKeeper, use one of the existing
85xx ports as a guide for your board.  Keep things consistent
with the other board ports.  Take a look at one of the board
ports for u-boot to see how it configures the LAWs and TLBs.


	-- Dan
