Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB74CECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 21:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9D20825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2E+YnUny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rc5C0dvbzF3Tq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 08:35:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="2E+YnUny";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="2E+YnUny"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rc2m1TtNzF3Tf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 08:33:03 +1100 (AEDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5159F20825
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541712781;
 bh=rn8m6ZGX1qolOvHYe1yPuS+ma5B5wnWHPjTFipsgjl4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2E+YnUnyqJtJ6/v7U99OTwNxbJRvOA5NvR6RmhaTEPOmlrcK952VEUm15vKMSqi4k
 FRqIQ/O3VCGLK/tED/qCQ3Oz0dsfDZHYlcviuVXB5gJdBDxkbgwYldeQVzXQWogLg6
 Wa/LUJSDc06IUnc322l83r68vBnNR3pWwLUn/W4M=
Received: by mail-qk1-f177.google.com with SMTP id r71so29164320qkr.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 13:33:01 -0800 (PST)
X-Gm-Message-State: AGRZ1gKIHUnjGU17modiyMOUl9H1muQF2ANSipXgyHjPVMqSWf0BxEIQ
 AyWFxI0bhVflResqqHr832zZwxlqOwro0Dk0Ug==
X-Google-Smtp-Source: AJdET5eY2VfbmzYk7BckGu+AJJlE+patZUEX8bwwL7EE8AT8xgz+xkMkMbfQK/BSaE76onKCX4BbztcNBjsrT8/AuOA=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr6305990qve.246.1541712780520; 
 Thu, 08 Nov 2018 13:33:00 -0800 (PST)
MIME-Version: 1.0
References: <CAApg2=QtTWxi6rhC-r971-HXPP2QEP=ZRRwS7nHQjKRMLGct7g@mail.gmail.com>
In-Reply-To: <CAApg2=QtTWxi6rhC-r971-HXPP2QEP=ZRRwS7nHQjKRMLGct7g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Nov 2018 15:32:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+7=zB3ze8cPNC1wZHX_FhP6wF9Xvrb_rTDgH90PDXzQ@mail.gmail.com>
Message-ID: <CAL_JsqL+7=zB3ze8cPNC1wZHX_FhP6wF9Xvrb_rTDgH90PDXzQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] Devicetree schema
To: rybczynska@gmail.com
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
Cc: devicetree@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <glikely@secretlab.ca>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 8, 2018 at 1:54 PM Marta Rybczynska <rybczynska@gmail.com> wrote:
>
> Rob,
> The patch set does convert the documentation files. Could you explain
> the workflow of verifying a DTS? From what I can understand we can
> validate YAML devicetrees, and the schema files against the
> meta-schemas, but I see no tool for DTS to YAML conversion in your
> tools. Do you use https://github.com/pantoniou/yamldt ?

No, I'm not using that. dtc supports yaml output now. The kernel copy
of dtc has this support in 4.20. You need libyaml headers installed to
enable the support. The output format is intended only for validation
and could possibly change.

The 'dtbs_check' target will do a dts->dt.yaml pass of all targets in
$(dtb-y) with dtc and then run the .dt.yaml files through the schema
validation.

There's also a presentation here:
https://connect.linaro.org/resources/yvr18/yvr18-404/

Rob
