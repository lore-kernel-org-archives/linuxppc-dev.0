Return-Path: <linuxppc-dev+bounces-26609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB1AC624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 14:43:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcbfs5xrRz2yv4;
	Sun, 06 Sep 2026 00:43:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788619397;
	cv=none; b=RjhumQIRbp8A1AKiBJYZgUP5Q7X4Hoaxr9fj9WMB1xFSMABPiNuKD6c92+TBmq1S4fCe5z3cJJDzdSL8fYSF5SKFYqz1avQYrGYv51teEgmm4S7ygk/eJA40+L72szZWVvnDvQziECXfhn2ktnfljjMM5BUvaEJmhPy+MFWpkd2il4ZEpgV1yNmrVrBnrtwpKdN+30loWrU3zns6x6AwrP0i5JK0CwYfkY+j5Kok/ibDVFV5Rb2YjKJJWZERloitPJFdHZAEcKgRztcG+mLUmRGPznzbWYac9osfeiNu9z2BJGzIlPnE5YkxFQkJamaWvbmcdbjKobxcA5AdhCiHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788619397; c=relaxed/relaxed;
	bh=3TKgZWmSyq+LVPqTnYeoNtWDY3OWJNbaMqAKzTQfKjY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=HMfe5x2OzKl31AGnKIuL3f/l0OiGQB8hLWQzaY7QjOyVkv+O+5b3X9p+SnHuV4dUnDrBhDxHNwosCgzzNZuIhyJhhgJtPoIul+Q4irBLMoEUCpMw/0fKKFQgNBloQiGnqJpHO9XAycflKfh3GI+Aa+CksOC8cMR+Gelo93QtXiS+gNKIC+E8kJH9y8KSWt3BE+n09/4INdTAm/Hi0scXjRzqPQhFdDFH12AcnGvja1UnQzseVpcutjXuT+UjAOfdj1GfKn00csRqbbvX/sKxbNbiSqGAEdjTr0bfBzI1e3ZX/mJ+pxkSHxUygmuCVJlWiI3mpCY6k1bkT1DfNcg1oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=JtCi5iAf; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=JtCi5iAf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcbfp50D8z2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 00:43:13 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 6A91C77901E0;
	Sat,  5 Sep 2026 09:43:10 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3u952ABiGGPE; Sat,  5 Sep 2026 09:43:09 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id B8CFD7791DB7;
	Sat,  5 Sep 2026 09:43:09 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com B8CFD7791DB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1788619389; bh=3TKgZWmSyq+LVPqTnYeoNtWDY3OWJNbaMqAKzTQfKjY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=JtCi5iAfpMLLFzIkKXQ7bghm4XDfZHrtdjV/dGdhvImM3gVYmCEf+xzzE1xHmORdA
	 +xCWgbHktgQO6cEt3izf9PLS/uoHiXIk+YbNz+vuOedc4evxvgXiRA9ahsxRJv7zMK
	 YXEDvdBJgkhoeBq+GHlstsuyBGOAd3yL/xuwyl/s=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n_fL1yezoAzm; Sat,  5 Sep 2026 09:43:09 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 88C2B7791BFE;
	Sat,  5 Sep 2026 09:43:09 -0500 (CDT)
Date: Sat, 5 Sep 2026 09:43:05 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <610543697.64938.1788619385880.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [REGRESSION] RAID10 severe performance regression / unable to
 rebuild degraded array
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC151 (Linux)/8.5.0_GA_3042)
Thread-Index: Q80XwQseHkKx/eG16VNObK1EnfPjZg==
Thread-Topic: RAID10 severe performance regression / unable to rebuild degraded array

After upgrading a POWER9 pSeries guest on a PowerNV host from Linux 6.1.0-18 to 6.12.94, rebuilding a degraded RAID10 array behind an LSI SAS3008 controller passed through via VFIO proceeds at ~1MB/s with 100% CPU load on one core.  Booting the same guest with the old 6.1 series kernel and resuming the rebuild of the same array proceeds at over 200MB/s with minimal CPU load.  For completeness, the default 6.12 readahead settings were adjusted back down to the same values as the 6.1 kernel, with no improvement observed.

No variation in the regression was found between host kernel 6.12 and host kernel 6.18.  Since there are no other reports of similar issues from amd64 users, it is presumed this is a POWER-specific regression.

