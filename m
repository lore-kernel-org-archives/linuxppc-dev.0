Return-Path: <ccano@interfaceconcept.com>
Received: from smtp-out05.msg.oleane.net (smtp-out05.msg.oleane.net
	[62.161.7.3]) by ozlabs.org (Postfix) with ESMTP id 74327B6FB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 17:04:25 +1000 (EST)
Message-ID: <4DF702F3.704@interfaceconcept.com>
Date: Tue, 14 Jun 2011 08:42:59 +0200
From: =?UTF-8?B?Q8OpZHJpYyBDYW5v?= <ccano@interfaceconcept.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] Big endian swap for Marvell 6440 SAS driver
References: <4DF2228E.7060806@ic.fr> <1307832356.2874.312.camel@pasglop>
In-Reply-To: <1307832356.2874.312.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

You're alright! I hadn't thought to use le32_to_cpu.
Do you want I make a new patch?

Cedric

Le 12/06/2011 00:45, Benjamin Herrenschmidt a écrit :
> On Fri, 2011-06-10 at 15:56 +0200, Cédric Cano wrote:
>> Hi,
>>
>> Marvell SAS driver doesn't work on powerpc architecture due to big
>> endian swap. I've tested it with the MV6440 chip.
>> Here you can find the patch for Linux 2.6.39.1.
>>
>> Cedric Cano
>>
>> Signed-off-by: Cedric Cano<ccano@interfaceconcept.com>
>> ---
>> --- drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:04.000000000 +0200
>> +++ drivers/scsi/mvsas/mv_sas.c    2011-06-10 15:50:12.000000000 +0200
>> @@ -1143,6 +1143,14 @@
>>        MVS_CHIP_DISP->write_port_cfg_addr(mvi, i, PHYR_SATA_SIG0);
>>        s[0] = MVS_CHIP_DISP->read_port_cfg_data(mvi, i);
>>
>> +    /* swap for big endian devices because of use of these data in bytes */
>> +#ifdef __BIG_ENDIAN
>> +    s[0] = swab32(s[0]);
>> +    s[1] = swab32(s[1]);
>> +    s[2] = swab32(s[2]);
>> +    s[3] = swab32(s[3]);
>> +#endif /* __BIG_ENDIAN */
> Hi Cedric !
>
> Thanks for this. CC'ing linux-scsi.
>
> Note that it would probably have been better to use le32_to_cpu, which
> avoids the ifdef completely.
>
> Cheers,
> Ben.
>
>>        /* Workaround: take some ATAPI devices for ATA */
>>        if (((s[1]&  0x00FFFFFF) == 0x00EB1401)&&  (*(u8 *)&s[3] == 0x01))
>>            s[1] = 0x00EB1401 | (*((u8 *)&s[1] + 3)&  0x10);
>>
>> ---
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
