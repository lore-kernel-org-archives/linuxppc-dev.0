Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810DBC7112A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 23:46:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E3520652
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZAeeX+Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E3520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YJBL36RPzF0Tn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:46:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZAeeX+Gj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="ZAeeX+Gj"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YJ7h68Y2zF08G
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 10:44:13 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id x4so15825666otg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YhmQoxn/kSEyoT58skPRc2H3TXgb42hX3LpHF55iSeM=;
 b=ZAeeX+Gjsu4+7KJeRjYI88/fiCrnRU995ljiF42UWP8eXemllhCwxCwmH0dGO9c2Fo
 EWu1+RaiCiSMqyvjk03toxk0vCpvoYSYemDf68Wnx2bV6FLo4vsEehGA2u1SII/VdKDx
 98ZK5bx7MfVY+8hcYqA9s185rc89eDyIhkc7Ma33o2+KXyOVoauHmJoKb0fUtiAJ/S51
 O1KI9m+pqkkOju/4XGjd+HiltkseBCVHQN3BRF+3Ka67sJ/pIH7O6NXfApFXOMYtQpim
 AFFnp/gQ8cf2G/b73R8r7FsUnGGjV6ocuaoCzVcTEoI2Nv9WnFp33v5tBWJMF8KwwUit
 t0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YhmQoxn/kSEyoT58skPRc2H3TXgb42hX3LpHF55iSeM=;
 b=AkF68qnXNnd+XNWXpseZX3/YNv6GfxcAwrhzpBE/RcbV6NlbvDlHV76AAgzzJni2B4
 A17A7EAnWd0TUDYXSf2QvZZ3/J5a9So7ycj+DQjrUOjp60orQMEqKnESrgw3c6CHP4j3
 icpLECQmE8LSwKZZcRpGg45nCu39DgifNUtIbY2vzb+pW9VCoQ2G9DEhBRPhdt8j4GCX
 UaonAVmpmPgVVN8ZZLeNDmQJlYX6Vcl8bRJ2uHK9qa+zaz4Wav/9v+S64ugzJ4wTkxca
 BIZtdMlQg+gbrwLUNDDdXrFM6c/WJr+Ykr2pTREAqRYWadZayqEZHhrUjw6vSuaeFDdH
 AXOA==
X-Gm-Message-State: ABuFfogyCS1MtpCEv9jq24Z+al2NsP81p4kZJmJ4Leu+wWaGEXkJ1MzP
 se/1jFRTKWQpl9HvSdio0sP1MxHzABFdF/eFTK+cYg==
X-Google-Smtp-Source: ACcGV600rX/c57PXOjluVBnyYIXvsF3anKlaT4UnGKkBhfnJdfTK+rRsDl4W4sEorJJG2X4L1uzd8VsCcWjPq1Bo3AY=
X-Received: by 2002:a9d:758f:: with SMTP id s15mr9191195otk.353.1539560651058; 
 Sun, 14 Oct 2018 16:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181014231828.17139-1-oohall@gmail.com>
 <20181014231828.17139-2-oohall@gmail.com>
In-Reply-To: <20181014231828.17139-2-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 14 Oct 2018 16:43:59 -0700
Message-ID: <CAPcyv4jr4Y66wt7KtE7ke9OGX6kqNDQkO6yqAP8iaa2BzgdW2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: Add driver for PAPR SCM regions
To: "Oliver O'Halloran" <oohall@gmail.com>
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Oct 14, 2018 at 4:19 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> Adds a driver that implements support for enabling and accessing PAPR
> SCM regions. Unfortunately due to how the PAPR interface works we can't
> use the existing of_pmem driver (yet) because:
>
>  a) The guest is required to use the H_SCM_BIND_MEM h-call to add
>     add the SCM region to it's physical address space, and
>  b) There is currently no mechanism for relating a bare of_pmem region
>     to the backing DIMM (or not-a-DIMM for our case).
>
> Both of these are easily handled by rolling the functionality into a
> seperate driver so here we are...
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> The alternative implementation here is that we have the pseries code
> do the h-calls and craft a pmem-region@<addr> node based on that.
> However, that doesn't solve b) and mpe has expressed his dislike of
> adding new stuff to the DT at runtime so i'd say that's a non-starter.
> ---
> v2: no change
> v3: Corrected the mapping to use a DPA start address of zero
>     Added cond_resched() calls in the bind/unbind loops

Looks good, could I trouble you for an ack on the build / merge fix?

https://patchwork.kernel.org/patch/10640385/
