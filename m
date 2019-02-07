Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E0BC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:55:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DC42147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfEG+2r+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DC42147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5bG24PYzDqQC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:55:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5Yh0rsqzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfEG+2r+"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w5Yg6rTVz8tS0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:53:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w5Yg6lNVz9sMM; Thu,  7 Feb 2019 15:53:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfEG+2r+"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w5Yg0kCwz9sLw
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:53:42 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id z11so3997189pgu.0
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=RtxZd53wIFg6oznxa2HXSEBIN3l24LWVhzFdFkI6uFE=;
 b=lfEG+2r+I4OJT1S95iszvxYPAXUDmp3bkf40cWua/ZbyCTCDAFWtXQ49cIicI5CQ8J
 GFc7SYYvRBiPSU5W4FYOE2/qVbp6sjNSk9t4vGywWOZ14FRveXY15rURRwt3Qn82JVV4
 NMJlIPoqbJ/3W+XQLqH0PhWP2R2zXk/oiCSJpXE7mfahuI08OqHsIpRW9RWlpNpft8R4
 ifuSEvATSMAaZYEljjRz50wcyRa6DompOXfv74K39SPhFUTu5Wa+62khZ/QlEmH5ZHjV
 QNfbDXr7PmsQXc5zlGToiqs4yejD/mWNllOrJkuf4/HcqP8W3XEpxSzxlaQ20I3Z0aLh
 gIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=RtxZd53wIFg6oznxa2HXSEBIN3l24LWVhzFdFkI6uFE=;
 b=sYKO4hICWELLVCCVwGZLnGxdXlMuy6CjQKpdf6mF73Qm2qIYfYtgm2l21uGEc/WvFd
 aK5kfxdB5K0nKDEWJCTzD5KNzvTh0/mnxdbkivfu6Jm/Jao1+u3+Rlxv2QDuXJgaveSv
 stfHlKVAz/ChIhwl5oNlYwLTxUpHct+Dq3KhXoEwEp4w3b74m2ubLM+kq+8SgCrza3MD
 10aq3Erb9+akmwIOBUKrL319+Rn2VxI5D7il2JemT5X4P/RADxByeVnXL6UohiFsZaAK
 OwuzwtJvmTAgCI9ajOUWMnbTDftt8zHL/XtCPH0OM6e8CRpiiYMM95eK511oaXFCZYJx
 qtog==
X-Gm-Message-State: AHQUAuavAmrXH03THJucuBad0O2HQb3ALmQabED16KTYQmPwaLjO1pYb
 UcapLhTgKJoXLRGYZK38kbT2nvJN
X-Google-Smtp-Source: AHgI3IZGsrS20i/UlKDSrlBalq4xksMQ1Iw8wzh4gpl4Fck4UEkBp3CGx5oq7Us5emZ7h1H/aSCO2g==
X-Received: by 2002:aa7:934f:: with SMTP id 15mr7093852pfn.38.1549515221125;
 Wed, 06 Feb 2019 20:53:41 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id l19sm18541992pfi.71.2019.02.06.20.53.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:53:40 -0800 (PST)
Date: Thu, 07 Feb 2019 14:53:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 16/21] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-17-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-17-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549515139.mlgyosrnpx.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
>=20
> Moving thread_info into task_struct has the following advantages:
>   - It protects thread_info from corruption in the case of stack
>     overflows.
>   - Its address is harder to determine if stack addresses are leaked,
>     making a number of attacks more difficult.
>=20
> This has the following consequences:
>   - thread_info is now located at the beginning of task_struct.
>   - The 'cpu' field is now in task_struct, and only exists when
>     CONFIG_SMP is active.
>   - thread_info doesn't have anymore the 'task' field.
>=20
> This patch:
>   - Removes all recopy of thread_info struct when the stack changes.
>   - Changes the CURRENT_THREAD_INFO() macro to point to current.
>   - Selects CONFIG_THREAD_INFO_IN_TASK.
>   - Modifies raw_smp_processor_id() to get ->cpu from current without
>     including linux/sched.h to avoid circular inclusion and without
>     including asm/asm-offsets.h to avoid symbol names duplication
>     between ASM constants and C constants.

Come to think of it, can this patch be split out entirely and moved
earlier as a 32-bit patch? 64-bit does not require that change or the=20
additional build step AFAIKS?

Thanks,
Nick

=
