Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F8C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Mar 2022 10:37:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRq0M2tzqz3c3r
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Mar 2022 21:37:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=BN2Ccu9n;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRpzg6n2jz2yPv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2022 21:37:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=BN2Ccu9n; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRpzc0w98z4xLS;
 Mon, 28 Mar 2022 21:37:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1648463837;
 bh=j+k2BDfbdQx4zYpgl58V8K4qKN8q+JC6OELJvVduZdk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BN2Ccu9ny+Pu9NAS6ObsluDgsrxVhj9MCOS7BRzf1KuSQETEzKLrUgB7uPhYE5rYB
 ZQeod4N4q5q+hqeJOjp+U16rLaOSyPrA7W4eCZUnTgYZPmnscAY6XddB274kKpHED8
 0i/sLbGDzq6GFxaGDHKDLCV/PeG76NwNxkqR2U7899Q/uYditTkyUQsPSadeW/FEjT
 VSZ+wGt7nqjYKmbwayd/kSptFNiwgkI8TzmUm9YxcM7xcnQteSjZLpnLk5PkACCyWk
 satOHFvYM3ZjfdHJJYWAvsXL1C/5aSIlt5Lyzi3ZemU+uIAvUi8ILTWBwAFvGX4slj
 e5J0r/3bpn/TQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
In-Reply-To: <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
 <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
Date: Mon, 28 Mar 2022 21:37:15 +1100
Message-ID: <87sfr2fjms.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: songyuanzheng@huawei.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> Hi maintainers=EF=BC=8C
>
> I saw the patches has been reviewed[1], could they be merged?

Maybe I'm just misreading the change log, but it seems wrong that we
need to add extra checks. pfn_valid() shouldn't return true for vmalloc
addresses in the first place, shouldn't we fix that instead? Who knows
what else that might be broken because of that.

cheers
