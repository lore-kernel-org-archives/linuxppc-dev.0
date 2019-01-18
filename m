Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED05C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 08:29:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B85720823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 08:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B85720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gvHV192WzDqvh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:29:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.54; helo=mail-ot1-f54.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gvFW0KL6zDqrM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 19:27:26 +1100 (AEDT)
Received: by mail-ot1-f54.google.com with SMTP id v23so13661680otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 00:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=MtQ/VdaFajP08UEagSHbe13lpSuaQTRJiTyrcAa5DlA=;
 b=p/WpxnUSopfW5X84tVYQurZkj+wSiFDzcIlpmQztvTO9viQPWIWOKIPNUo5hp42xFc
 DcMZox57oSFz2beKuHSOVA3OOdp7wkBzP/imZoBwqkd7xuA6ZNI6wCGmvnbL7oR0qpju
 FJolN/HxsArTZTIRavyW50RfKxAdARfzIGZa6y8OA8odZTOpsiZPVJxnEetQ9yDMrp3N
 kAlri16DcL+KjH14ksCqjkOSDWILHCHEkBThVqSfg12jwc5SE2ZZxSbqC0c0SsMRy235
 bz70fGJX1J5wlBiYCgCeeQodquC+ceXHz9Q2Ogtv4x0oqM/yIPtcB5dxBl1gVLiEtjhr
 AlkA==
X-Gm-Message-State: AJcUukea1D5aj7veBLVW+LGn5g6lN6SssN7U4wIgHFZ44DjUxuecZ23l
 a63YRBLlIX/L8HT/6qHJ06eARhyNrmWGd4ZOQyDJxT8Y
X-Google-Smtp-Source: ALg8bN531XOQBBm1tsyGP5wAC+ugFGzOcb1BPK3V0LMO/lm8mcEquNkYQ81ihThs16gh3nPQ/xA+xgJI90R5RLQwj+0=
X-Received: by 2002:a9d:628:: with SMTP id 37mr11481357otn.58.1547800043947;
 Fri, 18 Jan 2019 00:27:23 -0800 (PST)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 18 Jan 2019 09:27:13 +0100
Message-ID: <CA+7wUszR08xgO0e6xU7-kW1SdpxsHpy3dOvg8_HT9JoQ=1UuNg@mail.gmail.com>
Subject: Re: ptrace compile failure with gcc-8.2 on 32-bit powerpc
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Meelis Roos <mroos@linux.ee>,
 Michael Ellerman <mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Yeah I noticed this just yesterday.

Just FYI this has been accepted as regression in gcc, and fixed is
provided for GCC 9.0:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88273
