Return-Path: <SRS0=DuU+=4I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4CCC761A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 07:31:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24AE2465D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 07:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wicZbk6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24AE2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NR9m2XzdzDq9d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 18:31:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=wicZbk6I; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NR793MfszDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 18:29:39 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DC0024654;
 Thu, 20 Feb 2020 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582183776;
 bh=TxnVf9P5GTfdh8uEk/jtWBk7wfQqSZEQk6MNCsGrQfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wicZbk6IzHOoAhg+vtJOYEGxPaTpNGCFRUn9hqrP9CXWODywFtF4jC6fbHoF1dhIi
 Ae8VqYDJHF4u0TEZmyQ/zh941MLVXY8E0nan29sMymtJ4U8ztnJ6JwPJCFxTuAEPCJ
 qlkXyWcSlLOJq7CX1JOXX08o7QnFY8mI1UxS89qQ=
Date: Thu, 20 Feb 2020 08:29:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Santosh Sivaraj <santosh@fossix.org>
Subject: Re: [PATCH 0/6] Memory corruption may occur due to incorrent tlb flush
Message-ID: <20200220072934.GA3253157@kroah.com>
References: <20200220053457.930231-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220053457.930231-1-santosh@fossix.org>
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
Cc: peterz@infradead.org, aneesh.kumar@linux.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, akshay.adiga@linux.ibm.com,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 20, 2020 at 11:04:51AM +0530, Santosh Sivaraj wrote:
> The TLB flush optimisation (a46cc7a90f: powerpc/mm/radix: Improve TLB/PWC
> flushes) may result in random memory corruption. Any concurrent page-table walk
> could end up with a Use-after-Free. Even on UP this might give issues, since
> mmu_gather is preemptible these days. An interrupt or preempted task accessing
> user pages might stumble into the free page if the hardware caches page
> directories.
> 
> The series is a backport of the fix sent by Peter [1].
> 
> The first three patches are dependencies for the last patch (avoid potential
> double flush). If the performance impact due to double flush is considered
> trivial then the first three patches and last patch may be dropped.
> 
> [1] https://patchwork.kernel.org/cover/11284843/

Can you resend these with the git commit ids of the upstream patches in
them, and say what stable tree(s) you wish to have them applied to?

thanks,

greg k-h
