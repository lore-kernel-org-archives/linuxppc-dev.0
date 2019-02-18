Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 06:15:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4D5218AD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 06:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="cALNLfF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4D5218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442trj35NFzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 17:15:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="cALNLfF+"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442tq25BgnzDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 17:13:49 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id r124so7917955pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bN26HT0KDVHq+z2DBrUk26WOkjcpzyHE6eEdZwaX+p4=;
 b=cALNLfF+t7O/XHpkuppdvADQN+pQ6b16rfmHFdsjdW3MpxFWC2pV75xP4WVy/9coV0
 QaFj8FLXCJSkl00XY7PaeTKJGPjxiMGju/vGkkn8VtH/B9x9Fw/CC6zMQNJMSqdU2ltj
 Opvy6cBSTBhOqoakFdwJ6E4GHol/LVLLlEJVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bN26HT0KDVHq+z2DBrUk26WOkjcpzyHE6eEdZwaX+p4=;
 b=cphFk6CDvW7gIHBnwjPTQesJBmuc6lCKznIYPSIeZwlBZRS5NkxfWSrqcLmxUSfewW
 Qm4K4IWJ8ZNJv3xBGPKDobpa5ySlhBVncJFVCH3sVqq+EgLf7vZ7d82nXA6odhDfQ81l
 +wp/6zkuEWi/KchPXkyuyCqGA+3udp48m9w9mygMjVb4kNpantkyKEuQc+wShoSta8Q7
 1VK4o9+ywcAHgYoIH0B4yijPUvJ/hLUd9KQISLXv0BRCJ2XST8waJWUCVdOAjNdXXGiC
 gjEufMXHmC5VuN6kX5Nc94ks8tZ5znO6qtaZy1DI1AhBsh34sfZ4Yt8k7eKKZgfdNmfV
 oHEw==
X-Gm-Message-State: AHQUAuYIUIgfzU+WjVl3Au4mtmfsK69KcBf/jTyo3JvZBLWu2aAg4ztS
 Vod2JLbcOnDo5rfVLGVTYIpG2g==
X-Google-Smtp-Source: AHgI3Ib3W1h21i0yOUhsh1LFQggS8vR+rSm9JTcDowKKijyJqqpf/8LbnBWcUyvEZkIfyIp2WFrr2A==
X-Received: by 2002:a63:2c8a:: with SMTP id
 s132mr17454201pgs.440.1550470427653; 
 Sun, 17 Feb 2019 22:13:47 -0800 (PST)
Received: from localhost ([203.59.139.110])
 by smtp.gmail.com with ESMTPSA id b26sm20251344pfe.91.2019.02.17.22.13.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 Feb 2019 22:13:46 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: christophe leroy <christophe.leroy@c-s.fr>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
Subject: Re: [RFC PATCH 3/5] kasan: allow architectures to provide an outline
 readiness check
In-Reply-To: <dd65d283-5f6b-8e07-37ba-8ebc24cd5294@c-s.fr>
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-4-dja@axtens.net>
 <dd65d283-5f6b-8e07-37ba-8ebc24cd5294@c-s.fr>
Date: Mon, 18 Feb 2019 17:13:42 +1100
Message-ID: <87zhqt39pl.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 15/02/2019 =C3=A0 01:04, Daniel Axtens a =C3=A9crit=C2=A0:
>> In powerpc (as I understand it), we spend a lot of time in boot
>> running in real mode before MMU paging is initalised. During
>> this time we call a lot of generic code, including printk(). If
>> we try to access the shadow region during this time, things fail.
>>=20
>> My attempts to move early init before the first printk have not
>> been successful. (Both previous RFCs for ppc64 - by 2 different
>> people - have needed this trick too!)
>>=20
>> So, allow architectures to define a check_return_arch_not_ready()
>> hook that bails out of check_memory_region_inline() unless the
>> arch has done all of the init.
>>=20
>> Link: https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
>> Link: https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
>> Originally-by: Balbir Singh <bsingharora@gmail.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>   include/linux/kasan.h | 4 ++++
>>   mm/kasan/generic.c    | 2 ++
>>   2 files changed, 6 insertions(+)
>>=20
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index f6261840f94c..83edc5e2b6a0 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -14,6 +14,10 @@ struct task_struct;
>>   #include <asm/kasan.h>
>>   #include <asm/pgtable.h>
>>=20=20=20
>> +#ifndef check_return_arch_not_ready
>> +#define check_return_arch_not_ready()	do { } while (0)
>> +#endif
>
> A static inline would be better I believe.
>
> Something like
>
> #ifndef kasan_arch_is_ready
> static inline bool kasan_arch_is_ready {return true;}
> #endif
>
>> +
>>   extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>>   extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>>   extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index bafa2f986660..4c18bbd09a20 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -170,6 +170,8 @@ static __always_inline void check_memory_region_inli=
ne(unsigned long addr,
>>   						size_t size, bool write,
>>   						unsigned long ret_ip)
>>   {
>> +	check_return_arch_not_ready();
>> +
>
> Not good for readibility that the above macro embeds a return, something=
=20
> like below would be better I think:
>
> 	if (!kasan_arch_is_ready())
> 		return;
>
> Unless somebody minds, I'll do the change and take this patch in my=20
> series in order to handle the case of book3s/32 hash.

Please do; feel free to take as many of the patches as you would like
and I'll rebase whatever is left on the next version of your series.

The idea with the macro magic was to take advantage of the speed of
static keys (I think, I borrowed it from Balbir's patch). Perhaps an
inline function will achieve this anyway, but given that KASAN with
outline instrumentation is inevitably slow, I guess it doesn't matter
much either way.

Regards,
Daniel
>
> Christophe
>
>>   	if (unlikely(size =3D=3D 0))
>>   		return;
>>=20=20=20
>>=20
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
