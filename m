Return-Path: <linuxppc-dev+bounces-24090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2297EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:27:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8Xt4Hyyz2xlv;
	Mon, 13 Jul 2026 14:27:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783916830;
	cv=none; b=kWcno0QCtTKui3Cnqytk0JnMq2KP9hi3JBE/fyj71F0JMWqnQh556yQJOX7fxA4g1r3VGdR8L+b7Kb+K3tlpakMnMoxQUUkB0FXykLd5ng5j83g2FMByGGPC39SWeRYQTCyp7vgTOtcTZY+sUx7IfzFphcYJX3SdTmvTpPkJrjdPPk/WQOu64lf+bS3RzbNssD9P9Ifl664UrfCXWLpUdr7kGdvpaK4+27VYmrNrFcS93AudDno3TXyYTFl/PUVg81BMSFhkMZWEp5RZ6P4VKv91Mx1TTYKGG161EMxw1CmEesQgLCVo4kCZHlirfM3aklr525cXWLotmNgsbq5xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783916830; c=relaxed/relaxed;
	bh=kGRRy+bKuvNXd+ir9pAcvJxD2NWQ7EkbkWbRexat8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVWEvD8fbPxFIZUeK87W5AdKlKGu1Zp4bCWp0BpNvHRwE9Pz6vlgTem2Dka16mPvo3pMm3EQb0LJXjVZ/YwuDnyzglWh7vyDbe2Gnx7plgFhDftMEQOZO/Zh/rNrcE34YMEGz+XZc8y5/n0vrkt/GhnFnuomAP8xWbAfuIhjlZTN9wuPO4LUFtcbZ91dJK0pmwUtwU6rNvGvAGceaQk7s7aYJ6HxQ7RpWbR0n2MegGkhcF7Aipgxke68m1TtFx1ubWxLciaBXrUsdRQe+oHcFqb4HQdEdyvRLpK5QqD301+v1FCBlVPqu0mjujFyfWfMTKjOxBKzc1XEXJMz44LuCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h40p/Kha; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h40p/Kha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8Xs2mLBz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:27:09 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3BjH61242743;
	Mon, 13 Jul 2026 04:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kGRRy+bKuvNXd+ir9
	pAcvJxD2NWQ7EkbkWbRexat8aU=; b=h40p/KhaSNzmsK/NIaUB9NPzC6SBRr8N0
	5+NWlwHY5ZJcypyJPMgaslm51F4evpQ1N0myqoVaTDOZCmmt0sG8HCb4wDos1Unk
	nYyFhvLUOqjTFHdo/qlhjuUGkQUya0mPymHREP259WjqfLdFxN2h68ZieQIi3CSp
	j9EA+zJ3k2PuHa75t+ZBb4QdNXAi/nIYfaa/w8a8navo3V1ki2gdkP0qL/2JjBQz
	fzyoqCmeaxR+D++WYZwEQKNfj0Vd4laBfUcETHbzop6m1YizFkT1f39sThI6mVQK
	0nzE2n0LKBe9EOC5Fr8Eq6PHUBXUlfN3oIGf1f2UDMGBhqnZ/uBNQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwed02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4JaSN031333;
	Mon, 13 Jul 2026 04:26:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxuqj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4QqBP26280594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:26:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC22B20043;
	Mon, 13 Jul 2026 04:26:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24E4F20040;
	Mon, 13 Jul 2026 04:26:49 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:26:48 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 2/2] Documentation/ABI: remove old fadump sysfs doc
