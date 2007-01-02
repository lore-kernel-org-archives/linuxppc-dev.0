Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E057EDDEC3
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 07:49:02 +1100 (EST)
In-Reply-To: <20070102190944.70c19799@mlejnas.priv.castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
	<20070102190944.70c19799@mlejnas.priv.castalie.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0e6a409d0ffedd23495d2aed672632dd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Date: Tue, 2 Jan 2007 21:48:31 +0100
To: Simon Vallet <linux-ppc@castalie.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sure. As an example, here is some output of otool -rV and the 
> corresponding
> disassembled text section part
>
> Relocation information (__TEXT,__text) 61126 entries
> address  pcrel length extern type    scattered symbolnum/value
> 00000654 False long   False  LO16    False     1 (__TEXT,__text)
>          False long   False  PAIR    False     half = 0x0000
> 00000650 False long   False  HI16    False     1 (__TEXT,__text)
>          False long   False  PAIR    False     half = 0x83fc
>
> 00000650        lis     r12,hi16(_msw_report_event)
> 00000654        ori     r12,r12,lo16(_msw_report_event)

Ah.  lis and ori.  HI16 is just fine there -- but note that
that doesn't use an add insn.  You're patching the function
"apply_relocate_add()", so I guess some more work is needed?


Segher
