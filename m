Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 23A43DE1AE
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 06:16:23 +1000 (EST)
Received: by qyk8 with SMTP id 8so1121252qyk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 13:16:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200904162130.01237.bzolnier@gmail.com>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
	<200904162130.01237.bzolnier@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 14:16:06 -0600
Message-ID: <fa686aa40904161316w57d46af2p4ea6fdc6db3ffd4a@mail.gmail.com>
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like PowerPC
	systems
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roderick,

Since this patch is Xilinx virtex related, it is a good idea to cc:
both the linuxppc-dev mailing list and me when posting.  That way I'd
have the opportunity to reply with an 'acked-by' or 'reviewed-by'
line.

g.

On Thu, Apr 16, 2009 at 1:30 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>
> Hi,
>
> On Wednesday 15 April 2009 16:34:22 Roderick Colenbrander wrote:
>> Hi,
>>
>> I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
>> Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
>> for IDE, USB and Audio. I did a lot of work to get the pci bus working
>> on this board and it works correctly but the default init code
>> of the alim15x3 driver doesn't work for me. The driver explicitly
>> disabled some initialization code for powerpc after uncommenting this
>> code it works properly. Benjamin Herrenschmidt and I think this
>> !CONFIG_PPC check should be removed because the system behaves
>> like a real 'x86' system (also the i8259 interrupt controller is used).
>
> Ben, I guess you are OK with the change and there are no longer other
> platforms requiring CONFIG_PPC check below? =A0[I don't see your ACK here=
]
>
>> Regards,
>> Roderick Colenbrander
>>
>>
>> From 1c40c2f1485ecd3bc5ad7a3af537cb94de0877c3 Mon Sep 17 00:00:00 2001
>> From: Roderick Colenbrander <thunderbird2k@gmail.com>
>> Date: Wed, 15 Apr 2009 10:45:17 +0200
>> Subject: [PATCH] Use the 'x86' init_hwif code in the alim15x3 for
>> x86-like PowerPC boards like Xilinx ML310/410/510.
>
> Roderick, please add your "Signed-off-by:" line
> (per Documentation/SubmittingPatches).
>
> Thanks.
>
>> ---
>> =A0drivers/ide/alim15x3.c | =A0 =A09 +++++----
>> =A01 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
>> index 537da1c..9176c0f 100644
>> --- a/drivers/ide/alim15x3.c
>> +++ b/drivers/ide/alim15x3.c
>> @@ -402,14 +402,15 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
>> =A0 =A0 =A0return cbl;
>> =A0}
>>
>> -#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
>> +#if !defined(CONFIG_SPARC64)
>> =A0/**
>> =A0 * =A0 =A0init_hwif_ali15x3 =A0 =A0- =A0 =A0Initialize the ALI IDE x8=
6 stuff
>> =A0 * =A0 =A0@hwif: interface to configure
>> =A0 *
>> =A0 * =A0 =A0Obtain the IRQ tables for an ALi based IDE solution on the =
PC
>> - * =A0 =A0class platforms. This part of the code isn't applicable to th=
e
>> - * =A0 =A0Sparc and PowerPC systems.
>> + * =A0 =A0class platforms. This part of the code isn't applicable to
>> + * =A0 =A0Sparc systems. It is usable on 'x86-like' PowerPC systems
>> + * =A0 =A0 =A0which use a Ali M15x3 south bridge like e.g. Xilinx ML310=
/410/510.
>> =A0 */
>>
>> =A0static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
>> @@ -455,7 +456,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t =
*hwif)
>> =A0}
>> =A0#else
>> =A0#define init_hwif_ali15x3 NULL
>> -#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
>> +#endif /* !defined(CONFIG_SPARC64) */
>>
>> =A0/**
>> =A0 * =A0 =A0init_dma_ali15x3 =A0 =A0- =A0 =A0set up DMA on ALi15x3
>> --
>> 1.5.6.3
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
