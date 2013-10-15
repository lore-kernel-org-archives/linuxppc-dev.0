Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 650DB2C014D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 20:00:31 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 14:30:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D0DB8394005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 14:30:04 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9F9347t43385006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 14:33:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9F90MUj009637
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 14:30:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH -V2 00/14] Allow PR and HV KVM to coexist in one kernel
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 15 Oct 2013 14:30:22 +0530
Message-ID: <87txgizz6h.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Alex,

Any update on this ?

-aneesh

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Hi All,
>
> This patch series support enabling HV and PR KVM together in the same kernel. We
> extend machine property with new property "kvm_type". A value of "HV" will force HV
> KVM and "PR" PR KVM. If we don't specify kvm_type we will select the fastest KVM mode.
> ie, HV if that is supported otherwise PR.
>
> With Qemu command line having
>
>  -machine pseries,accel=kvm,kvm_type=HV
>
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]# modprobe kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]# modprobe  kvm-hv
> [root@llmp24l02 qemu]# bash ../qemu
>
> now with
>
>  -machine pseries,accel=kvm,kvm_type=PR
>
> [root@llmp24l02 qemu]# rmmod kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]#
> [root@llmp24l02 qemu]# modprobe kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
>
> Changes from V1:
> * Build fixes for BOOKE (only compile tested)
> * Address review feedback
>
> -aneesh
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
