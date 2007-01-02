Return-Path: <linux-ppc@castalie.org>
Received: from tloen.castalie.org (tloen.castalie.org [213.41.240.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B17CFDDE40
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 05:09:54 +1100 (EST)
Date: Tue, 2 Jan 2007 19:09:44 +0100
From: Simon Vallet <linux-ppc@castalie.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Message-ID: <20070102190944.70c19799@mlejnas.priv.castalie.org>
In-Reply-To: <535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2 Jan 2007 18:16:01 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Well you normally never end up with an add with an @h -- you're
> typically adding it to something that is loaded with "li", i.e.,
> something that's the sign-extended version of the low 16 bits of
> the 32-bit thing you're loading totally.

Mmm... I might need to get a deeper understanding of apply_relocate_add(), 
but if I'm not mistaken, ha also uses high bits

> I'm interested how (and why :-) ) Darwin ends up doing it; could
> you send me the (original) file in question?  Or an otool -tvV
> of it, or part thereof that shows the problem.

Sure. As an example, here is some output of otool -rV and the corresponding 
disassembled text section part

Relocation information (__TEXT,__text) 61126 entries
address  pcrel length extern type    scattered symbolnum/value
00000664 False long   False  LO16    False     1 (__TEXT,__text)
         False long   False  PAIR    False     half = 0x0000
00000660 False long   False  HI16    False     1 (__TEXT,__text)
         False long   False  PAIR    False     half = 0x2738
00000654 False long   False  LO16    False     1 (__TEXT,__text)
         False long   False  PAIR    False     half = 0x0000
00000650 False long   False  HI16    False     1 (__TEXT,__text)
         False long   False  PAIR    False     half = 0x83fc

00000650        lis     r12,hi16(_msw_report_event)
00000654        ori     r12,r12,lo16(_msw_report_event)
00000658        mtspr   ctr,r12
0000065c        bctr
00000660        lis     r12,hi16(_PRINT_ERROR)
00000664        ori     r12,r12,lo16(_PRINT_ERROR)
00000668        mtspr   ctr,r12
0000066c        bctr

As for the two symbols:
000083fc T _msw_report_event
00002738 T _PRINT_ERROR

Just tell me if you need more info.

Simon
