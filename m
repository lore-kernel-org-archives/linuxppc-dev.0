Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75151C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:37:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D4820684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF9NCtYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D4820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4XW54MpzF3F1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:37:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MF9NCtYw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MF9NCtYw"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q4Ts38kLzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:34:57 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id r9-v6so1016489pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 22:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sU+RlzQwpHQmjVHAdy+7Inog0oYWRDZdUfJUv3fYuzI=;
 b=MF9NCtYwq1KkrCdKFnUUmUEY5etDFBsf+c1eCtwuvoXJektvpJFkSGV0nAD6ZgP2UG
 4KC/bslp94rXL42Us9Mll3kBTuekYHSn7BaW1gzuo2K7rR8toTiUorNtdabXXtDyu2Ge
 c0I/8D0S70Xnl22Y5g36kJuA6WxPm2YAQVK+9h68TDpBOf453r0Z+ZxMmEpfz+r3F8gS
 dMV8D5eKK+Vx9CMxCs+1iJbKhFIkZmEzRmlhK1cBr0I4tfpTFOMAQw5bnD1P6OE8EEFs
 qiQteeCbdTWmxrqUElSzxARXmiPQ4BVwktwwSIb2lqFNNTb0T48wwiY3+E9Ti2brw3ns
 yrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sU+RlzQwpHQmjVHAdy+7Inog0oYWRDZdUfJUv3fYuzI=;
 b=kgJWPyVvN1z6K/7Qe3S1HwinRnEJovRoDbgJr/o6S7IKX7yhT/f8+PRQrPNrJ2LgP6
 YpL72YZijHLhdZ1UZV5gk/RghVlaZIFZqozuWXe2R+Pd0/Z4uyJZLIzQmlHsr99gvc5z
 WUWVBwgk1DO33vmLvX+l5MU7iS4gBQKXfzSTv3w3DVE+OEnwXv4dGUjXWUEFlq7JVbe0
 oYdAWXIYvPC7MfLaYamykQVbqNTRUkTSZ/1EpHC117zlsyCY7tMp30pWaBdoIyngE6iU
 bpeb6oQ1K3sq9hd2vzcZBgDt2TdInJaSQAqZ4pgYxZJ5gnCGiyxGMuKmXDrR2uzTK4qP
 mzRA==
X-Gm-Message-State: ABuFfohqx/iuoP3c6+JxwqWmWNDFsA8zE/o7NbYyv4T1kvs22fS4LThd
 NCL8yNz6UQA8LP3eDok0hH4=
X-Google-Smtp-Source: ACcGV60JAzd6Q4lnhywuiwaHdQvlhCybkh1bM0jV+ZlrpPAbBebvFfQIEzxXf7g/R6qrm1hh+gL9Fw==
X-Received: by 2002:a65:65c6:: with SMTP id
 y6-v6mr16785595pgv.233.1538544895155; 
 Tue, 02 Oct 2018 22:34:55 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id o24-v6sm623719pfa.90.2018.10.02.22.34.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 22:34:54 -0700 (PDT)
Date: Wed, 3 Oct 2018 15:34:48 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
In-Reply-To: <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> thread_info is not anymore in the stack, so the entire stack
> can now be used.

Nice.

> 
> In the meantime, all pointers to the stacks are not anymore
> pointers to thread_info so this patch changes them to void*

Wasn't this previously effectively already the case with patch
3/7? You had thread_info sized space left there, but it was not
used or initialized right? Does it make sense to move this part
of it to the previous patch?

Thanks,
Nick
