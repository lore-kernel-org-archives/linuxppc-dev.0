Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FBC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:32:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA8E6115B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA8E6115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcsh6KTGz3dff
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:32:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcp83ZCtz3bwX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:36 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcp53z4Gz9sWw; Sun, 11 Apr 2021 00:29:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Axtens <dja@axtens.net>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <c95a648fdf75992c9d88f3c73cc23e7537fcf2ad.1615555354.git.christophe.leroy@csgroup.eu>
References: <0ad4629c2d222019e82fcdfccc70d372beb4adf9.1615398265.git.christophe.leroy@csgroup.eu>
 <c95a648fdf75992c9d88f3c73cc23e7537fcf2ad.1615555354.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 03/15] powerpc/align: Convert emulate_spe() to
 user_access_begin
Message-Id: <161806492680.1467223.16788785953274402372.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:46 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 12 Mar 2021 13:25:11 +0000 (UTC), Christophe Leroy wrote:
> This patch converts emulate_spe() to using user_access_begin
> logic.
> 
> Since commit 662bbcb2747c ("mm, sched: Allow uaccess in atomic with
> pagefault_disable()"), might_fault() doesn't fire when called from
> sections where pagefaults are disabled, which must be the case
> when using _inatomic variants of __get_user and __put_user. So
> the might_fault() in user_access_begin() is not a problem.
> 
> [...]

Applied to powerpc/next.

[03/15] powerpc/align: Convert emulate_spe() to user_access_begin
        https://git.kernel.org/powerpc/c/3fa3db32956d74c0784171ae0334685502bb169a

cheers
