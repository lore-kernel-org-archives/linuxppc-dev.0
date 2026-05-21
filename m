Return-Path: <linuxppc-dev+bounces-21271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6454CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLdzq3DBzz2xSN;
	Thu, 21 May 2026 16:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779345559;
	cv=none; b=I61yfOs5YluL1RUc1e6sgOqmFGcqgRQpzJ6x1UDyki1y5Ln4DzjoixBnxVCs1Vs3uN2cIe38nI6VcqlioJ4bJT/kPpAbScqbUMk0kQkWZvhWUKhmD1cUX/BBUTt2Dvxyny6qfgwEpABnZb9eDiDxpxH8DeuL8OAgoot0MdteFIe9y02r3M2HF03SSYKMcP7Yuxw+WbnUjzcN2/SL6zwv9l7guZ+PotR2s1UlZYGL6+eRHi4Nd+FksvzLquu6DnPpRXzvz7IDc+8HOvzmYN/Ni3kNj5dkEnDtn1siqpPM+1ARMvlcX72dBGHiX1WJbm8+itJH5/eyAlI5MrBEJRV6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779345559; c=relaxed/relaxed;
	bh=w2yZGEA3lho6ftsaxVq+LrAKP95Gff3FxI3cY3B/TaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWoe8uxSdO0OdBcGq+w0+f89mDkQzyVLVDR5PS5nahmin8rdfJmU2PkEP3rX2zPz1NGXHz6OF038n5lgK4/JcFwBG7azoOXerXizbcFiaWak3cHfXAXg8v7MVsqoCEljHl6iX6wCppxUFMJlPAGGgA6A7xMEJko7I0UUyvvel0Q6jXQB2F9IdxGVaDqN4IR6hEgbLqMd8uQwUd07bIYvjNZ+41lZCCTOz6VtLmZASX2ZaBH9uHpxjw3IdOmA9CHP8m35Gnp1n6MjlZOVHbVHjBQEPhd+lzVaBEjzCyucWCHlgX+xbgfHrGeMKVyYASkH/AOcVcyGSMO1E/dOIXfPIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gKtXGcef; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gKtXGcef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLdzp4tWMz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:39:18 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE1IB83442044;
	Thu, 21 May 2026 06:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w2yZGEA3lho6ftsax
	Vq+LrAKP95Gff3FxI3cY3B/TaU=; b=gKtXGcef/sC4+x8bGU14KBnEmqDoi9P7O
	CsnM9Qkq0D3J27qIswyWNk2wfmNu5qKhB6rBGr6ij84VkBO6i1Hz1r8vgRVKyjl9
	3IFqzzMu0iDedPgv8ut8NhUZj/1VhpE5MzgcmSvf6iuiOjN7nCV6xoHbFxjLF9Gl
	/q2lueaE8XxJo1PSzi9R2A2aQsRMJ4QxTgHFSofDwnejD+IT+r14qIaBQ6ta88ql
	XMa5WqmbMaaaIIRLBYovvmSKDWDIq6kSYtWAdGazLyndlNZ0+mPLGYiq3UChwX5w
	n5OeRO2CcA/GUa6C/9rVhQANziKzELSWhQXcZ4sHMROVsZZQrGFyQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawcbr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:33:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6O8VP020623;
	Thu, 21 May 2026 06:33:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gjjam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:33:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6Xtrq24117612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:33:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16CD02004B;
	Thu, 21 May 2026 06:33:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B02A20040;
	Thu, 21 May 2026 06:33:48 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:33:48 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v7 01/13] selftests/mm: restore default nr_hugepages value via exit trap in charge_reserved_hugetlb.sh
Date: Thu, 21 May 2026 12:03:27 +0530
Message-ID: <5b8fbb29cd6ceffe6752e0af104f60cec072aa10.1779296493.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779296493.git.sayalip@linux.ibm.com>
References: <cover.1779296493.git.sayalip@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1NyBTYWx0ZWRfX7BiSBC/BH+q3
 WNHXD3L9QBm4oBcc1dXRLOme/yBryy4Phu4Dk2NsjQvBHFPkfv0sNsRKStSd7gmvGGDyKK0fTOk
 JTdM/sSlmPpDGTBCiIT2v/y5D3Hn/0xv/fBFK1ShO669pnME6mCL3u8JKaocq5UQojKUf1CRHJ2
 alyPxsBf5qGcgIJl83tz2UukoonXdqG7WV4KABVtiY3gHvxKOPVmDB9OOnMfl4j9/Vxv4RMaphK
 VjX4/dVwJxWp4L4OoQPgLqaxFdEw6xPrwD1a1d65+Hwqub5ELbafR4ooiUQUf5Dei/ENWN9gTGs
 TudQou9qEBE8iMbhb8BENJUpytRoG/DcTFLJRDg8wwr4aWxmUeb4REALljJ26bKURBUISsNmN32
 8iil/F1vvIU1UJOh28RdZ6q1C2qfd6zUGCeUlh5DGPnXnTlXUfK791pOzxMEtC85aNOmmgNl9Q4
 i19gGqlJta/Mc5zNZrg==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ea758 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=vtM6K80SjIFNW2yxelUA:9
X-Proofpoint-ORIG-GUID: V0oBOkychhHPDJnWgUrLS-jFsIr72PlK
X-Proofpoint-GUID: scVNd80hmPse-gtev7kSfVtikji2rMeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210057

cleanup() resets nr_hugepages to 0 on every invocation, while the test
reconfigures it again in the next iteration. This leads to repeated
allocation and freeing of large numbers of hugepages, especially when
the original value is high.

Additionally, with set -e, failures in earlier cleanup steps (e.g.,
rmdir or umount returning EBUSY while background activity is still
ongoing) can cause the script to exit before restoring the original
value, leaving the system in a modified state.

Introduce a trap on EXIT, INT, and TERM to restore the original
nr_hugepages value once at script termination. This avoids
unnecessary allocation churn and ensures the original value
is reliably restored on all exit paths.

Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
Acked-by: Zi Yan <ziy@nvidia.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 44f4e703deb9..e1945901fd20 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -17,6 +17,7 @@ if ! command -v killall >/dev/null 2>&1; then
 fi
 
 nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+trap 'echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages' EXIT INT TERM
 
 fault_limit_file=limit_in_bytes
 reservation_limit_file=rsvd.limit_in_bytes
@@ -70,7 +71,6 @@ function cleanup() {
   if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
     rmdir $cgroup_path/hugetlb_cgroup_test2
   fi
-  echo 0 >/proc/sys/vm/nr_hugepages
   echo CLEANUP DONE
 }
 
@@ -599,4 +599,3 @@ if [[ $do_umount ]]; then
   rmdir $cgroup_path
 fi
 
-echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
-- 
2.52.0


