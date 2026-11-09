Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF579606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=alzL5p/E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNcl42tb6z2xhS;
	Tue, 10 Nov 2026 04:50:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794246640;
	cv=none; b=jjCtRs6Yp6v1dctQ9aHu+Qv0juW5WCU4xe+RIJ5IxmiSu8z2Iu2ZwO3PeUmmiBcmyxJFHdpGCTLNu3uUJPyT/+gqHC/zo4309wI8ONXPYCB3l2r7w0vFwhC3KqUkyHT15v8boFSBciiAHD7wnAavcv0ieiw/6aRYFdtXn0vyqaKzw7fcXdU9y4wwIubyvMXtV3IzG+Rq+gBnjF3I9VKOIQYEZYToScoNk1AQC92FswrFuV2AhexCWNa8okAB9Zr0rWYhhLHfgOsGpkb9Xjk5Ay0Rshji51z4N85Ed+zx3Fic3fVPv/0+tZ8xo7strdc+2uz+0+fJ9Sap3i7SvLDltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794246640; c=relaxed/relaxed;
	bh=4Y+apbv0moZAbIC2JZwKUuLxptoIhomU3mV95VqD+l4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eNSBPiBO6e78KAQ2ef3m7Bui0LZHGSOpdS8IVT6zGMpNoeV2fkg5WVhGLVaaAwAGg4iYvbOdXrRfMJN3+26n9EC6hGQwRg//ewH2sfA0sl5CvpY0MsieQKPfkR+j36giw2EbybqMdKjG7911XNCfPTOk554oqwSpjc/qlCBN09MuGUNxTQ7mOPmr/WnatMqDV3uf0iTz0z2LSNPTPeVNEkoyq00mKm7DP4jTJ4SvO/BJeCgfdbyjODt+CFkRoK/Vcpia+/H695YXIZzBGQ4AVm5fHVPW9YMv7Hh1rk60SQeEqEmF4cAOrio7wOFpeDLVf7un90Jh23nFUzetbrYGJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=alzL5p/E; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=alzL5p/E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNcl34JQhz2xHG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:50:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 47F5D60A95;
	Mon,  9 Nov 2026 17:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BE51F0089F;
	Mon,  9 Nov 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794246636;
	bh=4Y+apbv0moZAbIC2JZwKUuLxptoIhomU3mV95VqD+l4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=alzL5p/E5TFjU0f4S3NCoMGJBvZNjLceDHvjdf7oUnrtQutT9d/lual9TYbQaYsV8
	 BIDjLsHSLUcOK6q2LAzWt3YlvV/WiGiPoNNU3sNfH3m3TbLCyeOWWakP21fgtRFZY7
	 MuUKvUaoZ86WAElRGG65TDNBtS7Dp15/zVMHHz1w=
Date: Mon, 9 Nov 2026 09:50:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul
 Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky
 <leon@kernel.org>, SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
 David Rientjes <rientjes@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
Message-Id: <20261109095033.ed2b0334c862ca832389ea7d@linux-foundation.org>
In-Reply-To: <ab4be2bc-8959-4c09-a120-37e216279dae@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
	<d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
	<au3r0-geuwtRYPiC@gremlin>
	<1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
	<au-DXpEi4wHwsz0r@gremlin>
	<93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
	<20261109094434.d23a227a869e76455ddff3b1@linux-foundation.org>
	<ab4be2bc-8959-4c09-a120-37e216279dae@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 18:48:07 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/9/26 18:44, Andrew Morton wrote:
> > On Mon, 9 Nov 2026 14:40:48 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > 
> >> On 11/7/26 21:09, Lorenzo Stoakes (ARM) wrote:
> >>> I think we're slightly talking across purposes, so to be clear - I am totally
> >>> fine with you taking any of this through your tree or whatever works for you and
> >>> Andrew to avoid merge pain :)
> >>>
> >>> I was just talking more generally about how to merge series that touch a lot of
> >>> subsystems and maintainers-who-may-never-reply, etc.
> >>>
> >>> These are the edge cases that make things... fun :)
> >>>
> >>> Anyway, I guess easiest resolution here is for you to take the bits that belong
> >>> to your trees and Andrew takes the bits that belong elsewhere?
> >>
> >> Yes, that's what I did now, applying #1,#3,#4,#5,#6
> > 
> > Cool.
> > 
> > I'll remove the whole series from mm.git immediately for
> > collision-avoidance reasons - let's sort things out later.
> 
> The mm-next merge today still worked (minor conflict on #7 due to one
> unnecessary ksm.c hunk I commented on), so you could have likely just kept all
> but the above patches.

OK, I'll take a look at re-adding things...

> > 
> > I'll get better/more accurate about this soon - I need to set up
> > infrastructure to fetch everyone else's trees, do test merges and
> > figure out what should be removed/fixed in mm.git.  I might just base
> > mm.git on everyone-else and always route its stuff ->david.  I need to
> > spend a bit of time on this and discuss with the mm-next peeps.
> 
> Ack!

...once this is in place!

