Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC48C5519F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 15:46:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A792076E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uacpSvyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A792076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZYMR3YwpzDqHS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 02:46:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=shutemov.name
 (client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=uacpSvyg; dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZYK41dXLzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 02:44:05 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so24747565lfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
 b=uacpSvyg7sNcaRSGZ7Q3s8sTWe0zmTrFvRT2fZ38n++Dg/H+rJ57tNnHKW+Nn9wRY2
 xYrUSAFI9AREFZuosouqgZ9Od7ZUxEJ8dHq4guk/WYcKvzkvUDLFspZJrQhNaRVkDdLW
 1GWD1S9qA8aMOaqIZb349wy74E/CQDpFlvouD2b/tOIu5CK+5cloUZlhO6BW4sb3G/Xr
 BwhGxYp3w9yXabcKrrLw4EQC5eQhlR4F22zf6KrBG8tYkcerLZVgRRUnP7yqzFF0fdIa
 93XPaoPWr21DOOO3u3riLFklco7wH/gsEkrEsZwe8rltgtblHLC8qusqEu6duJ+CGIyS
 CUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oivIdgQaz5+Gp2NLctXgWUVrml124AnA4kh8cM9g7mM=;
 b=mKrSqTvzRhs6hsWHMZ4TXCzIPt25UaqdkDPYXl0HiLHAziexU4GnoPel4KpOrfYJ4r
 BE7l291ZmW9zQDjvupZc4t3IH27Eayq0jV8z1JlcMfskuxjdDD2akUDsnon9uC0Y6yVC
 imlg1v6Jg0slj3UjlWbW12ixsQQzkoLVcuxGzrM4+aJIlMnYXXBhQAstD0U3AH96sgQp
 MP/u/ZPhP8B8ICRT//CtTw1lpTVCCjLl3VhBu7DNrwSN6zHZCUQ0Sicnry5d9JV6Zk3u
 BzCYyEKUJG1D2w9DIVHKa3f8UKGz96oGgG7opyLKWfXx2ilH7jZoIBvifxdQvBhQV/o1
 S2lA==
X-Gm-Message-State: AOAM530viF+hReJsBDmD0ixaumpEUjMK4NPxs0d9Ch7jnRdK1aL9Wl4e
 kfjzUSe8ANs6K5mJ1FeMAgapQA==
X-Google-Smtp-Source: ABdhPJzjLRw9j/vxUGUr0fVvvk1nlQOO9whebEt/gMYFPyoxALUMhdZDkMeMEsHU7VarRhJKNWMJuA==
X-Received: by 2002:a19:98d:: with SMTP id 135mr6966522lfj.357.1605541440721; 
 Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id l17sm2796682lfc.221.2020.11.16.07.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 07:44:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
 id BA192100F5E; Mon, 16 Nov 2020 18:43:57 +0300 (+03)
Date: Mon, 16 Nov 2020 18:43:57 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201116154357.bw64c5ie2kiu5l4x@box>
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113111901.743573013@infradead.org>
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
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 catalin.marinas@arm.com, eranian@google.com, dave.hansen@intel.com,
 sparclinux@vger.kernel.org, will@kernel.org, mingo@kernel.org,
 kan.liang@linux.intel.com, linux-arch@vger.kernel.org, ak@linux.intel.com,
 aneesh.kumar@linux.ibm.com, willy@infradead.org, jolsa@redhat.com,
 npiggin@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 13, 2020 at 12:19:01PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> These patches provide generic infrastructure to determine TLB page size from
> page table entries alone. Perf will use this (for either data or code address)
> to aid in profiling TLB issues.

I'm not sure it's an issue, but strictly speaking, size of page according
to page table tree doesn't mean pagewalk would fill TLB entry of the size.
CPU may support 1G pages in page table tree without 1G TLB at all.

IIRC, current Intel CPU still don't have any 1G iTLB entries and fill 2M
iTLB instead.

-- 
 Kirill A. Shutemov
