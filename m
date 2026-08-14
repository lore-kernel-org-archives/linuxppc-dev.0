Return-Path: <linuxppc-dev+bounces-25875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF89C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 19:10:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMBdP6s9lz2ykT;
	Sat, 15 Aug 2026 05:10:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786734633;
	cv=none; b=QdUA9wc3uUIWR4vIYoIfWLTbZL0gBNOxjto1Ba5bk8qnalg3FYpCZRftgO1FO434n5ULVoLoD1jdATiCUfzSr0HQ0bQ8764sKw1SP8aujsJQ2++e4a7C28DaZZfJx3yx5DlpkxS80GRa8A5VbAHI+zl78Ln9OK8wlu+7Ju7Rx8OaoGr0srMJRM6LyJt/h8Q+m6qV1SD7r7tlSlwLvH9hsgCHTcFc/+BZpP4TluN5kv0LBM8QzI7W3SHtomJM7BHvCH78vnGK6n5Cs4gNAbMWGPLHSACV5CjfzI/shnPM7yori5v8ZGQ4A4Hs2uDZ3Fs0PzYecU++b5vu0OICokszhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786734633; c=relaxed/relaxed;
	bh=fXZLnuZpinvg33H+AC+2I9toD2Udw0SWe5NjJkQBHEQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Eg4DKYaW10EtQWo3jZyyULp+xuNX4E6wwnNdmbxDSdDnaq7tbx4DRRQ/MQa5uN9TZb8khbBFpCe5z9X/XKnDRa6XJ2Z5e65eSt2ci9m0IjHrEwi9j5fCmJdkaRcZiBnnJZKbQNcM7rpBHabiugosVE3HiG0O5+Fq0H8bI8mJW92z8IMZDmRYeOUo8VidZ5jGLjq+sClWU1mELJsIEq6PT0jKEYZauf7ExCYiaWUezF5HlgLytusSMJ4ofiCcWls2C1/786ZgSdGkD+cbDJkIn3sAK23OSwzBgZvSxS4uShYaiueWyPicr4UJJAKH7ZpKFnXPnIyGU2uVWfZ/Zmd8FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=f46SZrVx; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=f46SZrVx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMBdP1878z2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 05:10:32 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4D1637791D6A;
	Fri, 14 Aug 2026 14:10:30 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jZYo4p2k1bGN; Fri, 14 Aug 2026 14:10:29 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BB37D7791D90;
	Fri, 14 Aug 2026 14:10:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BB37D7791D90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786734629; bh=fXZLnuZpinvg33H+AC+2I9toD2Udw0SWe5NjJkQBHEQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=f46SZrVxVaqCNEmTND+ajVfcErjTiPKo1/+VnXiMrW7fcbkAJzXb7Xs7j6bjiK3UQ
	 qW+sOaTNJcQVXtUqnE8is8iZVpxE6xhcc+u/QL7rCw+mI9TXKWJy+/3k3qg73rfksk
	 /Btkyh0IA8ZUkDu4Zwvd0jHTrCO1ry1AXvWF1J9w=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o-Z7Z0VhL7A3; Fri, 14 Aug 2026 14:10:29 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 96A377791BDA;
	Fri, 14 Aug 2026 14:10:29 -0500 (CDT)
Date: Fri, 14 Aug 2026 14:10:25 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <503891424.12788.1786734625681.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [REGRESSION] High interrupt jitter on PowerNV VFIO INTx passthrough
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
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC150 (Linux)/8.5.0_GA_3042)
Thread-Index: 748hng2Z8qQC8/BeUSW2oB20recTBA==
Thread-Topic: High interrupt jitter on PowerNV VFIO INTx passthrough

On POWER9/PowerNV, when passing through an Atcom AXE400PL PCIe DAHDI card which uses INTx signalling with the wctdm driver [1], we are now seeing high interrupt jitter / lost interrupts after upgrading to kernel 6.12.  This jitter and interrupt loss makes the card unusable, and persists in both XIVE and XICS mode.  The card used to work correctly on kernel 6.1.x and earlier.

The easiest way to demonstrate the problem is to install a TigerJet-base DAHDI card that uses the wctdm driver, and run the dahdi_test utility.  If it shows anything less than 99.99%, interrupts are being lost or are arriving at improper times.  Example on the affected hardware:

dahdi_test
Opened pseudo dahdi interface, measuring accuracy...
99.122% 99.915% 98.833% 99.704% 99.423% 100.000% 99.418% 99.995%
97.654% 99.030% 99.707% 98.831% 99.671% 99.457% 99.612% 99.512%
97.371% 99.999% 99.808% 96.005% 99.909% 99.999% 99.811% 97.755%
99.030% 99.314% 97.953% 99.998% 99.908% 99.127% 98.244% 99.804%
<Ctrl+C>
--- Results after 32 passes ---
Best: 100.000% -- Worst: 96.005% -- Average: 99.184939%
Cumulative Accuracy (not per pass): 99.191

Unfortunately, given IBM's continued moves away from open firmware systems and OpenPOWER in general (see Power10/Power11 and binary firmware requirements), we are moving this workload onto open firmware amd64 systems.  As a result, I will not be able to provide further information or assist with debugging.  However, I expect this issue to affect other hardware, including common Ethernet controllers that don't support MSI; the DAHDI hardware just exposes very visible symptoms due to its real-time nature vs. other affected cards.

[1] https://github.com/asterisk/dahdi-linux/blob/master/drivers/dahdi/wctdm.c

