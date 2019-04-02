Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43066C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:37:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C21F20700
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PEbeytWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C21F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ykc82gxmzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:37:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yfb94xtKzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 06:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="PEbeytWV"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Yfb919Q1z8tQ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 06:36:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Yfb85FNPz9sSW; Wed,  3 Apr 2019 06:36:20 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="PEbeytWV"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Yfb80Pllz9sSV
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 06:36:17 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id f6so11993173iop.3
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Apr 2019 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zlRxsviX0XesyuTOpTmBSNbFYjdf1o9JPP/X25S5UL4=;
 b=PEbeytWVtViSAydL5WdHTirzQN4gHa9ndPh7VqRvjuA5k2wU2F2wOZglNt8TgXiMIZ
 iO/s7uaH2MWdhOPNT4DEuk2v2PlXbSPr5n8johK7kinMWy2OozUgLgOxMsxgeIdugFm3
 thBDMQjnXI70ElXcM7/ttNvaLBWpNCDGYm6/ZvSDT3PTuZwndYWhhzB8FEefAhauPxUD
 22iqlekPFRVhasBxX7wQUTmCEWXmPKL7080LY7Z3fzJh52XpGk/nxgxMkwjfq1Cy+6+Q
 v6n3E/4MuyBukippPY0/o47/Ptb07VX2nPTB7SAcEW441L/FMgbv9TFKoqCYT2s+bW4e
 /iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zlRxsviX0XesyuTOpTmBSNbFYjdf1o9JPP/X25S5UL4=;
 b=TMMF4v3molHNJLfmMTmrWaos328C1qc5YDzWLtAVoMQ+SSYq5Bvlcijvf/ElQhcUJ9
 2EXwABmhECZQXSRN4aOGaI+6CChwLShkXkb6MQqEcRWDdtV3z3aoZb/5/id7XPU9tWyL
 ZmqmQKUcCbGGO18V/Yyk/DJ8JJEpW2T3QngUayj51OyoInkTTxDxML1Zt7HsoQWiLvAz
 pED4lZi7dfc6h894sn3bdDqX6xENoFMHl4T930xBfvnzI+xaBTiPnAZQOmsBhL3YgYVB
 Dtcugm0J/dZDfTLnQdxQni6W15sUAGvrot0sVVel6tyiXmLXlkkpWLH0YIMoVjRKrYEK
 FreQ==
X-Gm-Message-State: APjAAAUBR8ptxpZRlf9PjMohpJJX3d+1Y+nYtWpwVutgOIakJmVYpoGf
 lXFhxjTQCxY1S5QcKx9Duga7WQvRtClU0rREx2zqgg==
X-Google-Smtp-Source: APXvYqwscRaXroHB1AxWrjj5kHT1xeAOuyDfNgXvFlQkd6aLAI5EcCPflk+ZfStfDPgxifFf/bp5MRKYdgGf5SDI/y4=
X-Received: by 2002:a6b:3106:: with SMTP id j6mr5287705ioa.147.1554233774199; 
 Tue, 02 Apr 2019 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
In-Reply-To: <20190402181505.25037-1-cclaudio@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 2 Apr 2019 12:36:03 -0700
Message-ID: <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 03 Apr 2019 09:36:03 +1100
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Nayna Jain <nayna@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 linux-integrity <linux-integrity@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 2, 2019 at 11:15 AM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
> 1. Enable efivarfs by selecting CONFIG_EFI in the CONFIG_OPAL_SECVAR
>    introduced in this patch set. With CONFIG_EFIVAR_FS, userspace tools can
>    be used to manage the secure variables.

efivarfs has some pretty significant behavioural semantics that
directly reflect the EFI specification. Using it to expose non-EFI
variable data feels like it's going to increase fragility - there's a
risk that we'll change things in a way that makes sense for the EFI
spec but breaks your use case. Is the desire to use efivarfs to
maintain consistency with existing userland tooling, or just to avoid
having a separate filesystem?
