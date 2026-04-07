Return-Path: <linuxppc-dev+bounces-19432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BACFEEF32
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 12:44:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqm964GSGz2yZ3;
	Tue, 07 Apr 2026 22:44:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775565850;
	cv=none; b=eqbV05cayno7MK7no8OeOLKJzlGhWDgiXNZwb0s3rUzhiNlb6bmCi3J04ukddcN+Qcf3Wt7mVTb81UW1jcf6oLJ54alb4Uqgj5mTWCuoLec9PiBOadecmGF+EwUneJRumCuS31Tbv9WWAlseNjtNHnA9Im3dE5VMp5nsH7XFMsdwMFt3S5QeI5AQmUtqU1kKM2BSmyYh3TCGr0ahkpCT2mFrOoRrhEsdrL33DvsKzVi5dVW19UwK9Xt1xdTWBgkQKurRAGtd6bnwsBAdQL7lT2BA99+lJiIJi0xipSSMCRIZKxLIamZdhKFtzPRFJ5QDJdHbOFcLTk1CjVPisFWrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775565850; c=relaxed/relaxed;
	bh=QuRTimfKyt8pOVs8EIgEauakL0kLBkA9knf1zUn5MXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fY2rbs9W3t7yNmdjutSRxoL3VTZj2Rlv/TPICnyAY1/KSYk92N33YZEKke0sKPr9P3BaO7BbtzUgVyS4yh1WELoCacB1zDtu8rkWiKFnSMFHDpvTHD9yiqxHkWRSi/YFZPJG8cOoZkWr7ohhYyc5MYg5WwtyvbTFYwL/KGFhceJjkgp6qQU5NSrHWGk4REGOyrZdrjvhEI++srIqvCc7zZrb2yTmtyZ5NCtULhrdIwAmRB+LQapy3dgtD3cuP4Hbvrfo8SOIBMBSZPRowt0aqMMlHP3QluVHobPR/WYsWkB1BNXif5hUQ+Sy085BCWqmam0tEokyThci4EQ1scQ/tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dIiZwJMD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dIiZwJMD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqm954gRyz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 22:44:09 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Llsr42210133;
	Tue, 7 Apr 2026 12:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=QuRTimfKyt8pOVs8EIgEauakL0kL
	BkA9knf1zUn5MXA=; b=dIiZwJMD8JnDI9WD90kwWp2FroE0ob3V35vZI+v+9dI1
	FlqsjFFB90maAPwB9iIh7CiuCU1LBMi1uvWf1nkMATKG3FOQW6O72Tg3pHWTCsXD
	TqLF70Rfn65ViOb91lr2ouhnG7evnaMKZrgjrzezj4wCAW98Mo663XNqlDzCA/P/
	RV7rQYFLL0dalquTH38iTzSlnLDxZN1ktGRqWz/FIbu+WMlx/cIIut6NICyEbWiI
	IncI7CXQk/jRMsUX8fqvqG5THuufzGK5rUpjIEjXTHdWV4tv8w0uvQ7oa3POKd55
	kEX1vvgOFbMyPzU33q4UDVoIp9ISVJKkhkuO1G3/5w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hanru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:43:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BNMma014348;
	Tue, 7 Apr 2026 12:43:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4k43r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 12:43:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637ChsNr62456234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 12:43:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50B0D2004B;
	Tue,  7 Apr 2026 12:43:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7075020049;
	Tue,  7 Apr 2026 12:43:51 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 12:43:51 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v3 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Tue,  7 Apr 2026 18:13:44 +0530
Message-ID: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExNSBTYWx0ZWRfX/26bzyeVB4N0
 i2eG5baOE2OJ2OAGgYp4CM3IoF6oKLcPiHflDtbDBEtPPIQvWAnqeXIFMUMyNMyZ8qI/m8yEely
 tVovxqrdRmvtc5JvKyYhUK/U+CpJguTiGqsjyXPvgOaXw5S3F3jcPov6LmDx5wwHEYlmTBzzYSs
 YJEa9sD6o3o5Jy9pUXK5kxWNHGO10nIG9dIwX4M9WOy9ySvMaa5UNufLrzifg2BDqkGBd8HW7QS
 GXz4w7O7H3ffW82WF1PhqxwZEqGrrkGa0UeZyD4QWA2gkawGo+/i5ucnR+eobrKyWkEw7c648sT
 lPG0udebqhMUywALqNBku28LC/++i8gLY9iVx1KDGb8xk5yThiOKBfl3rNaSgkMqM2R6TnreFgE
 RppGZJbSmCUpldbosIxtjpdRb9BOSxrWbIoJNTeuMFiiIM8fSb+axgUzzChTvLQ0zdTY4sOteI9
 hMjNvsWBkC6CBN+DYKA==
X-Proofpoint-GUID: 9lTQzIf1fjXXYBAXjepwqf7gB1ensLDQ
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4fc0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=qf4gfuq51q0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=Rbr8bO_GjACkDpKrMaMA:9
 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-ORIG-GUID: H-DLbFkDn3fwD7ZhmiqJoRA_mnQkMhsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070115

KASAN instrumentation is intended to be disabled for the kexec core
code, but the existing Makefile entry misses the object suffix. As a
result, the flag is not applied correctly to core_$(BITS).o.

So when KASAN is enabled, kexec_copy_flush and copy_segments in
kexec/core_64.c are instrumented, which can result in accesses to
shadow memory via normal address translation paths. Since these run
with the MMU disabled, such accesses may trigger page faults
(bad_page_fault) that cannot be handled in the kdump path, ultimately
causing a hang and preventing the kdump kernel from booting. The same
is true for kexec as well, since the same functions are used there.

Update the entry to include the “.o” suffix so that KASAN
instrumentation is properly disabled for this object file.

Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

v3:
- Cc stable mailing list
- No functional changes

v2:
- Add Reviewed-by, Acked-by and Tested-by tags
- No functional changes
- https://lore.kernel.org/all/20260403190123.1383198-1-sourabhjain@linux.ibm.com/
 
v1:
- https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
---
 arch/powerpc/kexec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 470eb0453e17..ec7a0eed75dc 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
 KCOV_INSTRUMENT_core_$(BITS).o := n
 UBSAN_SANITIZE_core_$(BITS).o := n
 KASAN_SANITIZE_core.o := n
-KASAN_SANITIZE_core_$(BITS) := n
+KASAN_SANITIZE_core_$(BITS).o := n
-- 
2.52.0


