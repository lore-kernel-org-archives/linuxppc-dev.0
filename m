Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB931C43612
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 16:57:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E0920651
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 16:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E0920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RqVv6cj7zDqF5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 03:57:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RqSZ3h9FzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 03:55:09 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43RqSN4t94z9txrB;
 Sat, 29 Dec 2018 17:55:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id da60WTjGdypm; Sat, 29 Dec 2018 17:55:00 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43RqSN4Crgz9txr6;
 Sat, 29 Dec 2018 17:55:00 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 5B66463B; Sat, 29 Dec 2018 17:55:02 +0100 (CET)
Received: from 37.164.147.219 ([37.164.147.219]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 29 Dec 2018 17:55:02 +0100
Date: Sat, 29 Dec 2018 17:55:02 +0100
Message-ID: <20181229175502.Horde.OaGr035vfDpvlvNGdmoaOQ2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
In-Reply-To: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Finn Thain <fthain@telegraphics.com.au>, linux-m68k@lists.linux-m68k.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Schmitz <schmitzmic@gmail.com> a =C3=A9crit=C2=A0:

> Hi Finn,
>
> Am 29.12.2018 um 14:06 schrieb Finn Thain:
>> On Fri, 28 Dec 2018, LEROY Christophe wrote:
>>>> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
>>>> index 89f5154c40b6..99e5729d910d 100644
>>>> --- a/drivers/scsi/atari_scsi.c
>>>> +++ b/drivers/scsi/atari_scsi.c
>>>> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct
>>>> platform_device *pdev)
>>>> 	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >=3D 0)
>>>> 		atari_scsi_template.sg_tablesize =3D setup_sg_tablesize;
>>>>
>>>> -	if (setup_hostid >=3D 0) {
>>>> +	if (setup_hostid >=3D 0)
>>>> 		atari_scsi_template.this_id =3D setup_hostid & 7;
>>>> -	} else {
>>>> +#ifdef CONFIG_NVRAM
>>>> +	else
>>>
>>> Such ifdefs should be avoided in C files.
>>> It would be better to use
>>>
>>> } else if (IS_ENABLED(CONFIG_NVRAM)) {
>>>
>>
>> I don't like #ifdefs either. However, as the maintainer of this file, I =
am
>> okay with this one.
>>
>> The old #ifdef CONFIG_NVRAM conditional compilation convention that gets
>> used here and under drivers/video/fbdev could probably be improved upon
>> but I consider this to be out-of-scope for this series, which is
>> complicated enough.
>>
>> And as explained in the commit log, CONFIG_NVRAM=3Dy and CONFIG_NVRAM=3D=
m are
>> treaded differently by drivers. Therefore, IS_ENABLED would be incorrect=
.
>
> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to sugg=
est.

Doesn't #ifdef means either y or m ? So the same as IS_ENABLED() ?

Christophe

>
> Or (really going out on a limb here):
>
> IS_BUILTIN(CONFIG_NVRAM) ||
> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>
> Not that I'd advocate that, for this series.
>
> Cheers,
>
> 	Michael


