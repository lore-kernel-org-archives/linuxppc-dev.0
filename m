Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699EDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:38:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E693D2075A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E693D2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TqB0CvmzDqRn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:37:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Tcr1GYfzDqWv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:28:59 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOAV4055254
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:55 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtd9eh34v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:28:54 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:28:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSlJp31588354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 562D84C04A;
 Fri, 22 Feb 2019 11:28:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BC394C040;
 Fri, 22 Feb 2019 11:28:47 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:47 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 4E5BA22026B; Fri, 22 Feb 2019 12:28:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 00/16] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Date: Fri, 22 Feb 2019 12:28:24 +0100
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0008-0000-0000-000002C39B4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0009-0000-0000-0000222FD9E2
Message-Id: <20190222112840.25000-1-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=831 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220081
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
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On the POWER9 processor, the XIVE interrupt controller can control
interrupt sources using MMIOs to trigger events, to EOI or to turn off
the sources. Priority management and interrupt acknowledgment is also
controlled by MMIO in the CPU presenter subengine.

PowerNV/baremetal Linux runs natively under XIVE but sPAPR guests need
special support from the hypervisor to do the same. This is called the
XIVE native exploitation mode and today, it can be activated under the
PowerPC Hypervisor, pHyp. However, Linux/KVM lacks XIVE native support
and still offers the old interrupt mode interface using a KVM device
implementing the XICS hcalls over XIVE.

The following series is proposal to add the same support under KVM.

A new KVM device is introduced for the XIVE native exploitation
mode. It reuses most of the XICS-over-XIVE glue implementation
structures which are internal to KVM but has a completely different
interface. A set of KVM device ioctls provide support for the
hypervisor calls, all handled in QEMU, to configure the sources and
the event queues. From there, all interrupt control is transferred to
the guest which can use MMIOs.

These MMIO regions (ESB and TIMA) are exposed to guests in QEMU,
similarly to VFIO, and the associated VMAs are populated dynamically
with the appropriate pages using a fault handler. These are now
implemented using mmap()s of the KVM device fd.

Migration has its own specific needs regarding memory. The patchset
provides a specific control to quiesce XIVE before capturing the
memory. The save and restore of the internal state is based on the
same ioctls used for the hcalls.

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with a
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode. Which means that the KVM interrupt
device should be created at runtime, after the machine has started.
This requires extra support from KVM to destroy KVM devices. It is
introduced at the end of the patcshet as it still requires some
attention and a XIVE-only VM would not need.

This is 5.2 material. I expect a couple of respin for fixes, and the
OPAL patches have not yet been merged.


GitHub trees available here :
 
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-next
  
Linux/KVM:

  https://github.com/legoater/linux/commits/xive-5.0

OPAL:

  https://github.com/legoater/skiboot/commits/xive


Thanks,

C.

Changes since v1:

 - Better documentation (was missing)
 - Nested support. XIVE not advertised on non PowerNV platforms. This
   is a good way to test the fallback on QEMU emulated devices.
 - ESB and TIMA special mapping done using the KVM device fd
 - All hcalls moved to QEMU. Dropped the patch moving the hcall flags.
 - Reworked of the KVM device ioctl controls to support hcalls and
   migration needs to capture/save states
 - Merged the control syncing XIVE and marking the EQ page dirty
 - Fixed passthrough support using the KVM device file address_space
   to clear the ESB pages from the mapping
 - Misc enhancements and fixes 

Cédric Le Goater (16):
  powerpc/xive: add OPAL extensions for the XIVE native exploitation
    support
  KVM: PPC: Book3S HV: add a new KVM device for the XIVE native
    exploitation mode
  KVM: PPC: Book3S HV: XIVE: introduce a new capability
    KVM_CAP_PPC_IRQ_XIVE
  KVM: PPC: Book3S HV: XIVE: add a control to initialize a source
  KVM: PPC: Book3S HV: XIVE: add a control to configure a source
  KVM: PPC: Book3S HV: XIVE: add controls for the EQ configuration
  KVM: PPC: Book3S HV: XIVE: add a global reset control
  KVM: PPC: Book3S HV: XIVE: add a control to sync the sources
  KVM: PPC: Book3S HV: XIVE: add a control to dirty the XIVE EQ pages
  KVM: PPC: Book3S HV: XIVE: add get/set accessors for the VP XIVE state
  KVM: introduce a 'mmap' method for KVM devices
  KVM: PPC: Book3S HV: XIVE: add a TIMA mapping
  KVM: PPC: Book3S HV: XIVE: add a mapping for the source ESB pages
  KVM: PPC: Book3S HV: XIVE: add passthrough support
  KVM: introduce a KVM_DESTROY_DEVICE ioctl
  KVM: PPC: Book3S HV: XIVE: clear the vCPU interrupt presenters

 arch/powerpc/include/asm/kvm_host.h           |    2 +
 arch/powerpc/include/asm/kvm_ppc.h            |   32 +
 arch/powerpc/include/asm/opal-api.h           |   11 +-
 arch/powerpc/include/asm/opal.h               |    7 +
 arch/powerpc/include/asm/xive.h               |   17 +
 arch/powerpc/include/uapi/asm/kvm.h           |   48 +
 arch/powerpc/kvm/book3s_xive.h                |   31 +
 include/linux/kvm_host.h                      |    1 +
 include/uapi/linux/kvm.h                      |   10 +
 arch/powerpc/kvm/book3s.c                     |   31 +-
 arch/powerpc/kvm/book3s_xics.c                |   19 +
 arch/powerpc/kvm/book3s_xive.c                |  149 ++-
 arch/powerpc/kvm/book3s_xive_native.c         | 1171 +++++++++++++++++
 arch/powerpc/kvm/powerpc.c                    |   33 +
 arch/powerpc/sysdev/xive/native.c             |  110 ++
 virt/kvm/kvm_main.c                           |   49 +
 Documentation/virtual/kvm/api.txt             |   28 +
 Documentation/virtual/kvm/devices/xive.txt    |  190 +++
 arch/powerpc/kvm/Makefile                     |    2 +-
 .../powerpc/platforms/powernv/opal-wrappers.S |    3 +
 20 files changed, 1896 insertions(+), 48 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
 create mode 100644 Documentation/virtual/kvm/devices/xive.txt

-- 
2.20.1

