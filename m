Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW8H01Bg3zDwJv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:41:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
In-Reply-To: <87twalxovd.fsf@concordia.ellerman.id.au>
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
 <CAKTCnzkAaKNtcTOGuyO=kkjFGFSObGeEf+Dy0qvTM7xXit5dJg@mail.gmail.com>
 <87twalxovd.fsf@concordia.ellerman.id.au>
Date: Sat, 03 Dec 2016 22:40:58 +1100
Message-ID: <87mvgdxmt1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Balbir Singh <bsingharora@gmail.com> writes:
>
>> <snip>
>>
>>>  static void __init radix_init_partition_table(void)
>>>  {
>>> -       unsigned long rts_field;
>>> +       unsigned long rts_field, ptcr;
>>
>> I think these functions have changed, check for conflicts against
>> http://git.kernel.org/cgit/linux/kernel/git/paulus/powerpc.git/commit/?h=kvm-ppc-next&id=9d66195807ac6cb8a14231fd055ff755977c5fca
>
> They did, I ended up with:
>
> https://github.com/linuxppc/linux/commit/fb7314c5d6b00dbaaac14c28a52a87dee7e726df

It's not happy on mambo:

WARNING: 20856759: (20856757): Invalid address 0x0000000028096258 in XSCOM range,  SCOM=0x00280962b
WARNING: 20856759: (20856757): Attempt to store non-existent address 0x00001A0028096258
20856759: (20856757): 0x000000003002DA08 : stdcix  r26,r0,r3
FATAL ERROR: 20856759: (20856757): Check Stop for 0:0: Machine Check with ME bit of MSR off

Which looks to be one of the xscom_write()'s from opal_nmmu_set_ptcr().

Do I need a newer mambo?

cheers
