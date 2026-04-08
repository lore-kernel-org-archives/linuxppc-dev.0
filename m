Return-Path: <linuxppc-dev+bounces-19522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E7810F9972
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 19:50:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frYZN3BFkz2ySV;
	Thu, 09 Apr 2026 05:50:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775677820;
	cv=none; b=ZcE2Vk2wgVjAM4e3Ww2cQ+lbX3T8Jj4TZgsIM4l84VVFNgkpPlcYUir0shqFJpAzbHlZ/f13btki/S59cbyesItLQp5ohTn7eOXgDJ518DHZzoCG369XXHhTPmeWACuJFGLwblL9wCUMB7/VIBH2iGuflL1OXvR0m8PGe+a7S6w3LmGAbpdsL5Xh3kUuyMddwUhEzbo1K0xglz72zljhF1DZ6B/shzSKXwobT2jB+AWdcEmPTKBEHqb1swDbEirWn9IX213Q58qpnp0b5XWY6uHeQypAVsWpGlNwkVszViTBNwx5hQ226/sNIpBN8verY/S6Rit8+euKiWnoO5yz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775677820; c=relaxed/relaxed;
	bh=rqfHIKMJG4o9KpbmGAbUtbTRjKCgElpRQKpWc5hqOfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciree6KD52WbvpK4+O0sOnPoFblQWvSL+X+02mZVHkXu/3fzamJgGf+DNwjhj4odHtrr3uHGS//y3yLrJhw2K9LrKy8XHu5urF3bcIHvBzEIRrTMk9mF+3QD7OlY0XIRDo+EXQEm66XWFSFWidaZ0fVXCdamF1NcEssMcS5KQyLfIm8Zop1aVM8w5/A5H7DY3gAv2loX+3CoYbHqg+M0kuruj9a1P3H+oejcFJywStNCXbzDiqu3khvk9RY9HERQZNNQ5N5V4mUz/QBd9uTpIWRoV+6ldwWp6VDjsdD21fOLW2272Zdql6u/cs7pkMpMn0m033gP0uONm6hM0czVsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TyDAes4r; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TyDAes4r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frYZG3D2Rz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 05:50:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rqfHIKMJG4o9KpbmGAbUtbTRjKCgElpRQKpWc5hqOfc=; b=TyDAes4r/JzVJCWef5mCqmoY0R
	9qb6eoM3SlzyPGbIuuNBr5yUDWjEkyEOgm+2iOJqjGRgkerfCrKjk3c2xo/Qv00YGiF6njKOW1atd
	ox6BnpO+4pTok5Xu0ihl/cEqhnvHHqvNYqiiML7gEOpJQPoRUESqNKDcvIcVYyQ/27Q5Vk7PZORpr
	aFalAmaqDaRMiucCoJYeVW1ovOGwuTQh+VgI0zVR+m07i1DTGDyrW1WtxODqHlagqJazZGJSj0jyL
	zk5b+Dl7/FROMKCAcpR+KvY7i4vz9YtDmonyYsP1abVRJDfQ5ilN3xLxJDih89BQ3g/xucUAb2gTR
	Q08EqEaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYuI-00000005rWi-2gai;
	Wed, 08 Apr 2026 19:49:46 +0000
Date: Wed, 8 Apr 2026 20:49:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org,
	fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
	shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org,
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Message-ID: <adaxWs8BjCJB1aan@casper.infradead.org>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
 <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
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
In-Reply-To: <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>

On Wed, Apr 08, 2026 at 04:06:29PM +0100, Usama Arif wrote:
> On 06/04/2026 00:34, Hugh Dickins wrote:
> > What would help a lot would be the implementation of swap entries
> > at the PMD level.  Whether that would help enough, I'm sceptical:
> > I do think it's foolish to depend upon the availability of huge
> > contiguous swap extents, whatever the recent improvements there;
> > but it would at least be an arguable justification.
> > 
> Thanks for pointing this out. I should have thought of this as I
> have been thinking about fork a lot for 1G THP and for this series.
> 
> I am working on trying to make PMD level swap entires work. I hope
> to have a RFC soon.

I think you may have missed Hugh's point a little bit.  If we do
support PMD-level swap entries, that means we have to be able to find
contiguous space in the swap space for 512 entries.  I don't know how
hard that will be, but I can imagine it's not that easy.

