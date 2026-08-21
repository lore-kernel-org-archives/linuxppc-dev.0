Return-Path: <linuxppc-dev+bounces-26042-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC56C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 16:38:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRQwS51Xzz2xtt;
	Sat, 22 Aug 2026 02:38:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787330296;
	cv=none; b=Ig9c/BS17MZM+ppxcbhw9IbSXbgrjgQ9qKi3/9n5zZABVo3bknk2sU3SL9tXg3XIJxkWeKbBWqL7JbLq9DRKPPmc4ZUOsow68IbhtpKH6DPac8/RvotU0ehRiaIEn+BUFTTUi7AnlSw7jhPVRYPIYK86tSiNsNSmerkZn3i3uSivpfYXxBEHYc0gvbt6UxkUcpvxCGhWKZ4aBKHtBOub96GvzyINb/oKjMBGs8n6oUlcF3PDfVc285gMup2diKiyLmVFtNjB08urh8BM083ExD+i5e048Xh1ksOdU/On4cXLqrWutvl1U11C0s+XSgLgnrrcolpqBNWDzF74on58Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787330296; c=relaxed/relaxed;
	bh=FHnKKYH/fuDSfJGccALTQFXsAt7bAuyBufIUgENzY38=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=ZEoQFSPyluGgHk9aSxIbP+YG0gPgoZUOBnSWEnisU21PwOAo3gJKb9JkAdTnwgB0NV3jcmAnRSoxH0MXtr0H1ixNEbnoJE6HoeBcw2iqnAO/GBQ8XL4nG3pPK6ow5ACJbMktS+HlAclDD0g51aqxkQBSZV3B3NMU8zuKHXMl/2or0WZubPw7Bd4uvvFgavTrAP4Negs8DnG09XTdq9ketASeyGG7vnbKjf615ErizB0vvoDAlv6+QNeyjvPGBzTGF6RE4oKKQuPbaVQ/tb5EPF98lx8R7BsJ2VT2wOPuI60XWCN9FSaKfEra/I8m+MnlgGKzyIMVa3RjUhyKQgwPiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=fIfjc6xs; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=fIfjc6xs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRQwP1XPMz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 02:38:12 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id ED69977909F9;
	Fri, 21 Aug 2026 11:38:04 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LLat0Xb3b1HO; Fri, 21 Aug 2026 11:38:04 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2EDBD7790A27;
	Fri, 21 Aug 2026 11:38:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 2EDBD7790A27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1787330284; bh=FHnKKYH/fuDSfJGccALTQFXsAt7bAuyBufIUgENzY38=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=fIfjc6xsVNxjPprgwmVJYFJ4Y/buTUZ42sNZ2s7PmgaESAYt8MB4BRyMuceNOAfRP
	 TY9A+1asHQrbrB2f0A5QYN7T9UpLyaet7WKc5ZmL14fFAVZYpy2wvaOj8rADREgPFT
	 nE4giucu1YQtw/DyLP6m1nVoI0vSAfmh8zyUhvzM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j7bNhUy56BIp; Fri, 21 Aug 2026 11:38:04 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 0C2E877901A9;
	Fri, 21 Aug 2026 11:38:04 -0500 (CDT)
Date: Fri, 21 Aug 2026 11:38:00 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <1435664226.21087.1787157496274.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] Interrupt timing warnings in pSeries guest on PowerNV host
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
X-Mailer: Zimbra 8.5.0_GA_3042
Thread-Index: UxEos84SR/aewvbvU2c155T42Ng3gQ==
Thread-Topic: Interrupt timing warnings in pSeries guest on PowerNV host

On a POWER9/PowerNV host, when running a pSeries guest using QEMU, sporadic interrupt timing warnings are observed.  This is on kernel 6.12 (Debian Stable) on both host and guest, system load is moderate, the host CPUs are not pegged at 100% at any time.  The guest has only one virtual CPU core assigned.

[11622.031047] hrtimer: interrupt took 12354614 ns
[46723.139964] hrtimer: interrupt took 8522695 ns

This *may* be related to the dropped / late interrupts I have reported in earlier messages, but it could also be a separate issue.  QEMU version is 7.2.22.