Date: Mon, 13 Jul 2026 09:56:35 +0530
Message-ID: <20260713042636.1599868-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713042636.1599868-1-sourabhjain@linux.ibm.com>
References: <20260713042636.1599868-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-GUID: MfNM1pJYpHXwiIZfzY4jz7FhFi_UqQUH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX1OAYK4TF6bzN
 2VifRChtR5vi0Ftsi0yFbSQQ8XelgdhFv2hmLcZdrust2TOEiXl/u/xaeLQyh9kSudk664XiYnJ
 qNWFOpc2BAgMy1JUFsnkv9GyxacoCNgifht0cLl2OKEfVKvX3qLeETjheBeg/+M6rwcFf5XxTX9
 romnjAuzKmz2QtInGfTIgA8ZticbZLGQlaXJ/D1NFKiSLj0OmglSBTuZmaUvpyWqba2fF2mcgUe
 UDM0WeAPJ1az0biJWyGqW3OHkOeGTGxnKa6oGPwFxmv4qHtonDWx9A2aKmXZ28DWX5ayJdW3eJR
 gMFChlGuFj67gWcUpmOBUP7484eH5LM0ieZrgRafyPYiYCJNQdan+gKF9blgcZ3IPE/azrdzN5n
 l8doMKT71TTF0AI6wJytn/HhcGwVWJpP5Hh0ThwT7dx5gMpeAO+6aio9OVTZ0Mxu8vVvU8ucAn7
 zSgF3YQ4C3lZvsfGlTA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a546910 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=4z1rTaPeV52oHNfb0hgA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: HdgfniYOf6Ztnb1sdziAWN3SE0KQQInb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX4m9W8JVtVXZh
 i1iVN0UJd1JDlNMDBb+ZZhR2EEYsfEe7nupWK/E3bAHcS87lkdYXWtPGnBYEq9t4hTRoNllQBXr
 OG7NYJxw9p6O7IBD++kylwHdKoq4ZJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130039

Patch with title "powerpc/fadump: remove old sysfs symlink" removed the
deprecated fadump sysfs. So remove the respective ABI documents.

Additionally remove the reference of old fadump sysfs from fadump
document.

The alternative sysfs is documented at:
Documentation/ABI/testing/sysfs-kernel-fadump

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 .../ABI/obsolete/sysfs-kernel-fadump_enabled  |  9 -----
 .../obsolete/sysfs-kernel-fadump_registered   | 10 ------
 .../obsolete/sysfs-kernel-fadump_release_mem  | 10 ------
 .../arch/powerpc/firmware-assisted-dump.rst   | 33 +++++++------------
 4 files changed, 11 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem

diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled b/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
deleted file mode 100644
index e9c2de8b3688..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
+++ /dev/null
@@ -1,9 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/enabled.
-
-What:		/sys/kernel/fadump_enabled
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	read only
-		Primarily used to identify whether the FADump is enabled in
-		the kernel or not.
-User:		Kdump service
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered b/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
deleted file mode 100644
index dae880b1a5d5..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
+++ /dev/null
@@ -1,10 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/registered.
-
-What:		/sys/kernel/fadump_registered
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	read/write
-		Helps to control the dump collect feature from userspace.
-		Setting 1 to this file enables the system to collect the
-		dump and 0 to disable it.
-User:		Kdump service
diff --git a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem b/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
deleted file mode 100644
index ca2396edb5f1..000000000000
--- a/Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem
+++ /dev/null
@@ -1,10 +0,0 @@
-This ABI is renamed and moved to a new location /sys/kernel/fadump/release_mem.
-
-What:		/sys/kernel/fadump_release_mem
-Date:		Feb 2012
-Contact:	linuxppc-dev@lists.ozlabs.org
-Description:	write only
-		This is a special sysfs file and only available when
-		the system is booted to capture the vmcore using FADump.
-		It is used to release the memory reserved by FADump to
-		save the crash dump.
diff --git a/Documentation/arch/powerpc/firmware-assisted-dump.rst b/Documentation/arch/powerpc/firmware-assisted-dump.rst
index 7e266e749cd5..717e30e8b6cd 100644
--- a/Documentation/arch/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/arch/powerpc/firmware-assisted-dump.rst
@@ -19,9 +19,9 @@ in production use.
 - Unlike phyp dump, userspace tool does not need to refer any sysfs
   interface while reading /proc/vmcore.
 - Unlike phyp dump, FADump allows user to release all the memory reserved
-  for dump, with a single operation of echo 1 > /sys/kernel/fadump_release_mem.
+  for dump, with a single operation of echo 1 > /sys/kernel/fadump/release_mem.
 - Once enabled through kernel boot parameter, FADump can be
