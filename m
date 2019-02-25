Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DBAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:57:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7002620663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiMnI9cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7002620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447Q5P5p6TzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 01:56:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=mtk.manpages@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiMnI9cn"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447Q3N6BCqzDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 01:55:09 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id w17so10232561wrn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 06:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=cc:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FnueZ7IgA8rCLeU7Gwwu1v68InYcHlydtHfzBGaNhqg=;
 b=kiMnI9cnaFC+hPmjq5tlaHrWWeVu0An8EuJG3iO5RC3aOLJQcE22McBXepYR1KFlrX
 6FOpAh7X3wmrN/cwFhDZQQ3inp1WUMlfd91fTdoHet4VXKjt3zRswPbcvxdwB4VP9gPz
 aSFDv2zemKltI8/JIHnWqxkK5Q0e3NyRAfERuoc3gGxRwjiVjpAVG5FP8kP6I7OBpEtW
 FGuo06wjBQXuZppltnY1ysSh/aDxqrbiY9kElHt5ImM8LlrbvsA0z7weVCLa9M5izYId
 xuaOVyynNTRaGAFSzOvri3pyyhnROsW9lxcKGPFmMclAhhxqtcrkEcus3Vab4aravkhc
 W/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:cc:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FnueZ7IgA8rCLeU7Gwwu1v68InYcHlydtHfzBGaNhqg=;
 b=bGkHCYgKmSZqjBBT2tIPF4rXWCn4MlU7Ls7Ld/FEiy/y54uFX9iOJGc3jadRXnHOw9
 KPiRa21Uslh0JhJBb/+f6koWmdIFzE5uMKAWN8LpRkxqSJOjU1wpOeOHwVWdMa83ZIAy
 VQzxAPY9jzjkQCqOZr7lLP5zd0S5ORb2OK3eULoMcxCI7khWgsidxHRWN5Y3FHiZoDk8
 3B6c9vDl+7xk0M16DbAnCgJ4j9vScboZsfHQNxY5cioyOMLP6GYNjjvLsu5EF5lw0edT
 CPbpbcmI8MVqcTKTT3YqOGBDzTgaibImtL4ZPcy838HB/XMgGvWTrtMNUUlKTULW4Rxx
 KkYg==
X-Gm-Message-State: AHQUAubtyJ8Tr0+auwK1LH9BxJF9J9aJZ8kbQsdAGU0d+WAGFvfnBIDF
 5q/wEv48rlJdyzJq5pRrtJ4=
X-Google-Smtp-Source: AHgI3IZVbhN223HxIrmHpDYhC1vNbII4YQzzRx7nERZ/9nQW80Z5Szvsa9KpxSDk/BK6NkQEI3BAUQ==
X-Received: by 2002:a05:6000:10ce:: with SMTP id
 b14mr13691963wrx.221.1551106505650; 
 Mon, 25 Feb 2019 06:55:05 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
 by smtp.gmail.com with ESMTPSA id e7sm11403783wrw.35.2019.02.25.06.55.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 06:55:04 -0800 (PST)
Subject: Re: [PATCH] mmap.2: describe the 5level paging hack
To: Jann Horn <jannh@google.com>
References: <20190211163653.97742-1-jannh@google.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f89de711-d73b-96be-75b6-0e9054022708@gmail.com>
Date: Mon, 25 Feb 2019 15:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190211163653.97742-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@amacapital.net>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, mtk.manpages@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/11/19 5:36 PM, Jann Horn wrote:
> The manpage is missing information about the compatibility hack for
> 5-level paging that went in in 4.14, around commit ee00f4a32a76 ("x86/mm:
> Allow userspace have mappings above 47-bit"). Add some information about
> that.
> 
> While I don't think any hardware supporting this is shipping yet (?), I
> think it's useful to try to write a manpage for this API, partly to
> figure out how usable that API actually is, and partly because when this
> hardware does ship, it'd be nice if distro manpages had information about
> how to use it.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This patch goes on top of the patch "[PATCH] mmap.2: fix description of
> treatment of the hint" that I just sent, but I'm not sending them in a
> series because I want the first one to go in, and I think this one might
> be a bit more controversial.
> 
> It would be nice if the architecture maintainers and mm folks could have
> a look at this and check that what I wrote is right - I only looked at
> the source for this, I haven't tried it.
> 
>  man2/mmap.2 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index 8556bbfeb..977782fa8 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -67,6 +67,8 @@ is NULL,
>  then the kernel chooses the (page-aligned) address
>  at which to create the mapping;
>  this is the most portable method of creating a new mapping.
> +On Linux, in this case, the kernel may limit the maximum address that can be
> +used for allocations to a legacy limit for compatibility reasons.
>  If
>  .I addr
>  is not NULL,
> @@ -77,6 +79,19 @@ or equal to the value specified by
>  and attempt to create the mapping there.
>  If another mapping already exists there, the kernel picks a new
>  address, independent of the hint.
> +However, if a hint above the architecture's legacy address limit is provided
> +(on x86-64: above 0x7ffffffff000, on arm64: above 0x1000000000000, on ppc64 with
> +book3s: above 0x7fffffffffff or 0x3fffffffffff, depending on page size), the
> +kernel is permitted to allocate mappings beyond the architecture's legacy
> +address limit. The availability of such addresses is hardware-dependent.
> +Therefore, if you want to be able to use the full virtual address space of
> +hardware that supports addresses beyond the legacy range, you need to specify an
> +address above that limit; however, for security reasons, you should avoid
> +specifying a fixed valid address outside the compatibility range,
> +since that would reduce the value of userspace address space layout
> +randomization. Therefore, it is recommended to specify an address
> +.I beyond
> +the end of the userspace address space.
>  .\" Before Linux 2.6.24, the address was rounded up to the next page
>  .\" boundary; since 2.6.24, it is rounded down!
>  The address of the new mapping is returned as the result of the call.
>

Hi Jann,

A few comments came in on this patch. Is there anything from
those comments that should be rolled into the text?

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
