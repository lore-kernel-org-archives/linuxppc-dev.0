Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47951C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 01:35:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8201D21019
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 01:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVGbyG54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8201D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RR3X1XXqzDqDp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 12:35:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rVGbyG54";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=schmitzmic@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rVGbyG54"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RR0r3vNWzDqCk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 12:33:12 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id z9so11101550pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 17:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=0g+71U+dX+QF2iiDoSz5x+9PmsICHaGBbrjNqL+fqJA=;
 b=rVGbyG54LViWSoyiHppDMoeyktkoVpAJAdeBYdHLR/LVmuJR5JfG9XKWydst2M8Hzx
 tvVUYcMyNMjqu9r0Uic3yOU9XVJb6lz9xUTtVxtQ8nrWltZB5JgZAUzwahCvb+hMutdz
 0d+R2JGf9xFxt8xD5iXfVs/CYvmq1dXe4/08pV749JJ+ao3gnvBzXMJS7Wl3t0Tt3pTq
 NhisMXY7XnEAldBrc9LILyvpSxloWoTj5y0hbyPB3YsfnmlMxWqo+sLTkwM8m7YAdnRN
 JDmW+PkJsDc5usAwFxu4BzrhBLq0r0R4QWJ5ah4AywrW1lmm1kz2p/9Ubu5TZt5vdyPB
 rDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=0g+71U+dX+QF2iiDoSz5x+9PmsICHaGBbrjNqL+fqJA=;
 b=exPhL2oJ+cQ3gzNK8bH5VY23M7tPEEoZU/lYCH6l/43P55YxClpR7Dw1X59tk1F5sQ
 cZ2KvBbXMoTj0L7BsML+Fo3WN6NQ162RFlBmtEo7WlLRwoShJVUtSyLUqAM26c3s+N+5
 VkKxBuuxz5iF8wUDoSde77poGIbNUWZln0sfkOC7RNfYulyub8tR2a90nG6URrNmws4i
 2p4uq4ry/B+MX4AA6A+/d6vBIbUE51VylBbcrqcKtkb8w/EKFimF8gkN268vg4oyoSDI
 bwdOA/aUvkr+MT+blMINYWWqOhBeOaXfVM0Lw9l1Z+ZrYblJVrvJMeBjpLpqcRLymwQJ
 hOWA==
X-Gm-Message-State: AA+aEWaIVMhyiKGdGKQYif3R7O2d0y/KpWRc6gvvAqAGdWf/FrPkAQO+
 S6rgv0kHCXfN3PiLmOZ4bsM=
X-Google-Smtp-Source: AFSGD/UI2ut7bgxj+fbDqA2EcIn3+I9kKcAMx9YyKFdhMGHVnrNJx8ywdu1VT4koUsbcows91O6FYw==
X-Received: by 2002:a62:442:: with SMTP id 63mr29667407pfe.156.1546047190014; 
 Fri, 28 Dec 2018 17:33:10 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz.
 [122.58.176.92])
 by smtp.gmail.com with ESMTPSA id i62sm48795899pge.44.2018.12.28.17.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 17:33:09 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To: Finn Thain <fthain@telegraphics.com.au>,
 LEROY Christophe <christophe.leroy@c-s.fr>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
Date: Sat, 29 Dec 2018 14:33:00 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Finn,

Am 29.12.2018 um 14:06 schrieb Finn Thain:
> On Fri, 28 Dec 2018, LEROY Christophe wrote:
>>> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
>>> index 89f5154c40b6..99e5729d910d 100644
>>> --- a/drivers/scsi/atari_scsi.c
>>> +++ b/drivers/scsi/atari_scsi.c
>>> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct
>>> platform_device *pdev)
>>>  	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>>>  		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>>>
>>> -	if (setup_hostid >= 0) {
>>> +	if (setup_hostid >= 0)
>>>  		atari_scsi_template.this_id = setup_hostid & 7;
>>> -	} else {
>>> +#ifdef CONFIG_NVRAM
>>> +	else
>>
>> Such ifdefs should be avoided in C files.
>> It would be better to use
>>
>> } else if (IS_ENABLED(CONFIG_NVRAM)) {
>>
>
> I don't like #ifdefs either. However, as the maintainer of this file, I am
> okay with this one.
>
> The old #ifdef CONFIG_NVRAM conditional compilation convention that gets
> used here and under drivers/video/fbdev could probably be improved upon
> but I consider this to be out-of-scope for this series, which is
> complicated enough.
>
> And as explained in the commit log, CONFIG_NVRAM=y and CONFIG_NVRAM=m are
> treaded differently by drivers. Therefore, IS_ENABLED would be incorrect.

IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to 
suggest.

Or (really going out on a limb here):

IS_BUILTIN(CONFIG_NVRAM) ||
( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )

Not that I'd advocate that, for this series.

Cheers,

	Michael



