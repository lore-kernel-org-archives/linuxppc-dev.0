Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51270C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:10:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DE6214C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ji/d2ve0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DE6214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Jg2130B8zDqht
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 12:10:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ji/d2ve0";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Jfs15qm5zDqfG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ji/d2ve0"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43Jfs126Qqz9s3q; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1545094981; bh=WFhNEQZn+3Ncz0Ff3/ocVQR2BNu4TG3+RUTfT7XVykc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ji/d2ve0ALOiFhZLERKh+KQydPmWqoO8CU/4rz/dsV78ncPwVWN4EZ4dnpSobluKl
 04bR+3n0X5d3BA5ma/KJJ3bGHdSq4CGuVLBQjcdt3QZ8Pe637bYldzSxBLHrjj/2vv
 sP7tDixq/6nnzS6fik5undd2UX/yBm1V6LMVXI7dBAl8hnM+Dabi9QJ6atXmjLHV1K
 6jlHqDjbjsmBs10LEGYZBIy4TzLLsbiIo/raWI23+MAEwFqk+cX4JzZB9dh0pbXaru
 9nFKL9bykB74jPr4lcO6o+CiuarV9+lDbuH4/jPv8GJV9jkzjjz7IAp0PClo1zYMW/
 DrWLhlfU0+Ysw==
Date: Tue, 18 Dec 2018 12:00:55 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Set hflag to indicate that POWER9
 supports 1T segments
Message-ID: <20181218010055.GC25748@blackberry>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
 <20181207034326.3564-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207034326.3564-2-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 07, 2018 at 02:43:18PM +1100, Suraj Jitindar Singh wrote:
> When booting a kvm-pr guest on a POWER9 machine the following message is
> observed:
> "qemu-system-ppc64: KVM does not support 1TiB segments which guest expects"
> 
> This is because the guest is expecting to be able to use 1T segments
> however we don't indicate support for it. This is because we don't set
> the BOOK3S_HFLAG_MULTI_PGSIZE flag in the hflags in kvmppc_set_pvr_pr()
> on POWER9.
> 
> POWER9 does indeed have support for 1T segments, so add a case for
> POWER9 to the switch statement to ensure it is set.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
