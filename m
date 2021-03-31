Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C512FC433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:15:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586D1619CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586D1619CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97f16DLdz3fR9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:15:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XV6nSyz3bv3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:18 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XV2DJJz9sWk; Wed, 31 Mar 2021 12:10:18 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, Davidlohr Bueso <dave@stgolabs.net>
In-Reply-To: <20210309015950.27688-1-dave@stgolabs.net>
References: <20210309015950.27688-1-dave@stgolabs.net>
Subject: Re: [PATCH 0/3] powerpc/qspinlock: Some tuning updates
Message-Id: <161715296824.226945.611747739649915060.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:28 +1100
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
Cc: peterz@infradead.org, will@kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, longman@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 8 Mar 2021 17:59:47 -0800, Davidlohr Bueso wrote:
> A few updates while going through the powerpc port of the qspinlock.
> 
> Patches 1 and 2 are straightforward, while patch 3 can be considered
> more of an rfc as I've only tested on a single machine, and there
> could be an alternative way if it doesn't end up being nearly a
> universal performance win.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/spinlock: Define smp_mb__after_spinlock only once
      https://git.kernel.org/powerpc/c/2bf3604c415c9d75311141b8eb6ac8780ef74420
[2/3] powerpc/spinlock: Unserialize spin_is_locked
      https://git.kernel.org/powerpc/c/66f60522138c2e0d8a3518edd4979df11a2d7525
[3/3] powerpc/qspinlock: Use generic smp_cond_load_relaxed
      https://git.kernel.org/powerpc/c/deb9b13eb2571fbde164ae012c77985fd14f2f02

cheers
