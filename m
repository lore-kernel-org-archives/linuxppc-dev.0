Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01441C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 20:10:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8723320892
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 20:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BNrJ2ZL6zDqJh
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 07:10:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.44; helo=mail-ot1-f44.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BNmc03RRzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 07:07:27 +1100 (AEDT)
Received: by mail-ot1-f44.google.com with SMTP id u16so4927839otk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Dec 2018 12:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=45OSMZA5GZA1nHIdqU8WPRPzWqh2AYXUPZvIynwhWcQ=;
 b=mcR67UQp2B+eb1pxnui6JrmDU5i4YqAJrwxw8CcbrYDo8X10XwciuH7w3FClxFxbV2
 L3bWosmC4FBLu4YV1+D0QJbPXpgWLhLG5H4LZAXd7LSTa5OjXqHMHqai5J4zabgTi2ld
 WIrubG5mVDu+4Quc0RZmTvVAdPSAmfKqucSa8R375tlvOT61aVf4tjurxfBVKcZ7GGbb
 avmpx2js/B6uV9vaBVMRm9wYfATFLVZj/4LiKfDOgpp14Amsk9An8UhYp7LVDmxiqPsY
 pwxOu1Kffbin7aMwMKsHb/5vjJkLXBCiYHCQzpjx4bldprfzCpd3A36Ogu+VEpj+uWaA
 KOeA==
X-Gm-Message-State: AA+aEWY5zc61T/qywk638Dh8E447imT3nImh44rI4n589XykktAZsjzp
 m6iTHummv69kGHVYqpc/aIstjGdcK0lqjRFyD7Fh+Kr1
X-Google-Smtp-Source: AFSGD/WF1EpNFyvS2SFdR+d8BekUBuSUIM3e38awWTK5EZv6xg3fT1C6PlR5VoUi8JtAK+TubwGN3Q6wdMgEiYvM5R4=
X-Received: by 2002:a9d:7201:: with SMTP id u1mr2444873otj.365.1544213245729; 
 Fri, 07 Dec 2018 12:07:25 -0800 (PST)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 7 Dec 2018 21:07:13 +0100
Message-ID: <CA+7wUsxwnYwr+0GrANN01VV_V9-0p5h==eBcCmNm-XEZYhwbOg@mail.gmail.com>
Subject: =?UTF-8?Q?error=3A_no_previous_prototype_for_=E2=80=98pt=5Fregs=5Fcheck=E2=80=99?=
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael,

I have been wondering for a while now, but I failed to make sense of
this function: pt_regs_check (commit 002af9391bfbe). What is this
function meant for ?

Background, it breaks my W=3D1 build with:

../arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype
for =E2=80=98pt_regs_check=E2=80=99 [-Werror=3Dmissing-prototypes]

I failed to find a usage of it within the linux source tree... (git
grep pt_regs_check returns nothing).

Thanks,
