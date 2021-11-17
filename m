Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6824AC433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 11:26:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6F61BA1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 11:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08E6F61BA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvLGh52yNz3bjD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 22:26:20 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvLFs4H7pz2xSH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2021 22:25:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HvLFr4hkdz4xdS;
 Wed, 17 Nov 2021 22:25:36 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <a21e9a057fe2d247a535aff0d157a54eefee017a.1636963688.git.christophe.leroy@csgroup.eu>
References: <a21e9a057fe2d247a535aff0d157a54eefee017a.1636963688.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Fix pinned TLBs with CONFIG_STRICT_KERNEL_RWX
Message-Id: <163714821663.1508509.919431268872483842.b4-ty@ellerman.id.au>
Date: Wed, 17 Nov 2021 22:23:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Nov 2021 09:08:36 +0100, Christophe Leroy wrote:
> As spotted and explained in commit c12ab8dbc492 ("powerpc/8xx: Fix
> Oops with STRICT_KERNEL_RWX without DEBUG_RODATA_TEST"), the selection
> of STRICT_KERNEL_RWX without selecting DEBUG_RODATA_TEST has spotted
> the lack of the DIRTY bit in the pinned kernel data TLBs.
> 
> This problem should have been detected a lot earlier if things had
> been working as expected. But due to an incredible level of chance or
> mishap, this went undetected because of a set of bugs: In fact the
> DTLBs were not pinned, because instead of setting the reserve bit
> in MD_CTR, it was set in MI_CTR that is the register for ITLBs.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/8xx: Fix pinned TLBs with CONFIG_STRICT_KERNEL_RWX
      https://git.kernel.org/powerpc/c/1e35eba4055149c578baf0318d2f2f89ea3c44a0

cheers
