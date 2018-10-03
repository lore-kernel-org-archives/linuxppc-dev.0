Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEF8C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:45:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F0020835
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOsmrCRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F0020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4kT5bqHzF3Cw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:45:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOsmrCRy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOsmrCRy"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q4d15HpZzF3C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:41:09 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id 23-v6so1018013pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZtSHqbROg5aIdtQ5EV7dkBPXom9wik6oinmHzRs5kyw=;
 b=QOsmrCRyYvXIFMDgJfet9c4+GqiB4aRteyPBBrddzwurHXu6y2K290X2mumQ2sqqsV
 r2xwnYjo2UaEaF1pYYShfL26HCXDwoOMVUbd4hWQLzVCcMdTMZ6BHfSZDXixvr5U0Qe5
 mkR4UccDqyFmrv6/Afsn9rr7YN48BfsOkLj3WRd4fVPh2rlo0LmiQ9JPfhg960PARXEJ
 qHGzPf5suDOsos6JQaHRW9WvD8p2M029OBMDbyz+cRmlvYUTx5Zh1RnKpUU3yceiRrpj
 TxB7b/BqY1wwK66f+g4B26g+uXqQhaW7VGujae1WoQ+sDOfFjr0LZ2IEU8cFAQAHpanO
 esmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZtSHqbROg5aIdtQ5EV7dkBPXom9wik6oinmHzRs5kyw=;
 b=P1A2bEhmr7J+AXbkv9aueJ8PAN9FETuofS6t/RcLWDCThDjGbqApYd+nVtMYvaRkzp
 mxe+UH+19j0vxRyKeS4KmO3Kd6Rz1krgXpdA3aZ3GnC73e5J2r1yBqpSN+yueVpJLLS/
 BSgZDa1LaKtM7nZ1AHjsCTL5WSzJmXvHDUQyBf5sBn3ha48mcmv9lPpO+yadfAybanmI
 0LRcXJ4rqRC1v57OdW5G1fKOgR8hrsKSdQdhrpBKI5ekQ57al4I9ScbjCO3aiCWkxpg1
 86cxvZDXM06tBL3p3+3JUsRhUKBIZXiL1O1BkTlJg6hQMyQM4aUGBYKMrhWsHyhA3e2y
 YePw==
X-Gm-Message-State: ABuFfojCaL0PLGdA1pjCjGZoq6y324Z/UwbPCYDigA3hOG17GRWXrG3l
 nXC/kpqBlPuVpB0hNoORIyk=
X-Google-Smtp-Source: ACcGV61ENre3fHt1Cuk2HQbQdnEq0EX4RWaVnWmKqV9Zr6SeVOBzKaarDhCA43vlBG7TwLF1L9j/NQ==
X-Received: by 2002:a62:9c4a:: with SMTP id
 f71-v6mr14434396pfe.135.1538545267530; 
 Tue, 02 Oct 2018 22:41:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id u21-v6sm531193pfa.176.2018.10.02.22.41.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 22:41:07 -0700 (PDT)
Date: Wed, 3 Oct 2018 15:41:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 5/7] powerpc: 'current_set' is now a table of
 task_struct pointers
Message-ID: <20181003154101.0b46956d@roar.ozlabs.ibm.com>
In-Reply-To: <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
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

On Mon,  1 Oct 2018 12:30:27 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> The table of pointers 'current_set' has been used for retrieving
> the stack and current. They used to be thread_info pointers as
> they were pointing to the stack and current was taken from the
> 'task' field of the thread_info.
> 
> Now, the pointers of 'current_set' table are now both pointers
> to task_struct and pointers to thread_info.
> 
> As they are used to get current, and the stack pointer is
> retrieved from current's stack field, this patch changes
> their type to task_struct, and renames secondary_ti to
> secondary_current.

I'm not sure if current_set is actually needed is it? Because
64-bit already initializes paca->ksave / PACAKSAVE. That might
be a cleanup to do after your series.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

