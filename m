Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BE60A261B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmOjMgq1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYl1S1sW0z3bRp;
	Wed, 25 Nov 2026 01:04:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529084;
	cv=none; b=jVp+phcTP1PdNBLRTaY1wK2RbzCUBjAITO3iGCfRzk2KKYL6/kNeEuUGD1fHOk0up6XBKJqJ6Q0HauU9Im5JXu7ynfeKcpoFdpCJT0Pz1qJAmxtHbXcR/dqp2bcHZOTrYqDbonIclmhufqMaPb5a2WWO8P1F+oHHAV6yg247DJC6qsR9ADYXhb7tSQ4DfhbCT1xzCWvwz5n8v2MGWycrCChg3b/VGW5uWVpvR8pvokC5bwawPBAlGFhD/EpFGhd3ywDhp3LRl/bJtvl0v4Y1fvyJtP63+H2L3OM7drUhM2ghzwoKDKLLOfhShNEIv2mOzoTXXJYbVx94chYr25pASg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529084; c=relaxed/relaxed;
	bh=BK9UkUpVXySdPSUWL4MtzIhDYD5JibSz3LW4sTSavdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7ffQ5728Vx16bBRYVc64T0P6/j/t1HAds+RSGtdCixgxFSQdYOBqdlyMbW3u2plR7gBt6352lOKuqHFKqPzMTw73iEQ7YdYHFae5EjPkEF5kAXyOho/7sj4lS3blUj7Baa8EIHcLEbe0wTOMNvby8Smu+KrgtSVfz4uatlGcu/zbU3BPw3ckE9Jc3XTzBqXgG89aMqZYMlYJ9/qvKTn0UsEtvPYL6lm4fxZahR+wsBKNlnfHt8k55X+kp8nfmI5wmYaaqhInUHrzIJVqFsw2CdyBSLR0SO6BQwFfqSO4QWar1HT2A/E9SDHOHTZk4tB7AYwfruKKrJ6bRrHFsswXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmOjMgq1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmOjMgq1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYl1R1xLtz3bQl;
	Wed, 25 Nov 2026 01:04:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AF00344E7A;
	Tue, 24 Nov 2026 14:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729F81F000E6;
	Tue, 24 Nov 2026 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529081;
	bh=BK9UkUpVXySdPSUWL4MtzIhDYD5JibSz3LW4sTSavdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dmOjMgq1AGHQhoPvgdNne8I7eN2qrY76RiZVstLKlFppxRHabagSB9sep/9K9mZdE
	 nLLP7Q1FHCs2qRhYXPNt7ChclwrhqGsgnsOq1hYmbff+3OXzpBVOP4lsBE/sUuHUR5
	 uirkuvsCi7X4GqoSdB+en4U8Sy13oV7G+ueSmZOKRFtSyxsrhQTzXalDfjoMEQzpYq
	 3CRMtpauYGtg1jGfdjwxhVQCpbVNX0J90S++nN1X0ja0iCJE8Ir4ZdH7W3hfRB3z0g
	 WN+4j5cGNwx6NimhARjK2ljToDaJ5E58eXVt1V8hwmzVZxRVA45LfwYQ3rGzZq7dyN
	 LSyPS1qyImMjg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 14:02:48 +0000
Subject: [PATCH v2 05/13] udf: convert mmap hook to mmap_prepare
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
Message-Id: <20261124-late-2026-mmap_prepare-v2-5-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Scott Branden <scott.branden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ljs@kernel.org, xen-devel@lists.xenproject.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
 selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, 
 linux-mm@kvack.org, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=ljs@kernel.org;
 h=from:subject:message-id; bh=URnAKhKjrnC9kDrA9QpmKilue78LSAEztCmpaQ/lqmk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ4r3PzDca7/h2XGXyeIC/WJhW86nv0u95Kgds8nDO
 kLC/vOzjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEyEI5nhF/P+cqnP57MPb+5/
 5XUkdfMc4d8ZmdM+TvrjEm8uylFV3snwP8qi/v/7juApxftyPktMul/zaIXBPPuQggQu3009C++
 YswIA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
only updates the access time and sets the VMA operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 fs/udf/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 02e9314818dc..d5e80c6cae96 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -190,10 +190,10 @@ static int udf_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int udf_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	file_accessed(file);
-	vma->vm_ops = &udf_file_vm_ops;
+	file_accessed(desc->file);
+	desc->vm_ops = &udf_file_vm_ops;
 
 	return 0;
 }
@@ -202,7 +202,7 @@ const struct file_operations udf_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.unlocked_ioctl		= udf_ioctl,
 	.open			= generic_file_open,
-	.mmap			= udf_file_mmap,
+	.mmap_prepare		= udf_file_mmap_prepare,
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= simple_fsync,

-- 
2.56.1


