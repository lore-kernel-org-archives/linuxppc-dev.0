Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C97C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:53:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DCB218FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6uhzUWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DCB218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RSn31djDzDqLR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 13:53:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6uhzUWh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=schmitzmic@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6uhzUWh"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RSk33M1XzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 13:50:35 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id g62so11139875pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 18:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=HH/VVa7JnPpWgQW9gVxne6LPArl8bMHIK3nhE9clvu4=;
 b=a6uhzUWhRQ14S39hh8Feobo5RXFI3b3IG6DOsuFwQmDPi21474vntMlybsnMovt5nK
 oa6KRQTQvNyJ8UzIyFYH585zkhBagdLSJGhZ9iMuX+SWN/PDxQFcNxFY9isD1mvc5nzd
 Rt4Rb/ocgWckcxw9A1wFaH2XVS5azJm2JqxCZQVVn246mJsXUv5qgtGzqPjlpPuZ1C5j
 YFgGYOZgRPTD4Nhh3NayB6CXJ9wIoKRJ6DLVTkj8LPf+xg1XwkcZrrERTokPy6XimQi4
 igkG+snDBOR1sOWY0UB0yPDB3NJzjNBt9ILnewtAbzWBEDt/itZgECGWO6OrbeRXNa5e
 3Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=HH/VVa7JnPpWgQW9gVxne6LPArl8bMHIK3nhE9clvu4=;
 b=gzPy/0SIPaTUTMcxyLWOcAm6QK67Oo8hP6+aflUeUFeWvXcXXfZacNg8FkOnik2eDZ
 zVS8pwT0feuHkvBu0tgkkt9pPPoRs+Wpq715/iXa3Vj2qg1nF2cwpEzNlCKZ+5WrZBSu
 DpdjRNCM/BY8zSn70j13Ee0Kec1+pLxw3iP77R36mj1Ts166qXzzla/PIxSXkOnOlLcm
 DKUQesEOC84KMjfy8WOSSNCvnqJlz87p/kSBFAbMFgVqhTkronFL+KL3QPV65IldNrcr
 IyFyXPvly3W+/ozd4hOumJXOhf8qe8FWCSNPEydJBNfH3poRDqDKbBoVqpfg5fJKOjK1
 AGJA==
X-Gm-Message-State: AJcUukeJGET30E9G3YhVMJuHeSYLk6YKd4W77B+NKoI5EAaedmd/H+eu
 Jekg7Q/Q/FO6su0vshyKfVI=
X-Google-Smtp-Source: ALg8bN4E1A2uVct1AsGLJkRQZMqSIZqm4C2uX3mwR0Cp0JXV9wrw1hr4OzmWwjdEDT7LwBaUGubS7Q==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr372699pgf.87.1546051833241;
 Fri, 28 Dec 2018 18:50:33 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz.
 [122.58.176.92])
 by smtp.gmail.com with ESMTPSA id n21sm59547273pfg.84.2018.12.28.18.50.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 18:50:32 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To: Finn Thain <fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
Date: Sat, 29 Dec 2018 15:50:23 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
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

Am 29.12.2018 um 15:34 schrieb Finn Thain:
> On Sat, 29 Dec 2018, Michael Schmitz wrote:
>
>>
>> IS_BUILTIN(CONFIG_NVRAM) is probably what Christophe really meant to suggest.
>>
>> Or (really going out on a limb here):
>>
>> IS_BUILTIN(CONFIG_NVRAM) ||
>> ( IS_MODULE(CONFIG_ATARI_SCSI) && IS_ENABLED(CONFIG_NVRAM) )
>>
>> Not that I'd advocate that, for this series.
>>
>
> Well, you are a maintainer for atari_scsi.c.
>
> Are you saying that you want IS_BUILTIN(CONFIG_NVRAM) used here instead of
> ifdef?

No, just pointing out that there would be a way to avoid the ifdef 
without messing up driver behaviour. I'm fine with the ifdef - not least 
because it clearly eliminates code that would be unreachable.

(On second thought - I don't want to speculate whether there's weird 
compiler options that could result in the nvram_check_checksum and 
nvram_read_bytes symbols to still be referenced in the final link, even 
though IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best leave 
this as-is.)

> OTOH, if you approve of the existing patch, please send your acked-by.

Of course - I'd seen Geert's acked-by on some of the patches and forgot 
to check which still required acks.

Cheers,

	Michael


