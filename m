Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E13606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n/GkPa/t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ8zX3RFmz2yKn;
	Thu, 12 Nov 2026 17:06:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794463608;
	cv=none; b=MDKO8NtD12uWDJn5QsxLytOdq80j/yqGvPJB+d6rt9N6ghDopBq8Faj3L4LFs1RbJSOwgDieX+FIz3EbOYFCAxwliuZBB0oBry8keOrCvQpkXmpHdS5t30RX6D4AGhpwZM56fDvKJMv5D3CjyA+5E3ubLObCPPImdW/dIGBPzx9M+2blSkDfhGY91HE4SFI2equF7OteT+H2WMOqMk5sticxbx869fju8JuENusgoNihEno6nQprU1Ea6Q1EFVLLdT/Kkv+ozVPJzlziolvo9Sqs5YnQfGHRZ4ff1Bm1EJNfyFI8kOipllQX4LhqeabnBEahPh/bJ1QAt19LaVaumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794463608; c=relaxed/relaxed;
	bh=ISTKPlrhU90UkBMn1+nIifs9OVjpnasWZN/BkeSsoco=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=Td3+QFxfJWDuz2KDR4vs2dFJ7UYn2fyA4gikOYPUTDmUBz2VFgPmrvXy5IGSc2H+3PLt3Ratv5SaDMJZYnbwiNPSgr4zMwBw/3Oxay/5HlFMbh4yf+IOwP3yz6DrQQXOEz2OHWXYFRko+DDa+wCKD/lQnLlgGHUy3zF5XFxC/GR/qNwK0v2lugSwprNU3RyNO8pYgKu6J9+v4gwxrlH4u9utatu1rBCS0V2uKsxffgphdLVj+hcd58FW3CPdKOFx0aS/0xS7rkxAn2kMSctmolSFnyR4TrXjseJOO6mtPcdsGRhDQKQIaSv281r8s5pOMIqq8lJ2gbwhAuSsYbSyUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n/GkPa/t; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n/GkPa/t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ8zW3vqNz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 17:06:47 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iYUo3054106;
	Thu, 12 Nov 2026 06:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ISTKPlrhU90UkBMn1+nIifs9OVjp
	nasWZN/BkeSsoco=; b=n/GkPa/trXpk/R+ADlSs+inV46MWuj/rs0M77nGq3M+s
	tobFMRNpLAoLe4y8NO+CcTRl0ahkAhpAv3uuxHMpv7S3ktxqjsLu1jvPNILkfS2p
	LXv9uVarE2SCWwpxjjNxE1QWNW0ahxvX/tKKOiw1WGgnmPBBr6Vkwva+QCrM2Crx
	w8P00FdvJ1+ivDDxlD1mSCCf0wiZEUAnKZOtk26ak75MBKif5mhCQUg1JTm0cFth
	4i7JsRj8GDO8SgoAAPMzjVukoa5URN8WylM+bHyihMzmkVwWXM7rm5EqFILpAKwj
	riH1tN+Zt8kyXBNysccJjXIqKoG62+OoC8oeohTlcQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6e1nc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:06:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zp7C3145807;
	Thu, 12 Nov 2026 06:06:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51w85s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:06:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC66erD20120146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 06:06:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F275808C;
	Thu, 12 Nov 2026 06:06:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 097E05808A;
	Thu, 12 Nov 2026 06:06:38 +0000 (GMT)
