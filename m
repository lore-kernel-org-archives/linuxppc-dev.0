Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6yv45NhSzDr3G
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 14:29:52 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v953TbL8064636
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 23:29:50 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dd5p72tae-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 23:29:50 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 5 Oct 2017 13:29:48 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v953TjBt42991834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Oct 2017 14:29:45 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v953Ti6j030482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Oct 2017 14:29:44 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
In-Reply-To: <20171003065858.GL3260@umbus.fritz.box>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
 <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
 <20171003065858.GL3260@umbus.fritz.box>
Date: Thu, 05 Oct 2017 08:59:40 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87infui863.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Oct 03, 2017 at 08:24:07AM +0200, C=C3=A9dric Le Goater wrote:
>> On 10/03/2017 05:36 AM, David Gibson wrote:
>> > On Mon, Oct 02, 2017 at 06:27:20PM +0200, C=C3=A9dric Le Goater wrote:
>> >> On 09/23/2017 10:26 AM, C=C3=A9dric Le Goater wrote:
>> >>> Hi,
>> >>>
>> >>> Here are a couple of small fixes to support CPU hot unplug. There are
>> >>> still some issues to be investigated as, in some occasions, after a
>> >>> couple of plug and unplug, the cpu which was removed receives a 'los=
t'
>> >>> interrupt. This showed to be the decrementer under QEMU.
>> >>
>> >> So this seems to be a QEMU issue only which can be solved by=20
>> >> removing the DEE bit from the LPCR on P9 processor when the CPU=20
>> >> is stopped in rtas. PECE3 bit on P8 processors.=20
>> >>
>> >> I think these patches are valuable fixes for 4.14. The first=20
>> >> is trivial and the second touches the common xive part but it
>> >> is only called on the pseries platform.=20=20
>> >>
>> >> Could you please take a look ?
>> >=20
>> > Sorry, I think I've missed something here.
>> >=20
>> > Is there a qemu bug involved in this?  Has there been a patch sent
>> > that I didn't spot?
>>=20
>>=20
>> No, not yet, but I will today probably. something like below to stop
>> the decrementer when a CPU is stopped:
>>=20
>> 	--- qemu.git.orig/hw/ppc/spapr_rtas.c
>> 	+++ qemu.git/hw/ppc/spapr_rtas.c
>> 	@@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *c
>> 	         kvm_cpu_synchronize_state(cs);
>>=20=09=20
>> 	         env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
>> 	+
>> 	+        /* Enable DECR interrupt */
>> 	+        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>> 	+            env->spr[SPR_LPCR] |=3D LPCR_DEE;
>> 	+        } else {
>> 	+            /* P7 and P8 both have same bit for DECR */
>> 	+            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
>> 	+        }
>> 	+
>> 	         env->nip =3D start;
>> 	         env->gpr[3] =3D r3;
>> 	         cs->halted =3D 0;
>> 	@@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *c
>> 	      * no need to bother with specific bits, we just clear it.
>> 	      */
>> 	     env->msr =3D 0;
>> 	+
>> 	+    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>> 	+        env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
>> 	+    } else {
>> 	+        /* P7 and P8 both have same bit for DECR */
>> 	+        env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
>> 	+    }
>> 	 }
>>=20=09=20
>> 	 static inline int sysparm_st(target_ulong addr, target_ulong len,
>>=20=09
>> I haven't yet because I fail to understand why the decrementer is not=20
>> interrupting the dying CPU under xics as it is the case under XIVE.
>
> Oh.. ok.  This sounds very similar to the problem Nikunj hit under TCG
> with decrementer interrupts waking up a supposedly dead CPU.  He had a
> couple of proposed fixes, but we got bogged down trying to work out
> why  (with TCG at least).

Yeah, I wasnt able to get to the exact reason for that.

Regards
Nikunj
