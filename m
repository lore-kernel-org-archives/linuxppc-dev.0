Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6BCC46475
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:38:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B29A204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 00:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9vlW+Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B29A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h4ph3DxPzF3FX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 11:38:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j9vlW+Gt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::b42; helo=mail-yb1-xb42.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="j9vlW+Gt";
 dkim-atps=neutral
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h4m05N0dzF3FN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 11:35:44 +1100 (AEDT)
Received: by mail-yb1-xb42.google.com with SMTP id v92-v6so4487680ybi.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AOBeJsuDOQzixFAL1BBGY0E2T48vSf4cfkFv6TWqHuY=;
 b=j9vlW+GtEcFAAZKRfy5R1RnMB4Oj9EjvIXbyLSkmgbnP+h1tGaZnrq+dpa7wVZb4Vc
 aOUp7+z1C2cRaqjR2SIujlyHtdMQ5sl1qLqfw7NVUDHxsjwyHaWRDtYOxEGOYrRn0JVc
 q51XcQu/foIUAAYTBTOdmoBGKEzVEQQ5noFyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AOBeJsuDOQzixFAL1BBGY0E2T48vSf4cfkFv6TWqHuY=;
 b=HXoX8NKN0hDEDc6mfJtLi0wGHMehaqj+OMgesNvrJ/+Hx2BquIXUih05CwaMaLSwrz
 19y5azJwWYeClFJoXfPEd1C5Vz3U3hX5RINsWsrPAbPSBJjULQ0yv8EruElH+IjTGiQK
 EbeO8FxkFtDA4MI8alHOfM3XwiN23LKrdvbd0yVNVJ3A02cEGmuJyZrBLvMQ68cOTV2m
 uLp92U0Z/Sf5999WtAIHfiAxwcv90Bz5hZZoBJuaA3NiSylz1KmT+ytnsQCtRjOn5fv2
 j+J8ippqH8d+Gckyv5CSJ/pqQ0LY4kF8sAt3XFixJ9lWJsMSAWas2aRhJREw3fJS8tXP
 LjAQ==
X-Gm-Message-State: AGRZ1gLgq6T2Q7RTEyavgKEq0aQljhyfDiYv4wVUlHLAbT/0azScsanr
 8S8s9lQkGLD1yMDn5sLWVb1KMUJEejjBuA==
X-Google-Smtp-Source: AJdET5cN5VzAM1wobInkjke6YKEnhq+D+e9Ximy3vnz+HBt1gwczw9J1voyZW8+wK1Vew6IaWlyIJg==
X-Received: by 2002:a25:bf81:: with SMTP id
 l1-v6mr1464765ybk.492.1540514142053; 
 Thu, 25 Oct 2018 17:35:42 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com.
 [209.85.161.50])
 by smtp.gmail.com with ESMTPSA id l5-v6sm2091731ywm.70.2018.10.25.17.35.40
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 17:35:40 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id c126-v6so1358547ywd.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 17:35:40 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id
 p126-v6mr1549347ywd.288.1540514140022; 
 Thu, 25 Oct 2018 17:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 17:35:39
 -0700 (PDT)
In-Reply-To: <CALCETrX_E5_p1-MjCcdtRQbziCCzXcOCfxRBckZx_zbO1QX=Dw@mail.gmail.com>
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
 <875zxqo0ee.fsf@oldenburg.str.redhat.com>
 <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
 <CALCETrX_E5_p1-MjCcdtRQbziCCzXcOCfxRBckZx_zbO1QX=Dw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 26 Oct 2018 01:35:39 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLE2VBqo_rkBJ+BJkp1==WLLg=N=-3gjTCCjcN1=bodSg@mail.gmail.com>
Message-ID: <CAGXu5jLE2VBqo_rkBJ+BJkp1==WLLg=N=-3gjTCCjcN1=bodSg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
To: Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Florian Weimer <fweimer@redhat.com>, Will Drewry <wad@chromium.org>,
 Linux API <linux-api@vger.kernel.org>, linuxram@us.ibm.com,
 Michael Sammler <msammler@mpi-sws.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 12:00 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> You could bite the bullet and add seccomp eBPF support :)

I'm not convinced this is a good enough reason for gaining the eBPF
attack surface yet.

-Kees

-- 
Kees Cook
