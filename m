Return-Path: <bergner@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0BB0DE03B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 03:36:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n37HXFnw014973
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 13:33:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n37HaYA4091342
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 13:36:34 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n37HaXd8013852
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 13:36:34 -0400
Subject: Re: [PATCH] powerpc: Fix tlbilx opcode
From: Peter Bergner <bergner@vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1239050219-4477-1-git-send-email-galak@kernel.crashing.org>
References: <1239050219-4477-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 07 Apr 2009 12:36:32 -0500
Message-Id: <1239125792.7557.7.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-04-06 at 15:36 -0500, Kumar Gala wrote:
> The tlbilx opcode was not matching the Power ISA 2.06 arch spec.
> The old opcode was an early suggested opcode that changed during the
> 2.06 architecture process.
[snip]
>  #define PPC_INST_STSWI			0x7c0005aa
>  #define PPC_INST_STSWX			0x7c00052a
> -#define PPC_INST_TLBILX			0x7c000626
> +#define PPC_INST_TLBILX			0x7c000024
>  #define PPC_INST_WAIT			0x7c00007c

How do you want to handle the current binutils code that implements tlbilx
and its extended mnemonics?  Should they be changed to use secondary opcode
18 instead of 787 as per the ISA 2.06 doc?

  {"tlbilx",      X(31,787),      X_MASK,      E500MC,    PPCNONE,        {T, RA0, RB}},
  {"tlbilxlpid",  XTO(31,787,0),  XTO_MASK,    E500MC,    PPCNONE,        {0}},
  {"tlbilxpid",   XTO(31,787,1),  XTO_MASK,    E500MC,    PPCNONE,        {0}},
  {"tlbilxva",    XTO(31,787,3),  XTO_MASK,    E500MC,    PPCNONE,        {RA0, RB}},

If you want to change the tlbilx entry to use 18 rather than 787, let me
know whether you want me to make the change or whether you (Edmar?) will
handle it.

I'll note the extended mnemonics should be moved before tlbilx so that the
disassembler will use them (if appropriate) instead of the base instruction.


Peter
