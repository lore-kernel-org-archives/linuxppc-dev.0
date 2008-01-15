Return-Path: <SRS0=XpNt=SF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 15565DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 16:15:34 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD for Taco
Date: Tue, 15 Jan 2008 06:15:19 +0100
References: <477F12D1.2070109@pikatech.com> <200801142042.56847.sr@denx.de>
	<478BC05C.2080007@pikatech.com>
In-Reply-To: <478BC05C.2080007@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801150615.19910.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 January 2008, Sean MacLennan wrote:
> Stefan Roese wrote:
> > And the EBC0_BxCR & EBC0BxAP registers for the CS where the NAND is
> > connected? How are they configured?
>
> EBC0_B1CR d001c000
> EBC0_B1AP 18003c0
>
> Which matches the defines in include/configs/warp.h:
>
>     #define CFG_EBC_PB1AP        0x018003c0
>     #define CFG_EBC_PB1CR        (CFG_NAND_ADDR | 0x1c000)
>
> It also matches the defines in sequoia.h except that we are on CS1 and
> the sequoia is on CS3.

Right. One thing I noticed though is, that you map the NAND to 0xd0000000, 
which is reserved for PCI in the 440EP address space. I suggest you map it to 
0x90000000 as done on Bamboo. Please give it a try and let me know if this 
changes the 32bit access behavior.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
