Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r2PT4lxPzDqmX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 03:16:45 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MHFF65012976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:43 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4n95g2dc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 13:16:43 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:16:41 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 naveen.n.rao@linux.vnet.ibm.com, jakub.kicinski@netronome.com
Subject: [PATCH bpf-next v3 09/10] tools: bpf: sync bpf uapi header
Date: Tue, 22 May 2018 22:46:12 +0530
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
In-Reply-To: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
References: <cover.1527008646.git.sandipan@linux.vnet.ibm.com>
Message-Id: <cc03fbc00903a99a8339cece60497c208cb4aa42.1527008647.git.sandipan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Syncing the bpf.h uapi header with tools so that struct
bpf_prog_info has the two new fields for passing on the
JITed image lengths of each function in a multi-function
program.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c44105f27da9..8c3109b5d6d3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2206,7 +2206,9 @@ struct bpf_prog_info {
 	__u64 netns_dev;
 	__u64 netns_ino;
 	__u32 nr_jited_ksyms;
+	__u32 nr_jited_func_lens;
 	__aligned_u64 jited_ksyms;
+	__aligned_u64 jited_func_lens;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.14.3
