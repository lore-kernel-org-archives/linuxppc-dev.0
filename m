Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0694C2C0345
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:04:10 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:34:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E5EEFE005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:35:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RA3xQ540370208
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RA41cH019989
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:34:02 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
Date: Fri, 27 Sep 2013 15:33:42 +0530
Message-Id: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
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
extend machine property with new property "kvm_type". A value of 1 will force HV
KVM and 2 PR KVM. The default value is 0 which will select the fastest KVM mode.
ie, HV if that is supported otherwise PR.

With Qemu command line having

 -machine pseries,accel=kvm,kvm_type=1

[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]# modprobe kvm-pr
[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]# modprobe  kvm-hv
[root@llmp24l02 qemu]# bash ../qemu

now with

 -machine pseries,accel=kvm,kvm_type=2

[root@llmp24l02 qemu]# rmmod kvm-pr
[root@llmp24l02 qemu]# bash ../qemu
failed to initialize KVM: Invalid argument
[root@llmp24l02 qemu]#
[root@llmp24l02 qemu]# modprobe kvm-pr
[root@llmp24l02 qemu]# bash ../qemu

if don't specify kvm_type machine property, it will take a default value 0,
which means fastest supported.

-aneesh
