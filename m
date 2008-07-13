Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CB408DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Jul 2008 17:30:19 +1000 (EST)
Subject: Re: insmod: unresolved symbol XIo_In32/XIo_Out32
From: Joachim Foerster <mls.JOFT@gmx.de>
To: Juliana Su <js084@bucknell.edu>
In-Reply-To: <4879046A.1020508@bucknell.edu>
References: <48776D93.5080504@bucknell.edu>
	<20080711183117.GD15321@secretlab.ca> <4877B04A.8090801@bucknell.edu>
	<20080711210514.GB18239@secretlab.ca> <4879046A.1020508@bucknell.edu>
Content-Type: text/plain
Date: Sun, 13 Jul 2008 09:30:15 +0200
Message-Id: <1215934215.2770.8.camel@md40100b.ft>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Sat, 2008-07-12 at 15:22 -0400, Juliana Su wrote:
> Ok, so I tried mapping to in_be32( ) and out_be32( ) by changing:
> 
> #define XIo_In32(InputPtr) (*(volatile u32 *)(InputPtr)); SYNCHRONIZE_IO; 
> to
> #define XIo_In32(InputPtr) in_be32(InputPtr)
> 
> and
> 
> #define XIo_Out32(OutputPtr, Value) \
>    { (*(volatile u32 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
> to
> #define XIo_Out32(OutputPtr, Value) out_be32(OutputPtr, Value)
> 
> I made sure to include asm-ppc/io.h, too. However, I still get the same 
> unresolved symbol error message... Did I do the mapping correctly? 

Hmmm, as Grant already said, you need to replace the _implementation_
(the actual function) by macros. You replaced a #define with another
#define - and a #define is not a symbol (for the compiler, only for
cpp). So - without knowing anything about your MontaVista Linux sources
- I think that the #defines you replaced are _not_ used, instead there
have to be some function _definition_ (in xio.h) you need to replace.

As an example: Xilinx also has a xio.h in their git tree. There one
would have to replace lines 167..173 in
http://git.xilinx.com/cgi-bin/gitweb.cgi?p=linux-2.6-xlnx.git;a=blob;f=drivers/xilinx_common/xio.h;h=7b22a677bbf7769d8698d37397f2174a2cd7e2b2;hb=HEAD

 Joachim
