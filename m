Return-Path: <SRS0=eg2t=WC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B39C31E40
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 10:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9C920B1F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 10:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462rR44LqmzDr49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 20:26:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462rPB4zHbzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2019 20:25:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 462rPB1kgNz9s00;
 Tue,  6 Aug 2019 20:25:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Falcon <tlfalcon@linux.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ibmveth: Allow users to update reported speed
 and duplex
In-Reply-To: <1565033086-21778-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1565033086-21778-1-git-send-email-tlfalcon@linux.ibm.com>
Date: Tue, 06 Aug 2019 20:25:15 +1000
Message-ID: <87zhkmvbec.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Thomas Falcon <tlfalcon@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thomas Falcon <tlfalcon@linux.ibm.com> writes:
> Reported ethtool link settings for the ibmveth driver are currently
> hardcoded and no longer reflect the actual capabilities of supported
> hardware. There is no interface designed for retrieving this information
> from device firmware nor is there any way to update current settings
> to reflect observed or expected link speeds.
>
> To avoid confusion, initially define speed and duplex as unknown and

Doesn't that risk break existing setups?

> allow the user to alter these settings to match the expected
> capabilities of underlying hardware if needed. This update would allow
> the use of configurations that rely on certain link speed settings,
> such as LACP. This patch is based on the implementation in virtio_net.

Wouldn't it be safer to keep the current values as the default, and then
also allow them to be overridden by a motivated user.

cheers
