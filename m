Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B4C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D5C2170E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D5C2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M0Y024yJzF3Bp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:27:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M0Vp21BGzF37x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:25:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42M0Vp0h8mz9s1x;
 Fri, 28 Sep 2018 15:25:06 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id BF94FEE78BF; Fri, 28 Sep 2018 15:25:05 +1000 (AEST)
Message-ID: <e852ee2d7f960efc7d28c5fb7c9ea782b2f87856.camel@neuling.org>
Subject: Re: [RFC PATCH 11/11] selftests/powerpc: Adapt the test
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Sep 2018 15:25:05 +1000
In-Reply-To: <434af377-492f-358a-b759-ab68eaeccb3c@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-12-git-send-email-leitao@debian.org>
 <b544029461059473cb7b8b6c66815a3ff31ec540.camel@neuling.org>
 <434af377-492f-358a-b759-ab68eaeccb3c@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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
Cc: ldufour@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-09-27 at 17:57 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/18/2018 03:36 AM, Michael Neuling wrote:
> > On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> > > The Documentation/powerpc/transactional_memory.txt says:
> > >=20
> > >  "Syscalls made from within a suspended transaction are performed as
> > > normal
> > >   and the transaction is not explicitly doomed by the kernel.  Howeve=
r,
> > >   what the kernel does to perform the syscall may result in the
> > > transaction
> > >   being doomed by the hardware."
> > >=20
> > > With this new TM mechanism, the syscall will continue to be executed =
if
> > > the
> > > syscall happens on a suspended syscall, but, the syscall will *fail* =
if
> > > the
> > > transaction is still active during the syscall invocation.
> >=20
> > Not sure I get this. This doesn't seem any different to before.
> >=20
> > An active (not suspended) transaction *will* result in the syscall fail=
ing
> > and
> > the transaction being doomed. =20
> >=20
> > A syscall in a suspended transaction should succeed and the transaction=
.
>=20
> I understand that a transaction will always be doomed if there is a
> reclaim/checkpoint, thus, if the you make a system call inside a suspende=
d
> transaction, it will reclaim and recheckpoint, thus, dooming the transact=
ion,
> and failing it on the next RFID.

So currently a syscall won't explicitly treclaim/trecheckpoint so it won't
necessarily be doomed.

With your new patches it will be.

> So, the syscall executed in suspended mode may succeed, because it will n=
ot
> be skipped (as in active mode), but the transaction will *always* fail,
> because there was a reclaim and recheckpoint.
>=20
> > You might need to clean up the language. I try to use:
> >=20
> >    Active =3D=3D transactional but not suspended (ie MSR[TS] =3D T)
> >    Suspended =3D=3D suspended (ie MSR [TS] =3D S)
> >    Doomed =3D=3D transaction to be rolled back at next opportinity (ie =
tcheck
> > returns doomed)
> >=20
> > (note: the kernel MSR_TM_ACTIVE() macro is not consistent with this sin=
ce
> > it's
> > MSR[TS] =3D=3D S or T).
>=20
> Ok, I agree with this language as well. I might want to improve the code =
to
> follow the same language all across the code.
>=20
> > > On the syscall path, if the transaction is active and not suspended, =
it
> > > will call TM_KERNEL_ENTRY which will reclaim and recheckpoint the
> > > transaction, thus, dooming the transaction on userspace return, with
> > > failure code TM_CAUSE_SYSCALL.
> >=20
> > But the test below is on a suspend transaction?
>=20
> Sorry, I meant "suspended transaction" above instead of "transaction is
> active and not suspended".
>=20
> >=20
> > > This new model will break part of this test, but I understand that th=
at
> > > the
> > > documentation above didn't guarantee that the syscall would succeed, =
and
> > > it
> > > will never succeed anymore now on.
> >=20
> > The syscall should pass in suspend (modulo the normal syscall checks). =
The
> > transaction may fail as a result.
>=20
> Perfect, and if the transaction fail, the CPU will rollback the changes a=
nd
> restore the checkpoint registers (replacing the r3 that contains the pid
> value), thus, it will be like "getpid" system call didn't execute.

No.  If we are suspended, then we go back right after the sc. We don't get
rolled back till the tresume.

Mikey

> For this test specifically, it assumes the syscall didn't execute if the
> transaction failed. Take a look:
>=20
> 	FUNC_START(getppid_tm_suspended)
> 		tbegin.
> 		beq 1f
> 		li      r0, __NR_getppid
> 		tsuspend.
> 		sc
> 		tresume.
> 		tend.
> 		blr
> 	1:
> 		li      r3, -1
> 		blr
>=20
> So, the tests thinks the syscall failed because the transaction aborted.
>=20
> Anyway, I can try to improve this test other than removing this test, but=
 I
> am not sure how.
>=20
> Thank you
>=20
