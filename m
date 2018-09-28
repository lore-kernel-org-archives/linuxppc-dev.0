Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7EEC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:05:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BAA216FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BAA216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M03z2d4YzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:05:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M0236yzrzF39s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42M0235PZsz9s3x;
 Fri, 28 Sep 2018 15:03:39 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 69F94EE78BF; Fri, 28 Sep 2018 15:03:39 +1000 (AEST)
Message-ID: <76750b659e4ac0e3eb1bca338c04285c58b6b9b9.camel@neuling.org>
Subject: Re: [RFC PATCH 09/11] powerpc/tm: Do not restore default DSCR
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Sep 2018 15:03:39 +1000
In-Reply-To: <11f2155f-eff8-2aac-ab47-1ab343d52107@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-10-git-send-email-leitao@debian.org>
 <10da0fdc641b05ea288890a23aa01ad33f2d6987.camel@neuling.org>
 <11f2155f-eff8-2aac-ab47-1ab343d52107@debian.org>
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

On Thu, 2018-09-27 at 17:51 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/18/2018 02:41 AM, Michael Neuling wrote:
> > On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> > > In the previous TM code, trecheckpoint was being executed in the midd=
le of
> > > an exception, thus, DSCR was being restored to default kernel DSCR va=
lue
> > > after trecheckpoint was done.
> > >=20
> > > With this current patchset, trecheckpoint is executed just before get=
ting
> > > to userspace, at ret_from_except_lite, for example. Thus, we do not n=
eed
> > > to
> > > set default kernel DSCR value anymore, as we are leaving kernel space=
.  It
> > > is OK to keep the checkpointed DSCR value into the live SPR, mainly
> > > because
> > > the transaction is doomed and it will fail soon (after RFID),=20
> >=20
> > What if we are going back to a suspended transaction?  It will remain l=
ive
> > until
> > userspace does a tresume
>=20
> Hmm, I understand that once we get in kernel space, and call
> treclaim/trecheckpoint, the transaction will be doomed and it will abort =
and
> rollback when we leave kernel space. I.e., if we can treclaim/trecheckpoi=
ntn
> in kernel space, the transaction will *always* abort just after RFID, so,=
 a
> possible tresume will never be executed. Is my understanding wrong?

Your understanding is wrong. We don't roll back until MSR[TS] =3D T.

There are two cases for the RFID.

1) if you RFID back to userspace that is transactional (ie MSR[TS] =3D T), =
then it
will immediately rollback as soon as the RFID happens since we are going
directly to T.

2) If you RFID back to userspace that is suspended (ie MSR[TS] =3D S), then=
 it
won't roll back until userspace does a tresume. It doesn't rollback until w=
e go
MSR[TS] =3D S -> T).

> >=20
> > > so,
> > > continuing with the pre-checkpointed DSCR value is what seems correct=
.
> >=20
> > Reading this description suggests this patch isn't really needed. Right=
?
>=20
> Maybe the description is not clear, but I understand this patch is requir=
ed,
> otherwise we will leave userspace with a default DSCR value.
>=20
> By the way, do you know if there is a change in DSCR inside a transaction=
,
> will it be reverted if the transaction is aborted?

Yes it will be reverted. We even have a selftest for it in
tools/testing/selftests/powerpc/tm/tm-resched-dscr.c

There are a bunch of checkpointed SPRs. From the arch:
   Checkpointed registers: The set of registers that are
   saved to the =E2=80=9Ccheckpoint area=E2=80=9D when a transaction is
   initiated, and restored upon transaction failure, is a
   subset of the architected register state, consisting of
   the General Purpose Registers, Floating-Point Regis-
   ters, Vector Registers, Vector-Scalar Registers, and the
   following Special Registers and fields: CR fields other
   than CR0, XER, LR, CTR, FPSCR, AMR, PPR,
   VRSAVE, VSCR, DSCR, and TAR.

Mikey