-  started/stopped through /sys/kernel/fadump_registered interface (see
+  started/stopped through /sys/kernel/fadump/registered interface (see
   sysfs files section below) and can be easily integrated with kdump
   service start/stop init scripts.
 
@@ -86,13 +86,13 @@ as follows:
    network, nas, san, iscsi, etc. as desired.
 
 -  Once the userspace tool is done saving dump, it will echo
-   '1' to /sys/kernel/fadump_release_mem to release the reserved
+   '1' to /sys/kernel/fadump/release_mem to release the reserved
    memory back to general use, except the memory required for
    next firmware-assisted dump registration.
 
    e.g.::
 
-     # echo 1 > /sys/kernel/fadump_release_mem
+     # echo 1 > /sys/kernel/fadump/release_mem
 
 Please note that the firmware-assisted dump feature
 is only available on POWER6 and above systems on pSeries
@@ -152,7 +152,7 @@ then everything but boot memory size of RAM is reserved during
 early boot (See Fig. 2). This area is released once we finish
 collecting the dump from user land scripts (e.g. kdump scripts)
 that are run. If there is dump data, then the
-/sys/kernel/fadump_release_mem file is created, and the reserved
+/sys/kernel/fadump/release_mem file is created, and the reserved
 memory is held.
 
 If there is no waiting dump data, then only the memory required to
@@ -281,7 +281,7 @@ the control files and debugfs file to display memory reserved region.
 
 Here is the list of files under kernel sysfs:
 
- /sys/kernel/fadump_enabled
+ /sys/kernel/fadump/enabled
     This is used to display the FADump status.
 
     - 0 = FADump is disabled
@@ -290,15 +290,15 @@ Here is the list of files under kernel sysfs:
     This interface can be used by kdump init scripts to identify if
     FADump is enabled in the kernel and act accordingly.
 
- /sys/kernel/fadump_registered
+ /sys/kernel/fadump/registered
     This is used to display the FADump registration status as well
     as to control (start/stop) the FADump registration.
 
     - 0 = FADump is not registered.
     - 1 = FADump is registered and ready to handle system crash.
 
-    To register FADump echo 1 > /sys/kernel/fadump_registered and
-    echo 0 > /sys/kernel/fadump_registered for un-register and stop the
+    To register FADump echo 1 > /sys/kernel/fadump/registered and
+    echo 0 > /sys/kernel/fadump/registered for un-register and stop the
     FADump. Once the FADump is un-registered, the system crash will not
     be handled and vmcore will not be captured. This interface can be
     easily integrated with kdump service start/stop.
@@ -308,13 +308,13 @@ Here is the list of files under kernel sysfs:
    This is used to display the memory reserved by FADump for saving the
    crash dump.
 
- /sys/kernel/fadump_release_mem
+ /sys/kernel/fadump/release_mem
     This file is available only when FADump is active during
     second kernel. This is used to release the reserved memory
     region that are held for saving crash dump. To release the
     reserved memory echo 1 to it::
 
-	echo 1  > /sys/kernel/fadump_release_mem
+	echo 1  > /sys/kernel/fadump/release_mem
 
     After echo 1, the content of the /sys/kernel/debug/powerpc/fadump_region
     file will change to reflect the new memory reservations.
@@ -335,17 +335,6 @@ Note: /sys/kernel/fadump_release_opalcore sysfs has moved to
 
     echo 1  > /sys/firmware/opal/mpipl/release_core
 
-Note: The following FADump sysfs files are deprecated.
-
-+----------------------------------+--------------------------------+
-| Deprecated                       | Alternative                    |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_enabled       | /sys/kernel/fadump/enabled     |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_registered    | /sys/kernel/fadump/registered  |
-+----------------------------------+--------------------------------+
-| /sys/kernel/fadump_release_mem   | /sys/kernel/fadump/release_mem |
-+----------------------------------+--------------------------------+
 
 Here is the list of files under powerpc debugfs:
 (Assuming debugfs is mounted on /sys/kernel/debug directory.)
-- 
2.52.0


