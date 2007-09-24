Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 925EBDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 09:42:15 +1000 (EST)
Date: Mon, 24 Sep 2007 18:42:10 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Dave Cogley" <dcogley@uslinc.com>
Subject: Re: EBC peripheral, access causing Machine Check
Message-ID: <20070924184210.484d39b3@vader.jdub.homelinux.org>
In-Reply-To: <005301c7fedf$c46f7770$9601a8c0@DCOGLEYNEW>
References: <005301c7fedf$c46f7770$9601a8c0@DCOGLEYNEW>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 24 Sep 2007 12:19:01 -0700
"Dave Cogley" <dcogley@uslinc.com> wrote:

> Good Afternoon,
> 
>  
> 
> I am using an AMCC 440EPx processor with an FPGA peripheral attached to the
> EBC.  I am doing the entire bank configuration in the u-boot boot loader
> before Linux is loaded.  I can directly read and write registers using
> memory read and write (md, nm) within area 0xC0000000 to 0xC000FFFF direct
> memory I/O within the context of u-boot without any faults.  When I attempt
> to access any register in area 0xC000000 within the context of my Linux
> device driver I get a Machine Check fault (attached text) which appears to
> be an access permission violation.  I am currently running the DENX ELDK
> 2.6.19.2 platform that was specific to the "Sequoia" platform.
> 
>  
> 
> I have configured the EBC access permissions and control resisters as
> follows for bank 1:
> 
>  
> 
> PB1CR: 0xC003C000
> 
> PB1AP: 0x80040380

You need proper TLB entries set up before you can access things.  Linux
discards the MMU settings that U-Boot does.  So your driver needs to call 
ioremap on the physical address. 

Other than that, we can't help you much without your driver code.

josh
