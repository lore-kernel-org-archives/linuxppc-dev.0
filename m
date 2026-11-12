Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6760A2602
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2HWyp/t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQR383LKBz30g6;
	Fri, 13 Nov 2026 03:40:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501652;
	cv=none; b=QNZ6LuGRSqdYfuA3BrKYTv6sqe6xXDfbG265eMn9t10+hZkYUVaGGBbCG9tvb0lWZezHzdDG7zRufgc1AgjPOBYRLFtgTzO+pUAimQu54mp/xDzlwTiu/1DwwLCow7kC7jbW4vUE6NWV+JPbdPSJptFjHRDHyLT1qa/0yH2Jy/jj5T6t2b/OjlYwEVoDq3tm70S4E3y47cfMVIzha9gzRuYDeWIv2cur8yjqdTNG+P84FVWJumx397FH92n4FNv4xKPqkDu8/8DTx/+vSjZmTVihur8CU3HGk3V7mEyacERtcyBaBX+DcBg7s+a3L/pj7+SDdIGFdBwoCbcxy9cIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501652; c=relaxed/relaxed;
	bh=h4XhdGstHHaoDKhn87VxtYdFBjOR/ijZJS15gJryUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+4WNJOoI6K4H/g/5OKN/q26QkzlU6OwSaX8+Z4XOpelZATlG1b2Ss/CnfLm+RyC02QDWs5FPfecewR+Vs7h3UUKiY4cRWRAlvtPAeJdmnai05WjkN6TyZkzn/bYPLcNWU3vre2Ec61UjurxvAttlSqwjqLkOp6VBoSPQKBmBvBBIaZgNv7haZ1J81gjrH02pZurGo3//lbalmfwn0FMp2OdBWtwQt/n8SQrSdjlT5KaZn1jWe+qfpMiDJiJZyETCkOHh7jhgzSoseehXiKVqhhhl6TUGy1ycYvJXsGPRngCIxWSHIfxKSsMRAZiOLiX7VZqtmJzZw7yLJB8Dgk1HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2HWyp/t; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2HWyp/t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQR374cYNz30dn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:40:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0DC4438F2;
	Thu, 12 Nov 2026 16:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B31F000C4;
	Thu, 12 Nov 2026 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501649;
	bh=h4XhdGstHHaoDKhn87VxtYdFBjOR/ijZJS15gJryUyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z2HWyp/tJDDjjTHcJR3EqrO+Co3DWeMLJ1+cp2ynX2OINbp8WyivGS6bUYCElRnHv
	 j82yu2W0I6XbhRl6k1jGMrybLRN3rtsxa9jpBTx+ED6Lo2I2lVItYT5jq4zrZSGZzs
	 JXUgU8bmDotIuPcRgcQnRfdkmCpC0cle2atzG2wdTeGxjiblOhweVWrNK8sHl3qORz
	 AptP+WXgJYapp1q4qpa21NtXJZGJFCXXQTz9CI+U/mh2RSFbpUGKjXJrisLA5A/IyL
	 WRrvvgmWPTatgjPr4LX8gIKpHS1COMkia2Rnrxs+diTDADTj0jXe4+8KHHufORL2wP
	 EtFhzktL6OIhg==
Date: Thu, 12 Nov 2026 17:40:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] crash_dump: recover from machine checks in
 copy_oldmem_page()
Message-ID: <20261112-singt-gewettert-rohkost-74009dcf3366@brauner>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 05:37:06PM +0100, Christian Brauner wrote:
> A capture kernel reads the memory of the crashed kernel. That memory
> may have uncorrectable errors in it. Which is likely also what murdered
> the first kernel.
> 
> On x86 a machine check in the copy that /proc/vmcore does out of an old
> page panics the capture kernel. On book3s64 the read() comes up short
> and splice() panics. Breno has observed that on a fleet iiuc. The first
> kernel dies of a machine check and then there's no vmcore either.
> 
> I had the powerpc half of this as a fix in part 1 of the procfs series
> because Chris ran into it there. Breno pointed out that x86 has the same
> hole.
> 
> I think that likely makes this a kdump problem and not a procfs problem.
> So I moved this out together with the ioremap_cache() fix.

So I'm not super familiar with the machine check stuff. I know that
@Linus has some familiarity with this. So I guess a yay or nay would be
nice. Not sure if really a localized fix for the architectures that have
mc support makes more sense. A common helper seems less fragile to me.

