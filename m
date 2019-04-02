Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F0C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:17:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216B82075E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216B82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ycqk6lFJzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:17:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ycnf0sgPzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Ycnd4ffTz8x89
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:15:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Ycnd3qF3z9sNB; Wed,  3 Apr 2019 05:15:17 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Ycnc72Zpz9s9y
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 05:15:16 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x32IAQdv023001
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Apr 2019 14:15:14 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbmtktsp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Apr 2019 14:15:13 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Tue, 2 Apr 2019 19:15:12 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Apr 2019 19:15:09 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x32IF8x725165920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Apr 2019 18:15:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4820112072;
 Tue,  2 Apr 2019 18:15:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CA24112062;
 Tue,  2 Apr 2019 18:15:06 +0000 (GMT)
Received: from rino.br.ibm.com (unknown [9.18.235.111])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Apr 2019 18:15:05 +0000 (GMT)
From: Claudio Carvalho <cclaudio@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Enabling secure boot on PowerNV systems
Date: Tue,  2 Apr 2019 15:15:01 -0300
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19040218-0040-0000-0000-000004DB8588
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183359; UDB=6.00619522; IPR=6.00964108; 
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:15:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0041-0000-0000-000008E68616
Message-Id: <20190402181505.25037-1-cclaudio@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-02_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020121
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Nayna Jain <nayna@linux.ibm.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch set is part of a series that implements secure boot on
PowerNV systems.

In order to verify the OS kernel on PowerNV, secure boot requires X.509
certificates trusted by the platform, the secure boot modes, and several
other pieces of information. These are stored in secure variables
controlled by OPAL, also known as OPAL secure variables.

This patch set adds the following features:

1. Enable efivarfs by selecting CONFIG_EFI in the CONFIG_OPAL_SECVAR
   introduced in this patch set. With CONFIG_EFIVAR_FS, userspace tools can
   be used to manage the secure variables.
2. Add support for OPAL secure variables by overwriting the EFI hooks
   (get_variable, get_next_variable, set_variable and query_variable_info)
   with OPAL call wrappers. There is probably a better way to add this
   support, for example, we are investigating if we could register the
   efivar_operations rather than overwriting the EFI hooks. In this patch
   set, CONFIG_OPAL_SECVAR selects CONFIG_EFI. If, instead, we registered
   efivar_operations, CONFIG_EFIVAR_FS would need to depend on
   CONFIG_EFI|| CONFIG_OPAL_SECVAR. Comments or suggestions on the
   preferred technique would be greatly appreciated.
3. Define IMA arch-specific policies based on the secure boot state and
   mode of the system. On secure boot enabled powernv systems, the host OS
   kernel signature will be verified by IMA appraisal.

Claudio Carvalho (2):
  powerpc/include: Override unneeded early ioremap functions
  powerpc/powernv: Add support for OPAL secure variables

Nayna Jain (2):
  powerpc/powernv: Detect the secure boot mode of the system
  powerpc: Add support to initialize ima policy rules

 arch/powerpc/Kconfig                         |  12 ++
 arch/powerpc/include/asm/early_ioremap.h     |  41 +++++
 arch/powerpc/include/asm/opal-api.h          |   6 +-
 arch/powerpc/include/asm/opal.h              |  10 ++
 arch/powerpc/include/asm/secboot.h           |  21 +++
 arch/powerpc/kernel/Makefile                 |   1 +
 arch/powerpc/kernel/ima_arch.c               |  54 ++++++
 arch/powerpc/platforms/Kconfig               |   3 +
 arch/powerpc/platforms/powernv/Kconfig       |   9 +
 arch/powerpc/platforms/powernv/Makefile      |   1 +
 arch/powerpc/platforms/powernv/opal-call.c   |   4 +
 arch/powerpc/platforms/powernv/opal-secvar.c | 179 +++++++++++++++++++
 arch/powerpc/platforms/powernv/secboot.c     |  54 ++++++
 include/linux/ima.h                          |   3 +-
 14 files changed, 396 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/include/asm/early_ioremap.h
 create mode 100644 arch/powerpc/include/asm/secboot.h
 create mode 100644 arch/powerpc/kernel/ima_arch.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-secvar.c
 create mode 100644 arch/powerpc/platforms/powernv/secboot.c

-- 
2.20.1

