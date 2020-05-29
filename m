Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34FDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 02:58:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6AC207D3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 02:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yoen25fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6AC207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Y8QX6xYHzDqZF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 12:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Yoen25fe; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Y8NF26mwzDqYS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 12:56:26 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id y5so756019iob.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i1zQ861sfX47DFJjD1z9YEvRciLbRe+24tk+FJVMwXo=;
 b=Yoen25fe36S8YTdXH5e2r5GvSPsl/fTRbqnS8kgH8MIavbJASOpS9ZmODZidSsQzSP
 +OXIj27u609SM4nWctORqCSaz6LGA+OYNLTMBvkwQEnK6CU4C5AGf8eSY4ZCWZWPxhTF
 SbwkhB3TKEwD6vAfUXEc3ZMaZuWLPatT0nfU0dpN0Tab7Bhr5PxfiHk7UtRJ87H048fL
 8WYlInOu42yF6qdALjpYrHEJmfxvIFffrUiFH6nCzr3rIoeJauJAtu4AciW+qPahQFWO
 16u3tGfxQsCxI5zll6LZ5mxhRz+f0+BTBVFni3zxzjOdluzRm/6NXCHQb+MOz+E8FP8H
 JI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i1zQ861sfX47DFJjD1z9YEvRciLbRe+24tk+FJVMwXo=;
 b=UUVr+ZUUeYZ2N5X4yzLLOvmqijc+fqXvbAENlx9Wnbl0MKysxZiCcX3LAHS0DPgbUT
 GO1f/z3xLZCKuqHV/Sb7xgFeqx1Xz4RKu5dX+kzrfeSr0wYou9HFEIsm+pc1ZSMzo7kv
 vFyjSHH5DkWWxbhV+G01B9H00A1BquuNS8vE+jjcGJOTlnXpVPl9+or38DaPhbZ4c/Qi
 h8KIYbi6f3TOtLW/A0TGgtPSwZziMH3TaY4HPiufGsU6R6GqNUe80Ov9pE7aWfRwSNiF
 v99fDEWKFy8qiDuJuenvvoVo/Ax1BOah1279zMy7EDbYmVXbmpUufL+NUvuj4/qJRlKs
 Kksw==
X-Gm-Message-State: AOAM530VY6VT5GV1UUU1HvkUsBYsUhzR/CAeCD+LaWX6N26igaDoTsUh
 wFRa4F3tFzRRJKJTH2Kr+G+lmK4d8lXmkeEiDNw=
X-Google-Smtp-Source: ABdhPJy2i9Bet9sfF1H0jEknxNbtXGxCiOKK+8NHMOO+3Iw6O3/ELPjFzFGchCmIs8JMOMHol0pgtyzXwGbckziydjs=
X-Received: by 2002:a5d:9758:: with SMTP id c24mr4782614ioo.144.1590720982223; 
 Thu, 28 May 2020 19:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <1590499319-6472-1-git-send-email-wenxiong@linux.vnet.ibm.com>
In-Reply-To: <1590499319-6472-1-git-send-email-wenxiong@linux.vnet.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 29 May 2020 12:56:10 +1000
Message-ID: <CAOSf1CHRJbcS8EX1-rGOCqPgMqMQjKfdkqeoQg1k379jbMx+AQ@mail.gmail.com>
Subject: Re: powerpc/pci: [PATCH 1/1 V3] PCIE PHB reset
To: wenxiong@linux.vnet.ibm.com
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
Cc: Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, wenxiong@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 27, 2020 at 12:48 AM <wenxiong@linux.vnet.ibm.com> wrote:
>
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>
> Several device drivers hit EEH(Extended Error handling) when triggering
> kdump on Pseries PowerVM. This patch implemented a reset of the PHBs
> in pci general code when triggering kdump. PHB reset stop all PCI
> transactions from normal kernel. We have tested the patch in several
> enviroments:
> - direct slot adapters
> - adapters under the switch
> - a VF adapter in PowerVM
> - a VF adapter/adapter in KVM guest.
>
> Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>

Can you include a patch changelog in future. It's helpful to see what
we need to look at specificly when you post a new revision of a patch.
Looks good to me otherwise.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
