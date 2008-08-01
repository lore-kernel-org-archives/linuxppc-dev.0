Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AA2ABDDF66
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:34:39 +1000 (EST)
Message-ID: <48932C78.9010303@ru.mvista.com>
Date: Fri, 01 Aug 2008 19:32:08 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: platforms/44x/warp-nand.c bogosity
References: <20080801151401.GC24735@cs181140183.pp.htv.fi>
	<20080801112628.35fb0ff2@zod.rchland.ibm.com>
In-Reply-To: <20080801112628.35fb0ff2@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Adrian Bunk <bunk@kernel.org>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Sean MacLennan <smaclennan@pikatech.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 1 Aug 2008 18:14:01 +0300
> Adrian Bunk <bunk@kernel.org> wrote:
> 
>> arch/powerpc/platforms/44x/warp-nand.c was added this year and updated 
>> quite recently.
>>
>> warp-nand.c is empty unless CONFIG_MTD_NAND_NDFC=y.
>>
>> MTD_NAND_NDFC depends on !PPC_MERGE.
>>
>> !PPC_MERGE can never be true on PPC now that arch/ppc/ got removed.
>>
>> So warp-nand.c is dead code, but that does not seem to be intentionally?
> 
> I don't believe it is intentional, no.  Sean can you look at this and
> see what's up?  I have a couple of fixes to queue up from you already
> and if you can get this one done in the next few days I'll included it
> as well.
> 
> josh

The current community ndfc driver won't build for arch/powerpc.
It still uses ioremap64 and includes <asm/ibm4xx.h> stuff.

Valentine.
