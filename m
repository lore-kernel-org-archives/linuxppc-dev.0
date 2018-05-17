Return-Path: <sandipan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mhRM73RLzF1f2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 16:36:47 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4H6aUNH045667
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:36:45 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j14bbgpqm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 02:36:44 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.vnet.ibm.com>;
 Thu, 17 May 2018 07:36:01 +0100
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: ast@kernel.org, daniel@iogearbox.net
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH bpf 4/6] tools: bpf: sync bpf uapi header
Date: Thu, 17 May 2018 12:05:46 +0530
In-Reply-To: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
References: <20180517063548.6373-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20180517063548.6373-5-sandipan@linux.vnet.ibm.com>
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
addresses of the kernel symbols corresponding to each
function in a JITed program.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 83a95ae388dd..c14a74eea910 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2107,6 +2107,8 @@ struct bpf_prog_info {
 	__u32 xlated_prog_len;
 	__aligned_u64 jited_prog_insns;
 	__aligned_u64 xlated_prog_insns;
+	__aligned_u64 jited_ksyms;
+	__u32 nr_jited_ksyms;
 	__u64 load_time;	/* ns since boottime */
 	__u32 created_by_uid;
 	__u32 nr_map_ids;
-- 
2.14.3
