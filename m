Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 12:34:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2905F64F96
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 12:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2905F64F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dqc4l36mjz3ckj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 23:33:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e6KMTuoG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=acme@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=e6KMTuoG; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dqc4J2KJJz30JS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 23:33:36 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA92564F3B;
 Tue,  2 Mar 2021 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614688414;
 bh=otT9ilRgJ+9mGh21GcAZ6n5UE98pPEtu7abLZ/Fzx5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e6KMTuoGqEq1rlzZ5nNj89M34p4Xq4ho0U/p+h6davxggxE90ucneTi7zjhkfF2w+
 EFHKorkPKonms8nXzVq5EiwJUhx4TcKPjfA8bkXf689rSRdt05cwg5dV+Wr46rS1mB
 7sLvZmnux35JgIAdibTe8OyiJKZ54fcDKbXeDScvW1RMKZnsVF1pTXXAPXWYlgk4CH
 CIQ8bdMMmWAYXAH9s8Z5bgJ7D9xzBURVqX3x0JKrfdNgP+TL2BkGn6OwFZkEKzLSSC
 VjZ0Ak7nJFVUeKXHnhdYTzNFwL+84JYdVzwIMJ5R1YNnI17wgKcWj7Ebo07tBQffeZ
 sCIlisr+Jz8jg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id A97ED40CD9; Tue,  2 Mar 2021 09:33:31 -0300 (-03)
Date: Tue, 2 Mar 2021 09:33:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf bench numa: Fix the condition checks for max number
 of numa nodes
Message-ID: <YD4wm2I48rXUM/1D@kernel.org>
References: <1614271802-1503-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <20210226085827.GF2028034@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226085827.GF2028034@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
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
Cc: ravi.bangoria@linux.ibm.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, jolsa@kernel.org,
 kjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, Feb 26, 2021 at 02:28:27PM +0530, Srikar Dronamraju escreveu:
> * Athira Rajeev <atrajeev@linux.vnet.ibm.com> [2021-02-25 11:50:02]:
> 
> > In systems having higher node numbers available like node
> > 255, perf numa bench will fail with SIGABORT.
> > 
> > <<>>
> > perf: bench/numa.c:1416: init: Assertion `!(g->p.nr_nodes > 64 || g->p.nr_nodes < 0)' failed.
> > Aborted (core dumped)
> > <<>>
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo

