Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A6C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Sep 2021 09:51:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE8360E76
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Sep 2021 09:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAE8360E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H33Yt3whHz305Q
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Sep 2021 19:50:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDYzukSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=schnelle@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=LDYzukSG; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H33XK3kvgz2xYP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Sep 2021 19:49:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1869XqG6185300; Mon, 6 Sep 2021 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=mL/GzH4RAAcMJrNvaUrV6lLx5ELqpfKo77yKneuq9lw=;
 b=LDYzukSGuWeYvbeegTOOSk3lF2ob4D8nJPJ+w2WK7Tb8VHFT7Xb4KjcBn1cxEp3w6hRZ
 Csp0EZEMPd/NJMiFkY00o42l0jdQ6IAgVSgAESzoDYjYlp6tAhhgsDnTucz90WNO1NEx
 waULL18rP3xW2TZVRukkTaeNrbmXdvc6nDLMd3N8tBaF4xNLCbYKp4CNdV+3xnkxJJL9
 Les36erPvN/HisqohHskjd1xNd98wpApUk4obq7PoJypm+YWtjQ4qP4U9BdacMqjfexy
 azHoxfmPIzUeiWDJ45Ku3QEl5pmUwb1LNrg6X68bL3NcPzGYwNL0MfQ8tkeQpKYEwCUN 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3awfyps2b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Sep 2021 05:49:34 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1869ZJxh194765;
 Mon, 6 Sep 2021 05:49:34 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3awfyps2ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Sep 2021 05:49:33 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1869lcke009204;
 Mon, 6 Sep 2021 09:49:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06fra.de.ibm.com with ESMTP id 3av02j1ac1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Sep 2021 09:49:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1869nSpt50004366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Sep 2021 09:49:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BB274204C;
 Mon,  6 Sep 2021 09:49:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 966934203F;
 Mon,  6 Sep 2021 09:49:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  6 Sep 2021 09:49:27 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] s390/pci: automatic error recovery
Date: Mon,  6 Sep 2021 11:49:22 +0200
Message-Id: <20210906094927.524106-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tsJwm8K_m6A98Iumm7OBgbKXZVXaXQS6
X-Proofpoint-ORIG-GUID: j2hSATKklt1Db1jQe4-LZQ4gydQFNg3r
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-09-06_05:2021-09-03,
 2021-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060058
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
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, Linas Vepstas <linasvepstas@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

This series implements automatic error recovery for PCI devices on s390
following the scheme outlined at Documentation/PCI/pci-error-recovery.rst
it applies on top of currenct master.

The patches have are almost completely s390 specific except for two patches
exporting existing functionality for use by arch/s390/pci/ code. Nevertheless
I would also appreciate any feedback, especially on the last patch, concerning
the implementation of the error recovery flow. I believe we might be the first
implementation of PCI device recovery in a virtualized setting requiring us to
coordinate the device reset with the hypervisor platform by issuing a disable
and re-enable to the platform as well as starting the recovery following
a platform event.

The outline of the patches is as follows:

Patch 1 and 2 add s390 specific code implementing a reset mechanism that
takes the PCI function out of the platform specific error state.

Patches 3 and 4 export existing common code functions for use by the s390
specific recovery code.

Patch 3 I already sent separately resulting in the discussion below but without
a final conclusion.

https://lore.kernel.org/lkml/20210720150145.640727-1-schnelle@linux.ibm.com/

I believe even though there were some doubts about the use of
pci_dev_is_added() by arch code the existing uses as well as the use in the
final patch of this series warrant this export.

Patch 4 "PCI: Export pci_dev_lock()" is basically an extension to commit
e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()") which
already exported pci_dev_trylock(). In the final patch we make use of
pci_dev_lock() to wait for any other exclusive uses of the pdev to be finished
before starting recovery.

Finally Patch 5 implements the recovery flow as part of the existing s390
specific PCI availability and error event mechanism. Where previously the error
case only set an error indication requiring manual intervention to make the
device usable again. Now we handle the case where firmware has already reset
a PCI function after an error was encountered informing the OS that it should
be ready to be used again. Note that the same event is also issued by the
hypervisor if the function was manually taken into a service mode for example
for firmware upgrade via the hypervisor and is now ready to be used again.

Thanks,
Niklas Schnelle

Niklas Schnelle (5):
  s390/pci: refresh function handle in iomap
  s390/pci: implement reset_slot for hotplug slot
  PCI: Move pci_dev_is/assign_added() to pci.h
  PCI: Export pci_dev_lock()
  s390/pci: implement minimal PCI error recovery

 arch/powerpc/platforms/powernv/pci-sriov.c |   3 -
 arch/powerpc/platforms/pseries/setup.c     |   1 -
 arch/s390/include/asm/pci.h                |   6 +-
 arch/s390/pci/pci.c                        | 143 ++++++++++++++-
 arch/s390/pci/pci_event.c                  | 196 ++++++++++++++++++++-
 arch/s390/pci/pci_insn.c                   |   4 +-
 arch/s390/pci/pci_irq.c                    |   9 +
 arch/s390/pci/pci_sysfs.c                  |   2 -
 drivers/pci/hotplug/acpiphp_glue.c         |   1 -
 drivers/pci/hotplug/s390_pci_hpc.c         |  24 +++
 drivers/pci/pci.c                          |   3 +-
 drivers/pci/pci.h                          |  15 --
 include/linux/pci.h                        |  16 ++
 13 files changed, 389 insertions(+), 34 deletions(-)

-- 
2.25.1

