Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B1606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gzaCyMM1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNccC1VLBz2xSR;
	Tue, 10 Nov 2026 04:44:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794246283;
	cv=none; b=aSosyAwGy+8E3GG0QMIBl3DkTKAXVcx9EOBhtAaXjBeabCQ0hdUCFaEXvxpGMLlB+EzmiSxsvk3DU7Rxo9TsqipP/wMJqShV6BczvShgMB4DuYNLjTfaIlOqZVLno8GY7VlY34Dw6Tt2FC+bjznYx9XGZXVCDED4xOP8ZrNiv2QwGdOwFRyMplxjBzXXy7vImNOvpjhgVRrl3hQu2cZtIly6JEce7NqGDFjj6BrsmhP6peLVdtPUQYkW048gN8rGfKfTZyQPMZdZDcEsfHc+ohynstUZc1Yk27phYnUUhwm1rygmwMMhw3OTvHR80d5/hEUf9oO20yUCBdLVrSaGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794246283; c=relaxed/relaxed;
	bh=+EpjN/DsBpVyfyR8n/gQ0lrO4LV9kbgQU5k49WPSPeE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nHkgh4KWLw6O9qFQTYL6iasr5RNPhx9t6xRwR+uj13qQhTMaRba5p3HlSTb0BS+NNgk4/8rp2K9RlvPur2w47mT/qgk7oaO5Bq4KJRa/DoV7wmj9ORkciF4EhDJNF8vanpbVmr/x2/k6ijJP9huKm7Rr+3Xawjg0oTWDOF9149QodTlgFtVkiq9KbFXcewzS+Kb+SkbnKl9qmaBlLHiSp3ZAfkdwwfjYpTw8M92XYECfbeX9fVtZ7hLwzcDy319dEGeTQEazF/wNVdfAWNX8R61hX39SI/K8JjunPm9q+ktIj6dRByTdqmRfS2h2LgyLu+uuY/CfJSbKYyDmWpT1gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gzaCyMM1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=gzaCyMM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNcc945bVz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:44:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A29806347D;
	Mon,  9 Nov 2026 17:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2301F0089F;
	Mon,  9 Nov 2026 17:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794246277;
	bh=+EpjN/DsBpVyfyR8n/gQ0lrO4LV9kbgQU5k49WPSPeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gzaCyMM1cJrjP8mVfAdfm9Tk0MNbUwWsCzu5aBYFwIXvHqXzHyjNWYvmsk0qAwsED
	 GA9iUPuLXd53UNdhLXbucDDSJCBnpyT4AdCqpMXhvrVqGpYP2eidMHAWz42rUr0Xzx
	 9ZMkq6R2Q8unfhnRO7BxhFf1Z4gUeAYDiBZoVcbY=
Date: Mon, 9 Nov 2026 09:44:34 -0800
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
Message-Id: <20261109094434.d23a227a869e76455ddff3b1@linux-foundation.org>
In-Reply-To: <93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
	<d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
	<au3r0-geuwtRYPiC@gremlin>
	<1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
	<au-DXpEi4wHwsz0r@gremlin>
	<93fef824-9f60-4940-9ee6-80c9c8e3f945@kernel.org>
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

On Mon, 9 Nov 2026 14:40:48 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 11/7/26 21:09, Lorenzo Stoakes (ARM) wrote:
> > I think we're slightly talking across purposes, so to be clear - I am totally
> > fine with you taking any of this through your tree or whatever works for you and
> > Andrew to avoid merge pain :)
> > 
> > I was just talking more generally about how to merge series that touch a lot of
> > subsystems and maintainers-who-may-never-reply, etc.
> > 
> > These are the edge cases that make things... fun :)
> > 
> > Anyway, I guess easiest resolution here is for you to take the bits that belong
> > to your trees and Andrew takes the bits that belong elsewhere?
> 
> Yes, that's what I did now, applying #1,#3,#4,#5,#6

Cool.

I'll remove the whole series from mm.git immediately for
collision-avoidance reasons - let's sort things out later.

I'll get better/more accurate about this soon - I need to set up
infrastructure to fetch everyone else's trees, do test merges and
figure out what should be removed/fixed in mm.git.  I might just base
mm.git on everyone-else and always route its stuff ->david.  I need to
spend a bit of time on this and discuss with the mm-next peeps.


