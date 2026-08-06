Return-Path: <linuxppc-dev+bounces-25481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D36C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG6vR1MD7z3054;
	Thu, 06 Aug 2026 23:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786021507;
	cv=none; b=RQLSiHvNlYOBuv9+WHSj9TqZlIsrzub8y84H11bJOwLiwyYsQGHXCaICueL93/XVmjRBJhKfxPvgTnZ1iBefGjgV7rFvYKK0HRXbNiLSuc3J5Ve9c48/NxoxViLzozWp+U9k/rQODGOVy8PisyiqnKjIFCxHtHEFIRCWUluL7v9rYrtEhUcpwBOyfVBd51UymRwe6siYFLPI64IFH8qG5PIaU05vzeVN5XlFOXOnyU21Y8nclVLxdPhzzpiJv71TfyEWHZBhseld2VJnenheuIC1I0s5CsCzjIlZr9uERsxIJevz6i3OSKLBJyE4wHlB8dDxVWpk/K34s+HArxUEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786021507; c=relaxed/relaxed;
	bh=TNgEP9rAik9ImbMTe7ic15AbkV4UyMyyvFv68qQxDA0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ok4BFZdkb9W4/fcFl9elBIenuf85cnjxDCO57ILWSrmeI7ZNunV1dxxixnX5ANxoCnw5ADhcK1uSEaYGDb/cIByolRfDsERTr2El8TXbV+HSNS6Jf9FuDg8Mz2Qb2RLXfU6L2S+W5muNsjhvqUSVXRyA41FhcIJJVoEQjLp4LaCalWgbKHT1We+juCp6qjNWZfZ3OXLYqgsjmUAzkF+F518Fc4sjyGbk1nZTIHEQ+jyXLZhesVy9RvBILI6R/vyQNhH8iQzU6yN+MjDRznp7Qudb1kDocyJkew8sPD2icZACF9FFwz86PWRvRc32g1QU2xxTl/3mNHIjfgMcdq3rdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FiVwt3Ak; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FiVwt3Ak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG6vP5n4Nz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 23:05:04 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1929390a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786021501; x=1786626301; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TNgEP9rAik9ImbMTe7ic15AbkV4UyMyyvFv68qQxDA0=;
        b=FiVwt3AkRN7x2qFARIIMLRcnLgn34Hfpldqi6zCQkoAA1v3+JkcLiVO9u7+GZ6eJLO
         S56Jw6QNDn4dnzaZ14izTvdkbVKQlxOzZsX0yx3wUL47LbJGE/QMNFcI1D4kdlO7M5ih
         am3jN1VFYVqTB9Czsci1D2KNlfzTCYEj6q1a02xbZBG1mMYQgJ39otTOT44d2ba4efKS
         DW2Fd2dhB+0A9xIZRyJ6qXRrhoGyK8aUHInbWhBqsZEudsgDiLUBGK2sgcqFl/EG5CsM
         wVr8pXQNtm0bDHN0aN6A04tP4TYEsCQdfOa8esaE5NfIIQWGzYz62zRCWzcq5WDnUpS6
         2dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021501; x=1786626301;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNgEP9rAik9ImbMTe7ic15AbkV4UyMyyvFv68qQxDA0=;
        b=QqYU/vLQwe/lkjkwpu+ekJC8LBRfKjH1RTvFbt1KOOjqvvvWmTaE6u6bH0nMST4mc9
         iwQQSzzTXgNcaKGznJQfzt+ttE+MNSGlZyfY9O4JDMO2m9rOSiRh0rTnxBQyNpCqmNgE
         0v4de5zXc+fstLSD8NAagOqOdolIifscK344yRCKJT7Jc+Fn4+vNR296zAqZrWkjasCx
         RTqAXkVhqbyb4TKwuBHSsGjjcriLkJO11SFN5LxTDjHT6F2wl2Edmgz6ylowMVEuJE5P
         jXQ4ogZrJC98zan/1me3Hsm9PmWMz6AY4eSoqfWQ3fRho9upsyV/fu6SNigPj+N/zgBa
         BCvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqN3h7Iaj2o42eZxNb6QqLxA+P2Za4hC32dB24ihUtLKiOILZjuHwiUWX9a231nRL6xGCqifnmgfxY6ZbU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6F06rJu2ru31NjCZ3yF62NbSqPiKKX6AaAv8d//QthiEoo1XZ
	r8gjf7UFuuMA4PYIKOZAdrxGPyLw4NtuYwUoZ9cdEYxZSDbGgbegxLO4
X-Gm-Gg: AR+sD12UFv6wSdaKRv41TnbhcBX4zcLrjIkPCtZ76SqHe1nh1a1fqWdnPNYmzOYzTk2
	170h1uyY433RtAb1irKmk//Zh7xh5N/NTzlLqqwFT2OHmEGnbsumyn5BzTILpKyv9gCbL6pORx1
	xdMcbI7szJWCbc0u93YFrzGReWW87YX6j/O5e+Asr3pzFeXIGbw8d5RvqC7GpXho9TG92DUBWkO
	BjdcJtiGWXj1mJl3Uy3szIdgcitjleoY0P6F4IMiEXDQbdXimxkJcM7x7+g7dBeMqcPF580gRkd
	tbkAMmdR5APlXlKaU9Ub8eXH3VYsRiF0UDe16Ghl+ViJwU9kFqrGh++OE9VGANKQTLdIApolGCh
	g91QFG06HgBx0UgOnJ+SXxkF9c7WApdlbTlJ8bQ7t3FrSR0jqkbkyGDw/gVyu0aclInk7/WZz7b
	HW0JG2/+09wIO/t5lIknxrY82mQ+3Jy3S+QBlicf8oqSKx/dS6GONiFtKdkCiD
X-Received: by 2002:a17:90b:270e:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3903bb0cf61mr15989348a91.0.1786021501328;
        Thu, 06 Aug 2026 06:05:01 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586401627sm33818575eec.10.2026.08.06.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:05:00 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Timothy Pearson <tpearson@raptorengineering.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Gaurav Batra <gbatra@linux.ibm.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
In-Reply-To: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com>
Date: Thu, 06 Aug 2026 10:57:22 +0530
Message-ID: <o6fflsxx.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com>
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


Hi Timothy,

Timothy Pearson <tpearson@raptorengineering.com> writes:

> On Linux 6.18, and potentially earlier Linux versions, attempting to pass through any PCI device via VFIO that requires 32-bit DMA results in the following error in the guest VM:

Can you confirm if you see the same issue on upstream kernel also or is
it only till v6.18 kernel?

>
> [   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device mask
> [   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset: 0x800000000000000
>
> The same devices work correctly on the host kernel.  It appears that somehow 32-bit DMA is not available within a pSeries guest on a PowerNV host.

By any chance did you do kexec in the guest kernel? Is this issue only
hitting with kexec or even with normal boot up of guest kernel is also
showing up the same issue?

Could you please share the dmesg logs for both guest and host kernel?
That might give some more data about this issue.

-ritesh


