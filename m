Return-Path: <linuxppc-dev+bounces-26012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E60C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 03:02:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQSsZ582Lz2ykT;
	Thu, 20 Aug 2026 13:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787194946;
	cv=none; b=lfREkAJvqxm0UeWdKtGgfTFvCjQ2I8L+xn9e1DP01OAjoMSjUxnllE32g57Xl2yOsIRo5kA5x5g374DR8Um8nTOHmKl7QlejG4eOHUVdANibzzLY+WounMKmOG+7tadqzZ1bNk4kBXdFTaDD5Wg/gzKpyvk1mtSMFyAWt+jWdywciXXIepoPBnZko8ZaeLDOw/DLELpRwgD4MuBMkm81o3CaGXhpMFh+1ulpbmsZgKovg3J0Hr37dgjpOXHfklcmaihmU2nLMA78/QkIcpitINrid5RTPdvpNB6gs6etRi5e3bDn1VXzWvNAO6Tj33EhRjdyas2RcLjGpLpraXqbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787194946; c=relaxed/relaxed;
	bh=b7Lcuraq/4CMmDj86N4LuGkDilC6+Z6Q+xTsr6qjIXM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=gK5176cmeGiZ488wLy4dFC7fX0j3AtLcbOSp0KCkA739l4FQoeeEJcPLFH8Bz4R1VoRVqDHBfdX4TACBdBnbTa/6kH65P6t6uMB+oi5g0k7qnPMb26Ax+6XSllPomJsFqgYEelfcNFbBGMqmY9cN5AjYbHoIU8AAWkv22fGCXIR/XNfjHutTrXLj7xK72mOZGdV7sxXoWhcfMnOo0XrcJctRBQwciYLJBdp9Zs9vM6lNEvoaA4WMd65CEEDeclpYb6GcU2EK2tst4NaZJSzIAnQWhYyHDgOx+IRQdSuFHX7Xx638RaK+o1YyuFsYFa8EUCgfeazwHda2eXkJWvrzfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oFG+TpUo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oFG+TpUo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQSsY1vKfz2ySm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 13:02:25 +1000 (AEST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1246180a34.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787194942; x=1787799742; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7Lcuraq/4CMmDj86N4LuGkDilC6+Z6Q+xTsr6qjIXM=;
        b=oFG+TpUoTd9ufCD+0EC/ETe7faaMDOPZvGBls6mh4QpBruJp04JsQV2YO1x/rfSyoL
         2jVI+sh3sRIqPIugW7pWlShR0WU/ctWLGXH0tsOOQB30bhcEFzsyQW3A8fIhvYzCDH8r
         qIKB8O4ANJJuwOmO3827HvuuhnXe27PlzO/hn7PF4q+Xk7XcAUJEQn7yslbIN4fzhGr6
         a8ln8fss/53rRTkboY1TcNEc3O5e9/fx4UAhBSpL6sUIG9tMGp195XjhGSifKuBx5mvw
         cphbhUdAtX/qQ3BxZ1+e2O4IygijDaCV3LXjwo2B2r6G8SSjc+Q0qpzd96ppGO0+Ea7H
         6LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787194942; x=1787799742;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7Lcuraq/4CMmDj86N4LuGkDilC6+Z6Q+xTsr6qjIXM=;
        b=YqOS6gDNwxHUrw9gNtMr4MojHvO6u3ZLnjSZJY7MQ6FM2guvzzImYKk7RPIGK20kl2
         /o5mAeEP7OkHiVq8O8EsBkOWgStrkIq9Ntwql6WTMT/cTWDsHflM9py2/1tO8yiybByc
         6W02wk61pLy0BwgXNtD0V1jTllR2WqeaSR1uqyNd8SkrJOpJ2g6Mizv1FBKe/zT/DtB7
         KZn0AiA71QenTy/NZKqGXdpM41xUj02y8gFCbTt4qOgZnZiWyDB+Mr7aTGT+kfyQYhhT
         8Is0jHfLApaPD1D72ImfX6LKIX9zlEo1s0bwpwS3qAlEbFSoHNplZTpPY88yCVohDFDR
         Zrtw==
X-Forwarded-Encrypted: i=1; AHgh+RryvRF4sxuiqW2h/Rsz2ccgPH4gP80sJTr4nnjz762zjXkWvPn+23EBrIH01Nk/MWu4WlEIpXwPEePQZrc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIAQpLfEu2TOkkYWc29opiD1DIl7onrmTuSJsYXyOLBVIn3ePV
	Sy86kiqBjmgyVXBXJtg8YHloR00n7cOiCTLBEbpotNqA2QXNJZ8aHHtW
X-Gm-Gg: AR+sD11v7fgu1fBqRJsRdm99T6YOv00Y01IC60GZdjLoeCzMREABCRYSzXPSRDbWcma
	FT3Ltwme9eP+Wt/wq6qr1oLrbHIcyQK2qYsvP6JX2L4T4vb35K9E3CPL7PHMO4mCEiQtd6FKjls
	wXoKxZGPpl3HuHF8y00SEdbwfCpqfNKFwmtNDyBh0S+npR6IE5HwC8RvvxXXPlmYIdxIrCMsjVz
	Lqp0a5CU062L+Oef6o5Jq+0qkZc4fOvGF3TzxHPWQcQvFjheINIWfFtdmGB/uilOCLUnmhy1L3Z
	y6pCxImxmwEI7U1yevpHFruBxtz2a/6zTWe4Ut/0A80MoLJ8pqyFYNX22yCQStxOxHdwGdzRcdU
	+PhmYT8bq/59KfmH0Kvsov0rFKiDY9f7p/8SPPWPQi2I4nNHri4B0rnnhAvUHwEy8wwDjxBTCnU
	QH4Ri1svCCnrEG8/ijMK16HWStPcvS/9ATygrlJEvr8xleRLF91mxgMtCV5hMwnRDwjiBW7r3Cj
	zU8SA2zcih+fHx3FeqP3q03wpYjEEikHGG79uxike48
X-Received: by 2002:a05:6820:217:b0:6ae:42c7:ef83 with SMTP id 006d021491bc7-6b13bdbf028mr9701164eaf.0.1787194942378;
        Wed, 19 Aug 2026 20:02:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77be3sm11302733eec.10.2026.08.19.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:02:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ajd@linux.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [BUG] powerpc: userspace processes crash in ld64.so.2 when running recent linux-next kernels
In-Reply-To: <eff5c192-ed33-44e8-8834-fa5b4803f39b@kernel.org>
Date: Thu, 20 Aug 2026 08:13:22 +0530
Message-ID: <lda1jyut.ritesh.list@gmail.com>
References: <75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com> <627c5c2f-a0b3-4fba-811f-7b4ed4c74dbb@linux.ibm.com> <eff5c192-ed33-44e8-8834-fa5b4803f39b@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 11/08/2026 à 06:23, Venkat Rao Bagalkote a écrit :
>> 
>> As part of debugging and suggested by Maddy, I reverted the following 
>> commit:
>> 
>>    263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for 
>> ptrace")
>> 
>> and rebuilt/booted linux-next with only that change reverted.
>> 
>> After booting the reverted kernel, I rebuilt the latest upstream kernel
>> using the same userspace and toolchain. The build completed
>> successfully and I did not observe any of the ld64.so.2 userspace
>> segfaults that were previously seen during kernel compilation.
>> 
>> Kernel used for testing:
>> 
>>    7.2.0-rc5-next-20260731-00001-g79d9c1ce90a9
>> 
>> Top of tree:
>> 
>>    commit 79d9c1ce90a9873422ca4d6d0124a1d1c10a098c
>>    Revert "powerpc: Fix exit_flags field placement in pt_regs for ptrace"
>> 
>> The upstream kernel build completed successfully:
>> 
>>    INSTALL /lib/modules/7.2.0-rc7/kernel/net/openvswitch/vport-gre.ko
>>    DEPMOD  /lib/modules/7.2.0-rc7
>>    INSTALL /boot
>> 
>> Based on this testing, reverting commit 263e5159e00a appears to
>> eliminate the random userspace crashes observed during kernel builds,
>> suggesting that the issue may be related to that change.
>
> But commit 263e5159e00a fixes commit d7a6797e0bc1 ("powerpc: add 
> exit_flags field in pt_regs"), by reverting commit 263e5159e00a you 
> re-introduce other bugs.
>
> It's a bit difficult to see what commit 263e5159e00a is doing exactly, 
> most of it is a revert of commit d7a6797e0bc1 but it does something 
> instead. Need to see what remains with both commits applied.
>

Looking at the diff - I had shared a diff internally with Venkat.
Thought of doing the same here too. This seems to be holding up for him
in his internal testing. I haven't fully gone through this path yet to
send an official patch - but hopefully will do that soon!

syscall_exit_prepare() record _TIF_RESTOREALL value in exit_result, but
if for some reason (e.g. like an interrupt pending), if we go via
syscall_exit_restart(), then we are returning ret from here and loosing
the _TIF_RESTOREALL value which was captured earlier. So instead I
believe we should return regs->exit_result from here.

I see that we were returning exit_result prior to the culprit patch.

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 5b88bf72786c..bf167a41a820 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -175,7 +175,13 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
 	regs->exit_result |= ret;

-	return ret;
+	return regs->exit_result;
 }
 #endif

-ritesh


