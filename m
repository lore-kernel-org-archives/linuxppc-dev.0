Return-Path: <SRS0=+K1p=CZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775FC43461
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 11:53:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D2922208
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNTpNjlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Brz5T5hGYzDqJX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 21:53:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::242;
 helo=mail-lj1-x242.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rNTpNjlo; dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Brz3Y2gVfzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 21:52:08 +1000 (AEST)
Received: by mail-lj1-x242.google.com with SMTP id n25so5663088ljj.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
 b=rNTpNjloivgL4IIauQWwsnW3KxFixBc/ITJAbmTyYNUMIyMEtpg9ZBa48r6s6fWkYd
 /NfUhyCTCCGtfo4ijiup9gAKreg7Bs7UIPUy0PiJqYyXqvz79OMc2HMYFSibNNsuytD+
 1GRo7G6lEiQwDX+QJ7aWDh8rHqBvf6EyxvLp2yy5T9ENaAZDZzpf4RqYI4x/oCagOemc
 Ja0kUPbj7gs0YCQEf5nPzBV1F46VmAvwn5sEw7qX0W9GCZMqTz8aSq5ygPvz1N+shfms
 3aJJ+nYGGWY+EnxEmJ+aeLDed6RubyY6R3r4JDiejlYeeNMii+nbcxI3mM0jyTSPfW6v
 C8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
 b=UWsgKrLmyL3/dVhxYn+1OvdO2wL0ZfD7dJheMcpiQBKDW0/zuYJkUNEw3DXGXxjqnE
 37cjjCWXKlX7v4fW29iZayLux6aQWJABFDj4gr+vHplnmLODf6Jmxk5Iu+yx6qIzr3BE
 WBqlov9dRpOID9XcX09HciespJho2j3LXnDBpdRT8+BDKleVTO/FiZU4pKmNTrlLctLr
 8KcrcQUAy3xfaM0v9z7JViHy9Cg/6ocgl7dPQwNnnzujRvuhmdHsoheoygjOAIZW8Evt
 JNr9k6RD/AoEMgfNQrpY82A3bvr+mV+rfuytELlzpQUeS5oDEnS08bmW9OaNwggT5iFZ
 Q79g==
X-Gm-Message-State: AOAM532CQGFJuLp1hLWwaq4yx35oHRaIvF5Mm1kmCLvljJSiswRl2swE
 Zr/MVJ2buDKs107KoNOI8w3QhaLcPR68xVYIWb0=
X-Google-Smtp-Source: ABdhPJzc002ZLUmgbuaE62WjRqkY0WfMHJ0a+m0maYHyQ6/Z/CBGbgoyR3VB9GpneRsAU37REZo3nFwFnQ/HWmLHjIE=
X-Received: by 2002:a2e:1444:: with SMTP id 4mr7758634lju.218.1600257125682;
 Wed, 16 Sep 2020 04:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
In-Reply-To: <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Sep 2020 08:51:54 -0300
Message-ID: <CAOMZO5CEViX6E8sNo0LROk3Y92_BCezHDpfBqMaQK_J4kT24yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: update the register list
To: Shengjiu Wang <shengjiu.wang@nxp.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 16, 2020 at 8:47 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Knob kmg

Please ignore. It seems my cellphone wanted to write something.
