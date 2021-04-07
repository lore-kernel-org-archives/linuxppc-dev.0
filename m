Return-Path: <SRS0=l0Nn=JE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D101C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 04:59:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928656103E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 04:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928656103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFXJ75rBJz3bsN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 14:59:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pba1jUSj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ganeshgr@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=Pba1jUSj; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFXHf01GYz2yZ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 14:59:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1374XO9U179864; Wed, 7 Apr 2021 00:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bC3RazOxXaJbYUw1vL0KTDaB8oxaNHeDRXR4pDwnoEU=;
 b=Pba1jUSjMv9Z23Zp4h19yGssui6gvvF0VXfPim9HKHY48ii2LEq49f8bKQXlWPUyi+s8
 7VvSPCJV7ytZbqWERVY2n0Dqolov0gK7wof3r6CksZSgL144tNeFKp+mKX2vfk1IYCoC
 sgK88DXUn35XrfQXQSyrnwbaErs8thjwKsXjIsG93RlvTt2ZkWwACGfrYttfQOpQ13Rs
 /JsbaGKb9hBq5SQet0svaQt4WfqaXTZFJf+NPc7eOUbaUJgmaHJcVyjstmmJXuIh+oD8
 1AyK/Q9dyT3UJtF064OwFQLCjZWPxJWE8dWioSDE0S5Ngd130m8W9v5MjsxI6Z4eiDwf Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37rw074hhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Apr 2021 00:59:14 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1374aLbh192285;
 Wed, 7 Apr 2021 00:59:14 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37rw074hgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Apr 2021 00:59:13 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1374w77H016449;
 Wed, 7 Apr 2021 04:59:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 37rvc5g602-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Apr 2021 04:59:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1374x9FO41026040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Apr 2021 04:59:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A95642041;
 Wed,  7 Apr 2021 04:59:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64C3442045;
 Wed,  7 Apr 2021 04:59:07 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.50.157])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Apr 2021 04:59:07 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mce: save ignore_event flag unconditionally for UE
Date: Wed,  7 Apr 2021 10:28:16 +0530
Message-Id: <20210407045816.352276-1-ganeshgr@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yoSYCDXrT7UZ-JRX7dYp2b4gCXf_2093
X-Proofpoint-GUID: G99hqtbY3Ie7T7O6v7qS5JbKMH7OitQq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-04-07_03:2021-04-06,
 2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070030
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>, mahesh@linux.ibm.com,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When we hit an UE while using machine check safe copy routines,
ignore_event flag is set and the event is ignored by mce handler,
And the flag is also saved for defered handling and printing of
mce event information, But as of now saving of this flag is done
on checking if the effective address is provided or physical address
is calculated, which is not right.

Save ignore_event flag regardless of whether the effective address is
provided or physical address is calculated.

Without this change following log is seen, when the event is to be
ignored.

[  512.971365] MCE: CPU1: machine check (Severe)  UE Load/Store [Recovered]
[  512.971509] MCE: CPU1: NIP: [c0000000000b67c0] memcpy+0x40/0x90
[  512.971655] MCE: CPU1: Initiator CPU
[  512.971739] MCE: CPU1: Unknown
[  512.972209] MCE: CPU1: machine check (Severe)  UE Load/Store [Recovered]
[  512.972334] MCE: CPU1: NIP: [c0000000000b6808] memcpy+0x88/0x90
[  512.972456] MCE: CPU1: Initiator CPU
[  512.972534] MCE: CPU1: Unknown

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
---
 arch/powerpc/kernel/mce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 11f0cae086ed..db9363e131ce 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -131,6 +131,8 @@ void save_mce_event(struct pt_regs *regs, long handled,
 	 * Populate the mce error_type and type-specific error_type.
 	 */
 	mce_set_error_info(mce, mce_err);
+	if (mce->error_type == MCE_ERROR_TYPE_UE)
+		mce->u.ue_error.ignore_event = mce_err->ignore_event;
 
 	if (!addr)
 		return;
@@ -159,7 +161,6 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		if (phys_addr != ULONG_MAX) {
 			mce->u.ue_error.physical_address_provided = true;
 			mce->u.ue_error.physical_address = phys_addr;
-			mce->u.ue_error.ignore_event = mce_err->ignore_event;
 			machine_check_ue_event(mce);
 		}
 	}
-- 
2.26.2

