Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K8dZ3wvwzDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 15:24:34 +1000 (AEST)
Message-ID: <1b3db7935304e6c468365562e127821306d3c7b2.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: Fix userspace r13 corruption
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 25 Sep 2018 15:24:33 +1000
In-Reply-To: <2675a034-288e-a3c2-a5df-7a223d79dc88@debian.org>
References: <20180924072704.6200-1-mikey@neuling.org>
 <2675a034-288e-a3c2-a5df-7a223d79dc88@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-24 at 11:32 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/24/2018 04:27 AM, Michael Neuling wrote:
> > When we treclaim we store the userspace checkpointed r13 to a scratch
> > SPR and then later save the scratch SPR to the user thread struct.
> >=20
> > Unfortunately, this doesn't work as accessing the user thread struct
> > can take an SLB fault and the SLB fault handler will write the same
> > scratch SPRG that now contains the userspace r13.
> >=20
> > To fix this, we store r13 to the kernel stack (which can't fault)
> > before we access the user thread struct.
> >=20
> > Found by running P8 guest + powervm + disable_1tb_segments + TM. Seen
> > as a random userspace segfault with r13 looking like a kernel address.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> Reviewed-by: Breno Leitao <leitao@debian.org>
>=20
> I am wondering if the same problem could not happen with r1 as well, sinc=
e r1
> is kept in the paca->tm_scratch after MSR[RI] is enabled, in a code simil=
ar
> to this:
>=20
>         std     r1, PACATMSCRATCH(r13)
> 	..
>         li      r11, MSR_RI
> 	mtmsrd  r11, 1
> 	....
>         ld      r3, PACATMSCRATCH(r13)          /* user r1 */
>         std     r3, GPR1(r7)
>=20
> There might be a corruption if the exception that is raised just after
> MSR[RI] is enabled somehow exits through 'fast_exception_return' (being
> called by most of the exception handlers as I understand) which will
> overwrite paca->tm_scratch with the upcoming MSR (aka SRR1) just before t=
he
> SRR1, as:
>=20
> 	ld      r3,_MSR(r1)
>=20
> 	...
> 	std     r3, PACATMSCRATCH(r13) /* Stash returned-to MSR */
>=20
>=20
> It seems that slb_miss_common and instruction_access_slb does not go thro=
ugh
> this path, but handle_page_fault calls
> ret_from_except_lite->fast_exception_return, which might cause this
> 'possible' issue.

Yeah, good catch! I think we are ok but it's delicate.=20

I'll store it in the kernel stack and avoid PACATMSCRATCH before I turn RI =
on. =20

This look ok?

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 701b0f5b09..ff781b2852 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -178,6 +178,12 @@ _GLOBAL(tm_reclaim)
=20
 	std	r11, GPR11(r1)			/* Temporary stash */
=20
+	/* Move r1 to kernel stack in case PACATMSCRATCH is used once
+	 * we turn on RI
+	 */
+	ld	r11, PACATMSCRATCH(r13)
+	std	r11, GPR1(r1)
+
 	/* Store r13 away so we can free up the scratch SPR for the
 	 * SLB fault handler (needed once we start access the
 	 * thread_struct)
@@ -214,7 +220,7 @@ _GLOBAL(tm_reclaim)
 	SAVE_GPR(8, r7)				/* user r8 */
 	SAVE_GPR(9, r7)				/* user r9 */
 	SAVE_GPR(10, r7)			/* user r10 */
-	ld	r3, PACATMSCRATCH(r13)		/* user r1 */
+	ld	r3, GPR1(r1)			/* user r1 */
 	ld	r4, GPR7(r1)			/* user r7 */
 	ld	r5, GPR11(r1)			/* user r11 */
 	ld	r6, GPR12(r1)			/* user r12 */
