Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87230606A33C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWagNd19
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYq9q1xWyz30gY;
	Wed, 25 Nov 2026 04:12:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795540335;
	cv=none; b=BbmDjsf06GPSFkTrUQG/jXXj9cPlhBRkSJ5Dh6fEb2zcPDUa1BZ1fEesSSbyErlnFkXU1AFwGMf5X06ouG6RJaZGFxPzhvLRwddP7HpR+vdFdBKTc61DgSecXuEUxHgKurKBxWS5c5fjvrLDGqn2uNt3A/p03NKQcc9qYNMq9vNYzf8CMiLKOmRKtu/ExU+oSSyKA323yDUmvm5OginXghEhjjPU5v3Gm5MR8pwTa7Kx4JHwkpsMj2HaTp2INjnEyDtASsrLf+Uwt3tMHlzjELliuiWoBBx8K3mdMdiXFwHT/7OjdmxE9Tx8BxrYZ7boNLv5OwqajgNB2KLWaMIK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795540335; c=relaxed/relaxed;
	bh=0+HphfNU3P4NBBhVQLGMxkibHciZuclM2bCzuhUVplc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXFL+if9DODk1Zfcy2R4dNPfNmsbBg+NeyMGZTmLeCDccDOgw8YYAgo9SsrtwozN/A7+B2gqkoCQhuiH99PVKI4i+84119f6IOuTyL+gpwUVWRJNmkdWOO7swKmq29F1jBdPkVq7m3mgHYcOwrNVFiB/L4JfFBC2EDd5gpR+CGN5NIKE2vxdDoYdWcuO+/TVaP8+oXHjX5eu+unTYWPOfyvCsK/tVroZvprrFuyaVLH2tftJVaMkahXySljMRdT13hHIw7t8HxhxknDH9xokKXpCtzwsiBUsDVeH/Yj58Cw1gDhU72kqgmrvJd0qgmkMO4SnIWBqwlaRM2jbwi3uBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWagNd19; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWagNd19;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYq9p31S4z2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:12:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D42ED42E29;
	Tue, 24 Nov 2026 17:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3071F000CF;
	Tue, 24 Nov 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540332;
	bh=0+HphfNU3P4NBBhVQLGMxkibHciZuclM2bCzuhUVplc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZWagNd19/8Mk44HmITE+UK2Cz9B7twpXQYvnU5XoBwiZn9SNSuxJ6H2KXuIyFiBbD
	 mUu2MBXhBsaf4FVIxVAk5uiY+bd1NKXG4FySE+eM4ORkYgEvn+OX5kW21KOo0i15bH
	 dxr4ALMuUNmufjoW8WCp75e49zHcTaSAc8XzGpSjO9ibxBcSBC5jbmDUN3VWGcTqUG
	 nP+HfGZxER611yILD2Dvagn7Nol68wczlg0rQon2NI5u3CN74liWodnNc7glhVXdeG
	 qDj578np3LllXgDa6fPEyjrdcs2yQpdj+8wq9m3ffUeqxAMjsitxxJuPlnJ0ZDNkog
	 O7BrCNGKYhPCg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:08:03 +0000
Subject: [PATCH v2 11/11] ipe: convert VMA flag tests to use vma_flags_t
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-late-2026-vma-flags-v2-11-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
In-Reply-To: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=ljs@kernel.org;
 h=from:subject:message-id; bh=rH0wf7aPN+m4DmrJH+N9jL6VIPzo603o+4XYYEWHbSg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+R/2dj58xw7X5Og//KWFIMU+4jwM2fUJ4Qcy+LZN
 qXWvFW4o5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABN5w8jwT+0pX9CaXievXrOO
 oD5dM+fKPUdm/wlT27d5VmVMUAC7HMM/1UvBYTJ1D16aumfMrjA9HskncsZ9Cnuar/vDX3+0/p/
 nBAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
IPE mprotect LSM hook.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 security/ipe/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d878b52ceec8..247b07748b1d 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -112,7 +112,7 @@ int ipe_file_mprotect(struct vm_area_struct *vma,
 	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
 
 	/* Already Executable */
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		return 0;
 
 	if (prot & PROT_EXEC) {

-- 
2.56.1


