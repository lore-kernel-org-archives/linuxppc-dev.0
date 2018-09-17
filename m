Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DF2J4RXwzF12l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 15:25:28 +1000 (AEST)
Message-ID: <b1ed898835f2e0805088d215e8afb193a7c4768c.camel@neuling.org>
Subject: Re: [RFC PATCH 00/11] New TM Model
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com, Cyril Bur <cyrilbur@gmail.com>
Date: Mon, 17 Sep 2018 15:25:28 +1000
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
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

On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> This patchset for the hardware transactional memory (TM) subsystem aims t=
o
> avoid spending a lot of time on TM suspended mode in kernel space. It
> basically
> changes where the reclaim/recheckpoint will be executed.
>=20
> Once a CPU enters in transactional state it uses a footprint area to trac=
k
> down the load/stores performed in transaction so it can be verified later
> to decide if a conflict happened due to some change done in that state. I=
f
> a transaction is active in userspace and there is an exception that takes
> the CPU to the kernel space the CPU moves the transaction to suspended
> state but does not discard the footprint area.

In this description, you should differente between memory and register
(GPR/VSX/SPR) footprints.

In suspend, the CPU can disregard the memory footprint at any point, but it=
 has
to keep the register footprint. =20

In the above paragraph you are talking about register footprint but not mem=
ory
footprint.=20

>=20
> POWER9 has a known problem[1][2] and does not have enough room in
> footprint area for several transactions to be suspended at the same time
> on concurrent CPUs leading to CPU stalls.
>=20
> This patchset aims to reclaim the checkpointed footprint as soon as the
> kernel is invoked, in the beginning of the exception handlers, thus freei=
ng
> room to other CPUs enter in suspended mode, avoiding too many CPUs in
> suspended
> state that can cause the CPUs to stall. The same mechanism is done on ker=
nel
> exit, doing a recheckpoint as late as possible (which will reload the
> checkpointed state into CPU's room) at the exception return.

OK, but we are still potentially in suspend in userspace, so that doesn't h=
elp
us on the lockup issue.

We need fake suspend in userspace to prevent lockups.

> The way to achieve this goal is creating a macro (TM_KERNEL_ENTRY) which
> will check if userspace was in an active transaction just after getting
> into kernel and reclaiming if that's the case. Thus all exception handler=
s
> will call this macro as soon as possible.
>=20
> All exceptions should reclaim (if necessary) at this stage and only
> recheckpoint if the task is tagged as TIF_RESTORE_TM (i.e. was in
> transactional state before being interrupted), which will be done at
> ret_from_except_lite().
>=20
> Ideally all reclaims will happen at the exception entrance, however durin=
g
> the recheckpoint process another exception can hit the CPU which might
> cause the current thread to be rescheduled, thus there is another reclaim
> point to be considered at __switch_to().

Can we do the recheckpoint() later so that it's when we have interrupts off=
 and
can't be rescheduled?

> Hence, by allowing the CPU to be in suspended state for only a brief peri=
od
> it's possible to cope with the TM hardware limitations like the current
> problem on the new POWER9.

As mentioned, since we're still running userspace with real suspend, we sti=
ll
have an issue.

> This patchset was tested in different scenarios using different test
> suites, as the kernel selftests and htm-torture[3], in the following
> configuration:
>=20
>  * POWER8/pseries LE and BE
>  * POWER8/powernv LE
>  * POWER9/powernv LE hosting KVM guests running TM tests
>=20
> This patchset is based on initial work done by Cyril Bur:
>     https://patchwork.ozlabs.org/cover/875341/

Adding Cyril to CC.

Mikey
