Return-Path: <linuxppc-dev+bounces-28354-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2006EC98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:55:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htKXq27B5z2y2M;
	Mon, 28 Sep 2026 08:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790549739;
	cv=none; b=hV3hyxjy8ketbSLMLdKxOp5dtTVkvoXZcXtYQgqrS5I0Suc6cGuDkksnSFLQyQ7K1mNkO0krGH05+Q5pJQ6yKnyvpDh/H0DyxVkxKr3g3EPr57UyrrGOV0sDJfZFjWw+NhdZBG3m4xp4+PQIlnFQUyGgElcavWhT+L2utzKiJ0wZZypgFfwKRSWSH7AQQtwC85r02BrU0Kz8UuLF19HMEHZHimBs5OeqqLe5ETMVRK9PxYoGvJc/+AUBb1XJ3g2a03vvINWMbWV7kyayha+wdtQFBsRGoF4xdHuduiT6Mr8hNCrFRs6Z7pqeG2Nys6McmXGCjnGIl8MsE9u2ZgIDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790549739; c=relaxed/relaxed;
	bh=fonZKBEVnLUi3nmIxkkXaoCZILdYms0d8ZYuqeeaJBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcFKnyzEHEL+SPn10a7f5fmwFKZCyp11zdJ7V4MOgzwGbjFxTqQXBPGpggOF6DTRCuLvDAqrG0wwXCL2S+GquLsNrPrhbXHm80xJoQ9HO+xJSjO4KvG7MIHnwyYy0BgAJ5Zo11r0uSJMJUP711C9oLzCARf5C5g43aTWMEkUBMORAFzHoOgLj5+EXOU0Rdmgyj2pZ82D/oUuocosj4dlHxVdkmUqTO1u1yeRNFd4qr9AC3TdAdxh9yYj5w4xW5W3i9Lews7cTrmjv+CwlRWoF9wnWhfCAjKGhiRjcisf7uJgZVU+R7o/028FqiEWcey2P3HZW27Wp+P5s1BjY4WArA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eIGI0kb8; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eIGI0kb8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htKXj72tbz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 08:55:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fonZKBEVnLUi3nmIxkkXaoCZILdYms0d8ZYuqeeaJBg=; b=eIGI0kb8JoQ6f59QATnKY4VWTy
	KlWA18PX6hX10BKhOmxNq0tGi3u1aRfvl4+RCRxnypG+Q3zub+tAGfPLahvJ7UxrqebG6Hw87AV+5
	pjJ5wII77N8SG6ISTZur4tDlzHyQJG/AruwRnBvYUL5h5vM1R4LIVih5MQuljHXPOD6svEMX0vt5w
	fN1uh3q8xkndWOy2mJeEInuuRC2htXs6SWKt9eP27BmPHjB6Elzy1vZxpqCT0Gl7etIkQcBpxUbK4
	n8v611VA11zwhLqKPmNANUdBBOafXd7NBkYlngO75KzUN/H3oVubmt74amemlxLWMaFpHJpsXr2/5
	Lk6vs5tg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAxlt-000000025TY-0cPK;
	Sun, 27 Sep 2026 22:55:01 +0000
Date: Sun, 27 Sep 2026 23:55:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Hongru Zhang <zhanghongru06@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	surenb@google.com, david@kernel.org, liam@infradead.org,
	mhocko@suse.com, rppt@kernel.org, shakeel.butt@linux.dev,
	vbabka@kernel.org, zhaonanzhe@xiaomi.com, linux@armlinux.org.uk,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org,
	kernel@xen0n.name, loongarch@lists.linux.dev, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <armexcXDiG8ryZd6@casper.infradead.org>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arI_w2wTfA00Mgy9@gremlin>

On Tue, Sep 22, 2026 at 09:55:23AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Sep 21, 2026 at 07:57:23PM +0100, Matthew Wilcox wrote:
> > more to say on this in two weeks at Plumbers.
> 
> I look forward to it :)

So while doing my slides, I realised that what we need to avoid doing
is (a) sleeping while holding the mmap_lock (b) returning RETRY while
holding the VMA lock

And that turns out to be as simple as this patch:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..94ed2333f8d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -723,6 +723,8 @@ enum {
  */
 static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 {
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return false;
 	return (flags & FAULT_FLAG_ALLOW_RETRY) &&
 	    (!(flags & FAULT_FLAG_TRIED));
 }

OK, this is a hack.  The function is spectacularly badly named, and
needs to be renamed before a patch can go upstream.  But this should
fix the contention on mmap_lock.

Could somebody try it?  I've verified it boots and runs some userspace
fine, but I don't have the workload to test the contention.

