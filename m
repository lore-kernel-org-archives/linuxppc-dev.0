Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60204C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 21:56:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B10920707
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 21:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B10920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Ydgr6zPszDqpH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 May 2020 07:56:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YdV82GMczDql9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2020 07:48:16 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TLWv9o153644; Fri, 29 May 2020 17:47:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31b7x83wtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 17:47:37 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TLZsZh162891;
 Fri, 29 May 2020 17:47:37 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31b7x83wt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 17:47:37 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TLjk9W014307;
 Fri, 29 May 2020 21:47:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 316uf8w6bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 21:47:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TLlVXD7733744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 21:47:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA68EAE04D;
 Fri, 29 May 2020 21:47:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4720AE058;
 Fri, 29 May 2020 21:47:27 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.34.115])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Fri, 29 May 2020 21:47:27 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation);
 Sat, 30 May 2020 03:17:26 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/5] powerpc/papr_scm: Add support for reporting nvdimm
 health
Date: Sat, 30 May 2020 03:17:14 +0530
Message-Id: <20200529214719.223344-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_10:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 cotscore=-2147483648 mlxlogscore=999
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290153
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
Cc: Santosh Sivaraj <santosh@fossix.org>, Steven Rostedt <rostedt@goodmis.org>,
 Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Changes since v8 [1]:

* Updated proposed changes to remove usage of term 'SCM' due to
  ambiguity with 'PMEM' and 'NVDIMM'. [ Dan Williams ]
* Replaced the usage of term 'SCM' with 'PMEM' in most contexts.
  [ Aneesh ]
* Renamed NVDIMM health defines from PAPR_SCM_DIMM_* to PAPR_PMEM_* .
* Updates to various newly introduced identifiers in 'papr_scm.c'
  removing the 'SCM' prefix from their names.
* Renamed NVDIMM_FAMILY_PAPR_SCM to NVDIMM_FAMILY_PAPR
* Renamed PAPR_SCM_PDSM_HEALTH PAPR_PDSM_HEALTH
* Renamed uapi header 'papr_scm_pdsm.h' to 'papr_pdsm.h'.
* Renamed sysfs ABI document from sysfs-bus-papr-scm to
  sysfs-bus-papr-pmem.
* No behavioural changes from v8 [1].

[1] https://lore.kernel.org/linux-nvdimm/20200527041244.37821-1-vaibhav@linux.ibm.com/
---

The PAPR standard[2][4] provides mechanisms to query the health and
performance stats of an NVDIMM via various hcalls as described in
Ref[3].  Until now these stats were never available nor exposed to the
user-space tools like 'ndctl'. This is partly due to PAPR platform not
having support for ACPI and NFIT. Hence 'ndctl' is unable to query and
report the dimm health status and a user had no way to determine the
current health status of a NDVIMM.

To overcome this limitation, this patch-set updates papr_scm kernel
module to query and fetch NVDIMM health stats using hcalls described
in Ref[3].  This health and performance stats are then exposed to
userspace via sysfs and PAPR-NVDIMM-Specific-Methods(PDSM) issued by
libndctl.

These changes coupled with proposed ndtcl changes located at Ref[5]
should provide a way for the user to retrieve NVDIMM health status
using ndtcl.

Below is a sample output using proposed kernel + ndctl for PAPR NVDIMM
in a emulation environment:

 # ndctl list -DH
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"fatal",
      "shutdown_state":"dirty"
    }
  }
]

Dimm health report output on a pseries guest lpar with vPMEM or HMS
based NVDIMMs that are in perfectly healthy conditions:

 # ndctl list -d nmem0 -H
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "shutdown_state":"clean"
    }
  }
]

PAPR NVDIMM-Specific-Methods(PDSM)
==================================

PDSM requests are issued by vendor specific code in libndctl to
execute certain operations or fetch information from NVDIMMS. PDSMs
requests can be sent to papr_scm module via libndctl(userspace) and
libnvdimm (kernel) using the ND_CMD_CALL ioctl command which can be
handled in the dimm control function papr_scm_ndctl(). Current
patchset proposes a single PDSM to retrieve NVDIMM health, defined in
the newly introduced uapi header named 'papr_pdsm.h'. Support for
more PDSMs will be added in future.

Structure of the patch-set
==========================

The patch-set starts with a doc patch documenting details of hcall
H_SCM_HEALTH. Second patch exports kernel symbol seq_buf_printf()
thats used in subsequent patches to generate sysfs attribute content.

Third patch implements support for fetching NVDIMM health information
from PHYP and partially exposing it to user-space via a NVDIMM sysfs
flag.

Fourth patches deal with implementing support for servicing PDSM
commands in papr_scm module.

Finally the last patch implements support for servicing PDSM
'PAPR_PDSM_HEALTH' that returns the NVDIMM health information to
libndctl.

References:
[2] "Power Architecture Platform Reference"
      https://en.wikipedia.org/wiki/Power_Architecture_Platform_Reference
[3] commit 58b278f568f0
     ("powerpc: Provide initial documentation for PAPR hcalls")
[4] "Linux on Power Architecture Platform Reference"
     https://members.openpowerfoundation.org/document/dl/469
[5] https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v9

---

Vaibhav Jain (5):
  powerpc: Document details on H_SCM_HEALTH hcall
  seq_buf: Export seq_buf_printf
  powerpc/papr_scm: Fetch nvdimm health information from PHYP
  ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
  powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  46 ++-
 arch/powerpc/include/uapi/asm/papr_pdsm.h     | 175 +++++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 363 +++++++++++++++++-
 include/uapi/linux/ndctl.h                    |   1 +
 lib/seq_buf.c                                 |   1 +
 6 files changed, 600 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-pmem
 create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h

-- 
2.26.2

