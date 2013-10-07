Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08CD22C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:46 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:33 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A1F0A2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmBHP065990
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmMIo024677
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:23 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 00/14] Allow PR and HV KVM to coexist in one kernel
Date: Mon,  7 Oct 2013 22:17:48 +0530
Message-Id: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

This patch series support enabling HV and PR KVM together in the same kernel. We
extend machine property with new property "kvm_type". A value of "HV" will force HV
KVM and "PR" PR KVM. If we don't specify kvm_type we will select the fastest KVM mode.
ie, HV if that is supported otherwise PR.

With Qemu command line having

 -machine pseries,accel=kvm,kvm_type=HV

[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]# modprobe kvm-pr
[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]# modprobe  kvm-hv
[root@llmp24l02 qemu]# bash ../qemu

now with

 -machine pseries,accel=kvm,kvm_type=PR

[root@llmp24l02 qemu]# rmmod kvm-pr
[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]#
[root@llmp24l02 qemu]# modprobe kvm-pr
[root@llmp24l02 qemu]# bash ../qemu

Changes from V1:
* Build fixes for BOOKE (only compile tested)
* Address review feedback

-aneesh
