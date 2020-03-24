Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACBC4332B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 11:09:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763B220786
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVX4yLyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mpRK48ytzDqty
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 22:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=afzal.mohd.ma@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oVX4yLyb; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mpNP6hHDzDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 22:06:43 +1100 (AEDT)
Received: by mail-pj1-x1043.google.com with SMTP id hg10so1334075pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 04:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W2zZIBrFIUdIwJtiA0rHIIgEIRNeZEGmX6yVzyUZvcU=;
 b=oVX4yLyb5aLdnDPwC6UADVmWbjxBpmsWAqZNIVQkDWjtUja3ZmwH6bPKE/lhYj1E+z
 KZHq73DSe3wsRdhB9iQwRmYAzFvLXQW0h9v8Q86SqDWGvMKkJ7p0aN05ttV0BPbHXXmb
 EW56hwB8e8dgWPV2NLU8m0mvyOFwbsTqiyDe/Jie768Nr64T9YbDj5EgYlgPShbhyyhe
 aRaWjSdG+i0mA6veN8WOGvvUr2K8jaxFuLzkz9V51b3ue0nq3qNeCL91Ram/rNqzFdaq
 9YSADk86aYG33/NL+L6aNw4kyS2HnEhF5skYdNoV87DNAuB+R9diYHZcOzYZ8R7XxaRe
 qNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W2zZIBrFIUdIwJtiA0rHIIgEIRNeZEGmX6yVzyUZvcU=;
 b=X1byz+R5rGjgbM6f9j6Ly6hRQpV5MKWyUFp9mjHKaXNx6cPX6kTpZyIlBwpN9liJ3U
 GJxj2sMNZhCt1hJGuZpO11Mgs+BVim03vi/z6SFx2jpvvGs9snei7gSloXfNWAQvJep/
 qpF99kM/7XW2sO2kR5wcZwNiBucsjQ2YzwNMpSSrWmLOS9JefG47Rj+rUkpnYbF9j6eO
 vgyrjCUwKwk31LIEoNNFARVgs7cdD4Md/DVdagI6fpx91kBoNvnvI/bewyc3PaXzKGiD
 P/XermzKGvcfeO9Lm3HewLOKKDnX1Bmy9oYOD/whqLYp5hpNmV7/kbjz2dH4N3hhtR3o
 F3aA==
X-Gm-Message-State: ANhLgQ2PnMcJ59JHFZG21No6HCYA7l4mm23LMVtI7emNLefFyg2re3lc
 QV3wmyx2cvZTtqiiqXBO6Jg=
X-Google-Smtp-Source: ADFU+vukAws34i1riRLz0FLNUO0kB8kxFAaHg2peUeXCCNis1uXRRG22cmYupdWicicN+fxtnlNVvA==
X-Received: by 2002:a17:90a:e003:: with SMTP id
 u3mr2981827pjy.157.1585047999939; 
 Tue, 24 Mar 2020 04:06:39 -0700 (PDT)
Received: from localhost ([49.207.53.57])
 by smtp.gmail.com with ESMTPSA id g7sm1997709pjl.17.2020.03.24.04.06.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 04:06:39 -0700 (PDT)
Date: Tue, 24 Mar 2020 16:36:37 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] powerpc: Replace setup_irq() by request_irq()
Message-ID: <20200324110637.GA5836@afzalpc>
References: <20200304004746.4557-1-afzal.mohd.ma@gmail.com>
 <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael Ellerman,

On Thu, Mar 12, 2020 at 12:12:55PM +0530, afzal mohammed wrote:

> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

This patch is seen in next-test branch for last 4-5 days, i don't know
exactly how powerpc workflow happens, so a question - this would be
appear in linux-next soon right ? (for last 4-5 days i had been daily
checking -next, but not appearing there).

Sorry for the query for this trivial patch, i am asking because Thomas
had mentioned [1] to get setup_irq() cleanup thr' respective
maintainers (earlier it was part of tree-wide series), check -next after
-rc6 & resubmit ignored ones to him, this patch is neither in -next,
neither ignored, so i am at a loss what to do :(

And i would prefer to let each patch go thr' respective maintainers so
that only least patches has to be sent to Thomas. Bigger problem is that
core removal patch of setup_irq() can be sent to him only after making
sure that it's tree-wide usage has been removed.

Regards
afzal


[1] https://lkml.kernel.org/r/87y2somido.fsf@nanos.tec.linutronix.de
