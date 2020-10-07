Return-Path: <SRS0=XBts=DO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA0C4363C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11516208C3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11516208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5fxz0nnwzDqN6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 14:31:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5fkM1nCQzDqFC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2020 14:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4C5fkM0DmSz9sV0; Wed,  7 Oct 2020 14:21:14 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Gustavo Romero <gromero@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200919150025.9609-1-gromero@linux.ibm.com>
References: <20200919150025.9609-1-gromero@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/tm: Save and restore AMR on treclaim and
 trechkpt
Message-Id: <160204083267.257875.3237205733513981909.b4-ty@ellerman.id.au>
Date: Wed,  7 Oct 2020 14:21:14 +1100 (AEDT)
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
Cc: aneesh.kumar@linux.ibm.com, mikey@neuling.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 19 Sep 2020 12:00:25 -0300, Gustavo Romero wrote:
> Althought AMR is stashed in the checkpoint area, currently we don't save
> it to the per thread checkpoint struct after a treclaim and so we don't
> restore it either from that struct when we trechkpt. As a consequence when
> the transaction is later rolled back the kernel space AMR value when the
> trechkpt was done appears in userspace.
> 
> That commit saves and restores AMR accordingly on treclaim and trechkpt.
> Since AMR value is also used in kernel space in other functions, it also
> takes care of stashing kernel live AMR into the stack before treclaim and
> before trechkpt, restoring it later, just before returning from tm_reclaim
> and __tm_recheckpoint.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/tm: Save and restore AMR on treclaim and trechkpt
      https://git.kernel.org/powerpc/c/d0ffdee8ff01fb21085d835ee54dc8c1c4d19226

cheers
