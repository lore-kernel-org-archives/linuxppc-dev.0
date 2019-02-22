Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4700C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:28:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8014A2075A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtI9tbHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8014A2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Zwp5DslzDqwJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 02:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtI9tbHx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Zrf4rLjzDqhY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 02:24:34 +1100 (AEDT)
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A27CA2070D;
 Fri, 22 Feb 2019 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550849072;
 bh=/yP10i420nOBufkN7+74SgnoiZDxLCuZex89HNy0nOk=;
 h=Date:From:To:To:To:Cc:Cc:Subject:In-Reply-To:References:From;
 b=BtI9tbHx8op30FQfgk1+1GmddYVIhB50awg10t7vHNTXGxlZxvPMezeyrs+GdmTku
 +pxpIUDpQVPYpfG3bqnjZgfGmgloZgSGU+COJFsXMbd/lNexnJKzObQG2n0oITtJRb
 mEvE+6CSGdf6IDYhJCHmWBaaUAMgWDUCB6Exqzng=
Date: Fri, 22 Feb 2019 15:24:31 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Russell Currey <ruscur@russell.cc>
To: kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: Save and restore AMR instead of zeroing
In-Reply-To: <20190220045958.14966-1-ruscur@russell.cc>
References: <20190220045958.14966-1-ruscur@russell.cc>
Message-Id: <20190222152432.A27CA2070D@mail.kernel.org>
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
Cc: , linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: cf43d3b26452 powerpc: Enable pkey subsystem.

The bot has tested the following trees: v4.20.11, v4.19.24.

v4.19.24: Failed to apply! Possible dependencies:
    41f4e631daf8 ("KVM: PPC: Book3S HV: Extract PMU save/restore operations as C-callable functions")
    95a6432ce903 ("KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests")
    d24ea8a7336a ("KVM: PPC: Book3S: Simplify external interrupt handling")
    df709a296ef7 ("KVM: PPC: Book3S HV: Simplify real-mode interrupt handling")
    f7035ce9f1df ("KVM: PPC: Book3S HV: Move interrupt delivery on guest entry to C code")


How should we proceed with this patch?

--
Thanks,
Sasha
