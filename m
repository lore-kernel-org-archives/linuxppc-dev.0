Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8CF61A2AB7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 06:59:41 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A51DA140146
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 06:59:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 21 Mar 2015 05:59:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AFEB23578047
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 06:59:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KJxT9U36503798
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 06:59:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KJx3xa012374
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 06:59:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/2] EEH Error Injection Support for VFIO Devices
Date: Sat, 21 Mar 2015 06:58:43 +1100
Message-Id: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, alex.williamson@redhat.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those two patches are extention to EEH support for VFIO PCI devices,
which allows to inject EEH errors to VFIO PCI devices from userspace
for testing purpose.

Changelog
=========
v2 -> v3:
	* Use offsetofend(), instead of sizeof(struct vfio_eeh_pe_op)
          to calculate argument buffer size.
v1 -> v2:
	* Use EEH_ERR_FUNC_{MIN,MAX} to validate PCI error function.
        * Put additional arguments for error injection to union in
          struct vfio_eeh_pe_op.

Gavin Shan (2):
  powerpc/eeh: Introduce eeh_pe_inject_err()
  drivers/vfio: Support EEH error injection

 Documentation/vfio.txt         | 12 ++++++++++++
 arch/powerpc/include/asm/eeh.h | 26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh.c      | 35 +++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_spapr_eeh.c  | 10 ++++++++++
 include/uapi/linux/vfio.h      | 36 +++++++++++++++++++++++++++++++++++-
 5 files changed, 118 insertions(+), 1 deletion(-)

-- 
1.8.3.2
