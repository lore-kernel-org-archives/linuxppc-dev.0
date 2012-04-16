Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D3FAB6FDB
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 23:01:45 +1000 (EST)
Subject: Re: [PATCH 13/17] KVM: PPC: Allow book3s_hv guests to use SMT
 processor modes
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120416121315.GA26814@bloggs.ozlabs.ibm.com>
Date: Mon, 16 Apr 2012 15:01:40 +0200
Message-Id: <08398386-4467-4A80-8606-2C9CAA44AB10@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
 <20110629102307.GN25406@bloggs.ozlabs.ibm.com>
 <056AF183-5218-457B-9501-B0FF5ED455E9@suse.de>
 <20120416121315.GA26814@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16.04.2012, at 14:13, Paul Mackerras wrote:

> On Mon, Apr 16, 2012 at 11:45:44AM +0200, Alexander Graf wrote:
>=20
>> While trying to trace down why some BookE systems were only able to
>> do as many guest vcpus as there were host cpus available, we
>> stumbled over this one. Is there any limitation on book3s_hv that
>> would limit the available vcpus to configured host vcpus? Or could
>> we just make this a static define like on x86?
>=20
> There is no limitation.  I did it like that so that we would be able
> to have a large number of vcpus on kernels configured for large
> systems, while not using up large amounts of memory if the kernel is
> configured for a small system.  The memory consumption is 8 bytes per
> vcore in each struct kvm if book3s_hv is configured.

8 * 256 =3D 2048. So for a limit similar to that of x86 we'd waste 2kb =
per VM. Doesn't sound all too horrible to me.

> We can make it a fixed constant if you like, but then the question is
> how do you choose that constant so as to allow us to have many vcpus
> on large systems but still not waste too much memory on small systems.
> Or it could be max(N, NR_CPUS) for a suitable N (e.g. 16 or 32).

Hrm. Usually we have 2 machine types:

  1) Small system with very low NR_CPUS. These systems should be able to =
do some overcommit at least. I'd go with a static number here, like 16 =
or 64.
  2) Big systems with very high NR_CPUS. Here going larger than NR_CPUS =
doesn't make all that much sense anymore. I'd use NR_CPUS as limit.

So how about something like

#if NR_CPUS > 64
#define KVM_MAX_VCPUS NR_CPUS
#else
#define KVM_MAX_VCPUS 64
#endif


That way everyone should be happy and we have a reasonable limit.

Alex
