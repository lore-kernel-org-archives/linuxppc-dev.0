Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86F881A0004
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 01:46:52 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 3/6 v2] KVM: PPC: Book3E: Increase FPU laziness
Date: Thu, 3 Jul 2014 15:46:24 +0000
Message-ID: <bf24ca20f84f449a8781107acaec33d1@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-4-git-send-email-mihai.caraman@freescale.com>
 <53B54C8A.1060209@suse.de>
In-Reply-To: <53B54C8A.1060209@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, July 03, 2014 3:29 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/6 v2] KVM: PPC: Book3E: Increase FPU laziness
>=20
>=20
> On 30.06.14 17:34, Mihai Caraman wrote:
> > Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> > returning to guest instead of each sched in. Without this improvement
> > an interrupt may also claim floting point corrupting guest state.
>
> How do you handle context switching with this patch applied? During most
> of the guest's lifetime we never exit kvmppc_vcpu_run(), so when the
> guest gets switched out all FPU state gets lost?

No, we had this discussion in ver 1. The FP/VMX/VSX is implemented lazy in
the kernel i.e. the unit state is not saved/restored until another thread
that once claimed the unit is sched in.

Since FP/VMX/VSX can be activated by the guest independent of the host, the
vcpu thread is always using the unit (even if it did not claimed it once).

Now, this patch optimize the sched in flow. Instead of checking on each vcp=
u
sched in if the kernel unloaded unit's guest state for another competing ho=
st
process we do this when we enter the guest.

-Mike