Received: from [9.61.240.49] (unknown [9.61.240.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 06:06:37 +0000 (GMT)
Message-ID: <9113e399-ddd0-405e-9abb-69a9785c726c@linux.ibm.com>
Date: Thu, 12 Nov 2026 11:36:36 +0530
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
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, nandinih@linux.ibm.com
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [BUG] selftests/powerpc/eeh: eeh-basic breaks the device hosting
 rootfs, ext4 goes read-only and the test harness crashes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A3_HtWYE6Ku8fQ2fUvbT0UfzBkbNWASC
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af55772 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=x-2Afh13tHfaC_x_YBQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A3_HtWYE6Ku8fQ2fUvbT0UfzBkbNWASC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyMiBTYWx0ZWRfX0mHLmusLHpj0
 0BsCtNMo8528XSSx6XhvnbCkP/qJ3O5UBWeLHZZsgdkJYGqUpmTzBXYk5LRFLnJsn1MttXh/8RD
 26NA+Qm1Pk8UN9mJSKu/OLtbPJCYqJgo6c0EL9XUSivYCowtnd7Q2H3NFU7tR6WbYpsa+1li3I+
 DeIJRHyJ68SoX7L1xkXr7hTw5J5zlNMWioaOHbYI2ZfmPNqfRZUNJ+khbA2XO9t9H2EE/bHRSw0
 qS/GEVpLJMEOXMIKXS7iIOwJTN7TTSrIVuyjUMZu8t9+oi4pqeQceY5pOpEBrhKgzyin0T1aLR9
 zF3RfbjICwvc5VuCcyIU1VsKvgDVWvvwuONzkF8uH3TOAnKUh7h3LzsDSGQGfWodJnRuHJy/Zx5
 +lUYQoHFW6277PkbeZcwRlFSaPP4S3AEQmlKfErc89SVgZ3LrHJXidkrE03EBrpYSAxeLWxp6Te
 AIH8kNFmhbtpLb8RE8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyMiBTYWx0ZWRfX6ybRK3EAU94v
 8pGPAJ4laTjYxs0lNSsz7E7c3A0oia2OGoCj25wpuVE/t4HMJCA+lMLb8qvMG5iuFTzXE8GTb1+
 K6QS7dGLcJFKQ6Wop1SNrnTvW/HJoF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120022
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello!!!

IBM CI has hit a failure that takes down the test harness, While running 
the powerpc EEH selftest on a bare-metal POWER system.

The selftest injects an error into the PCI device that hosts the root 
filesystem. The filesystem goes read-only and the run dies.

[ 1112.079091] EEH: Frozen PHB#3-PE#1fd detected
[ 1112.079905] aacraid 0003:01:00.0: aacraid: PCI error detected 2
[ 1112.140830] I/O error, dev sdb, sector 3906906472 op 0x1:(WRITE) ...
[ 1112.140957] Aborting journal on device sdb2-8.
[ 1112.140977] EXT4-fs error (device sdb2) in ext4_dirty_inode:7656: IO 
failure
[ 1112.176664] EXT4-fs error (device sdb2): ext4_journal_check_start:98: 
... Detected aborted journal
[ 1187.736385] aacraid 0003:01:00.0: aacraid: PCI error - slot reset
[ 1217.244306] EXT4-fs (sdb2): Remounting filesystem read-only
[ 1220.583495] aacraid 0003:01:00.0: aacraid: PCI error - resume

We need to make appropriate changes to selftest, so that it skips the 
adapter, if rootfs is hosted on it.


SetUp:

System: IBM 9006-22C (POWER9), PowerNV, bare metal
Firmware: skiboot-v6.8-45-g8246de863
Kernel: 7.4.0-rc2+, upstream master at 067c5c24cef2 ("Merge tag 
'page_alloc-for-7.4-rc2'", 2026-11-10)


Issue1: Selftest should skip the adapter that host the rootfs

eeh_can_break() already skips ahci, for similar reason, but has no check 
for a device that backs /. A friendly LLM has suggested

below change, which I tested and it works.

0003:01:00.0, Skipped: hosts the root filesystem

Other adapters are tested as before and the run completes

diff --git a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh 
b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
index 70daa3925dcb..f9db1f9be05a 100644
--- a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
+++ b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
@@ -62,6 +62,42 @@ eeh_test_prep() {
      echo 5000 > /sys/kernel/debug/powerpc/eeh_max_freezes
  }

+# Print the resolved sysfs path of a block device followed by the paths of
+# every device stacked underneath it (dm, md, etc).
+eeh_blk_sysfs_paths() {
+    local sys="$1"
+    local s
+
+    realpath "$sys"
+    for s in "$sys"/slaves/* ; do
+        if [ -e "$s" ] ; then
+            eeh_blk_sysfs_paths "$s"
+        fi
+    done
+}
+
+# Succeeds if the root filesystem lives on a disk behind any function 
of the
+# slot containing the given PCI device.
+eeh_hosts_rootfs() {
+    local slot="${1%.*}"
+    local majmin src sys
+
+    # Use the last "/" entry so an initramfs rootfs entry is ignored.
+    majmin="$(awk '$5 == "/" { mm = $3 } END { print mm }' 
/proc/self/mountinfo)"
+    src="$(awk '$5 == "/" { for (i = 6; i < NF; i++) if ($i == "-") s = 
$(i + 2) } END { print s }' /proc/self/mountinfo)"
+
+    if [ -e "/sys/dev/block/$majmin" ] ; then
+        sys="/sys/dev/block/$majmin"
+    elif [ -b "$src" ] ; then
+        # e.g. btrfs reports an anonymous major:minor
+        sys="/sys/class/block/$(basename "$(realpath "$src")")"
+    else
+        return 1
+    fi
+
+    eeh_blk_sysfs_paths "$sys" 2>/dev/null | grep -q "/${slot}\.[0-7]/"
+}
+
  eeh_can_break() {
      # skip bridges since we can't recover them (yet...)
      if [ -e "/sys/bus/pci/devices/$dev/pci_bus" ] ; then
@@ -78,6 +114,14 @@ eeh_can_break() {
          return 1;
      fi

+    # Breaking the device that hosts the root filesystem makes I/O fail
+    # during recovery, which can abort the journal and leave / read-only
+    # (and kill the test harness). Leave it alone.
+    if eeh_hosts_rootfs "$1" ; then
+        log "$1, Skipped: hosts the root filesystem"
+        return 1;
+    fi
+
      # Don't inject errosr into an already-frozen PE. This happens with
      # PEs that contain multiple PCI devices (e.g. multi-function cards)
      # and injecting new errors during the recovery process will probably



Issue2: Some adapters take longer time to recover.


Once the rootfs device was skipped, the run completed, but with the 
default 60 s wait three adapters were reported as Failed to recover!,
and the summary was 3 devices failed to recover (6 tested). Checking the 
PE state afterwards showed them healthy .
I re-ran with EEH_MAX_WAIT=240, and all of them recovered:

Result with the 240 s limit: 0 devices failed to recover (6 tested).

BRCM/Mellonox/Intel Adapters took 78s/77s/75s respectively to recover. 
So I think its better to increase default timeout to 120s.

diff --git a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh 
b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
index 70daa3925dcb..1f1d1c8d73bc 100644
--- a/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
+++ b/tools/testing/selftests/powerpc/eeh/eeh-functions.sh
@@ -110,13 +110,13 @@ eeh_one_dev() {
      # is a no-op.
      echo $dev >/sys/kernel/debug/powerpc/eeh_dev_check

-    # Default to a 60s timeout when waiting for a device to recover. This
+    # Default to a 120s timeout when waiting for a device to recover. This
      # is an arbitrary default which can be overridden by setting the
      # EEH_MAX_WAIT environmental variable when required.

      # The current record holder for longest recovery time is:
-    #  "Adaptec Series 8 12G SAS/PCIe 3" at 39 seconds
-    max_wait=${EEH_MAX_WAIT:=60}
+    #  "Broadcom / LSI SAS3008" at 78 seconds
+    max_wait=${EEH_MAX_WAIT:=120}

      for i in `seq 0 ${max_wait}` ; do
          if pe_ok $dev ; then


Please let me know, if the fix for the two issues are good enough, I can 
send a formal patch.



Regards,

Venkat.


