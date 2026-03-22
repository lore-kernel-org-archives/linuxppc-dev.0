Return-Path: <linuxppc-dev+bounces-18560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F3FC72A9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:17:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ff1fg2VQqz2ySb;
	Mon, 23 Mar 2026 03:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774196251;
	cv=none; b=YfmPm66V/SuzdEFuqRrGjqkf6rFfle8g167uIn51XaLbGoHlePWPnoBIe1TbOxTPL8fLSMLSbzkKN8KtXuUwb1MRyajupkpAgOHzSqfEDjxazIsuAI6WfMGG3xTf+lYMmoCyEmoDAbBzTwm0rTT8bmus3mz3FAiV5o5SmAC6uVoi68BBWqX7/5bVcUgqWEa8MAThvSznzPKwFq5LcUTM172JhNdbqeEc8S6+raeIUmJaKgPy2lqXzMY6X0PaZNThZGC1Vldy7E61GZHurbk0BkWoTfmUJN14lPOPKxC+WlC3ZC2I6DUBrO0vyCyi97arAMjXmFS04yjCUInj3BHq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774196251; c=relaxed/relaxed;
	bh=HNRDwT63C9SqT75nbbTtKGBy0nj1zHy752JbqHnkVB4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pe7DD/htgFqvjnfoR/5ZAGgXxVcZ+ONLslHIU3fxQLhswYXtMzEAP8SRa5Mo11ooHt2SVA8+ctTEoYfdv8776cNrLBNuclhmzYyBxveI5gjVCzMiokhcS/HVggMjoo3P5MmsRhZ5amfSjPbXgmOhiImDGx63jXTJ3q61Wtn4Hv5tyU3t5BAGbYOpj++qavWAWt/o7uwweAQ1chhQIqpG/onxyl5Les5G8MnYIF1cLwk34BrUQSDX2DprQBYgoCYLD5hIZd7wyIfqLca0paN+iR/i2y9SX12jjOfWfPwXOQ/hnBClJTH8Khp2x5XC7hqvQs3tLllXNNg+MF8+SipVfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rqMEGL82; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=rqMEGL82;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ff1fd4ZlFz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 03:17:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E2BB343D53;
	Sun, 22 Mar 2026 16:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC38C19424;
	Sun, 22 Mar 2026 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774196245;
	bh=xn7acWrcNfOM9ZzwScwVBSuLjXy+6p1AilKCtVPfDiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqMEGL82CatXzSZUGssMlnUBlu7gibQcWJDmvlWNKM8wR3LI3RfabxRShgetGdnKM
	 qLVqViq53DE0oJ/EZ62HKok/IvlxVVVO2j8c2jdxjK1jRsQYexN6L6lz/p6Ea6GpOg
	 Z40l5OIIF154Wpf+2VLWVtL80h1i7JP6sGNOXwGg=
Date: Sun, 22 Mar 2026 09:17:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org,
 mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
 borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
Message-Id: <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Now that we have vma_start_write_killable() we can replace most of the
> vma_start_write() calls with it, improving reaction time to the kill
> signal.

Thanks.  Sashiko review raised a few possible issues:
	https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@google.com

