Return-Path: <linuxppc-dev+bounces-18929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A8410F2859
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:03:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj6RP52vmz2xmX;
	Sat, 28 Mar 2026 04:03:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774631009;
	cv=none; b=YbeJlLwpEGbqsIIWoOCzqItIZgafZlYn5z09ohYG7mwXknNCr2nUzVrrMKuVJ/M7F3w851L9mKc0WCX2VyEBSd+py+kzc0nkGaVLJmLlY53mj5PRbEMaMl/7LhLc5ZzG6u6k+LWLHlnNwnpKLHi/+qTSZZRoz8g1w2IhHtq7uOPJtNO8mucca47jECKkQc8lkjdXiA/AUq77FIWjhkTAsSYIsZR3WLjtaq5FIm4chATr35VNA7X8+Cg0Bfs+jcgEztuPocVWfccAOLN70o4NSed1wjHwGUDHI8g+jLhbkM4I8hhbijgeVnc1ObB9r243m2gC2Sd82XtcVMjujwykoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774631009; c=relaxed/relaxed;
	bh=jlgvlIx2lZLy/yw0VsiYcAtefj+7HLiDE86xWPu3bn0=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HCkV6UOP+NCQRNphTCir6pbK5bezjyEqVE7P/k/wuuV6+wImTiQIq+XIQTlYqskn3UhXfS+3nSj5g1kyTBl+715FbXPHl6XN+Ui6+TykDQQaxEus8t15eWwSBu9HBm883RYhEHkj9whRu/D70OdrUzMqBlrD8SNgElrgvVpZkdvZOeiYIw2sqt4Q4ScFpUIbVRsaG7Lf2Dmjgvq0s/CHlxtWpr7Wilw6mqF8WqAHKffqL1bYZ3DLMdqYVNs/lwNFvl3w6I6I90qKn5ALfUIm2NVMgAZrJ/Np0cfrcKzbtM2AHpfd+hAmOcPuFXrCRp7vRuVXkMcUOyQV5spR48C8oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=oq9Nujey; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=oq9Nujey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj6RN5svdz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:03:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C912360127;
	Fri, 27 Mar 2026 17:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F22BC19423;
	Fri, 27 Mar 2026 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774631004;
	bh=jlgvlIx2lZLy/yw0VsiYcAtefj+7HLiDE86xWPu3bn0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=oq9Nujeyhp7Zx6NT/DmAKRTTx7w3723Jfsgcrx2JTII8ccXAVeunav2gzmNtcCWt4
	 g+b2onmd9YBtHJ7AgnnAAq/NWR4pHj2kIgRzkSL3306j4h3HOUuTBYP0MQBBSLDCLr
	 YLaYJ9G1El1MIqjFKuWcT5xV6/7jTsovIMJ3/INw=
Date: Fri, 27 Mar 2026 10:03:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>, willy@infradead.org,
 david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz,
 jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de,
 kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, chleroy@kernel.org, borntraeger@linux.ibm.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-Id: <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
In-Reply-To: <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
References: <20260326080836.695207-1-surenb@google.com>
	<20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
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

On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> Three of your patches lack review tags so now it's 65!

Three is now zero, thanks Lorenzo.

