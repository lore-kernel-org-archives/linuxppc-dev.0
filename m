Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49003ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B512320825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJMf/8d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B512320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rbDW3VZVzF3Tq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:56:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJMf/8d5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=rybczynska@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJMf/8d5"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rYsW40xZzF3Rv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 06:54:52 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id z33so19191398otz.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 11:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=S/6TOQ/xMZSSKRdQpmhzqoBqhGe67zRjkcq1o2WgijU=;
 b=MJMf/8d58YijfkjazEbQKvWjwOO/Q5Sp2sXYwDcg+sHM7e08vZa76gMG4CkDYRQou0
 6d/lYfIIN3r5Y5pTf6b++j00DIE4n841vS4c5tGmTcQnvdXDT3UbQ0bQkVVe1jkPQKgu
 PHISTcsjNHIPqzi2rXFrHjg653Y5M4gXRZtLxRM6Enuf2HNlLOGIxguR0HFJjpDYdCuf
 8IQnyKL2plLsK+f91Rn5pmIDHqQZWQPN2gR5krwWm1AHWPjvfVCoEh2QKkxSYkZVdmNX
 krY7j1w74xmv24FEKyFo79wANuN1P+ZIN49fxj0DQ3Oj20yLzZSOdsLA+td0JAeSU4Du
 trsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=S/6TOQ/xMZSSKRdQpmhzqoBqhGe67zRjkcq1o2WgijU=;
 b=CahBpT1xC4IulE4uYnFl5RB4AiXBTBmbvjhaYtgu5Z3cCTdj9Z3A/LvXDA0ndRRK03
 yCw6m7QQGIpHGUeAkqYWkyw2jO7C7KbiAsBuwMfe3Mpl+FrTsdPnjpt6/jX/Sc9Ky8vv
 PJ1hQc1wLi+2DgOR02RHS701INoHg66/p4wiAxRmm8vIxTUhvi7/HkpR7Yi33hH/XxB6
 Y65LNYtMg9up5N0WcI5+6hK+3zkAZkRZlLTwLEZFUZwWmQxL0+U2M3JEf9UBYxFxarhs
 /JiEB9Mmoke2mdp9BbX6IrF93EnZUJoWTPiqZx6UCbNbxn5fxSCDfQqmorM2wELquOeY
 c3jQ==
X-Gm-Message-State: AGRZ1gKCNUSSqPJIIGHkkNN5KOd+3fOgXgKAz0/So6Sbus2oGjz32FPc
 T9EX2XeY8MFuov96eKVLkYurXh3Aldnb2TqzbKo=
X-Google-Smtp-Source: AJdET5dFFGKYsakB7hcxIa+WK04qLn+vpo2iCCSgupLKf2gSUzFJpFNjIozojhZnv9JcczHXgAmXl5VnXAOEKp/5FwY=
X-Received: by 2002:a9d:59d0:: with SMTP id u16mr3752914otg.265.1541706889398; 
 Thu, 08 Nov 2018 11:54:49 -0800 (PST)
MIME-Version: 1.0
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 8 Nov 2018 20:54:36 +0100
Message-ID: <CAApg2=QtTWxi6rhC-r971-HXPP2QEP=ZRRwS7nHQjKRMLGct7g@mail.gmail.com>
Subject: Re: [PATCH 00/36] Devicetree schema
To: robh@kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 09 Nov 2018 07:47:53 +1100
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
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Grant Likely <glikely@secretlab.ca>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rob,
The patch set does convert the documentation files. Could you explain
the workflow of verifying a DTS? From what I can understand we can
validate YAML devicetrees, and the schema files against the
meta-schemas, but I see no tool for DTS to YAML conversion in your
tools. Do you use https://github.com/pantoniou/yamldt ?

Thanks,
Marta
