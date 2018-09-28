Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E7EC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:37:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB92216FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB92216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M0nZ3W9KzF3BV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:37:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M0lR5yxgzF37x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:36:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42M0lR1qzqz9s1x;
 Fri, 28 Sep 2018 15:36:03 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 06C72EE78BF; Fri, 28 Sep 2018 15:36:03 +1000 (AEST)
Message-ID: <ceb1c2179b62ff0d418c727d9f016bb854578252.camel@neuling.org>
Subject: Re: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Sep 2018 15:36:02 +1000
In-Reply-To: <18dcf8b7-1001-d6cc-1847-af9c679f9435@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-9-git-send-email-leitao@debian.org>
 <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
 <18dcf8b7-1001-d6cc-1847-af9c679f9435@debian.org>
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

On Thu, 2018-09-27 at 18:03 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/18/2018 02:36 AM, Michael Neuling wrote:
> > On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> > > Make sure that we are not suspended on ptrace and that the registers =
were
> > > already reclaimed.
> > >=20
> > > Since the data was already reclaimed, there is nothing to be done her=
e
> > > except to restore the SPRs.
> > >=20
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  arch/powerpc/kernel/ptrace.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrac=
e.c
> > > index 9667666eb18e..cf6ee9154b11 100644
> > > --- a/arch/powerpc/kernel/ptrace.c
> > > +++ b/arch/powerpc/kernel/ptrace.c
> > > @@ -136,12 +136,10 @@ static void flush_tmregs_to_thread(struct
> > > task_struct
> > > *tsk)
> > >  	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk !=3D current))
> > >  		return;
> > > =20
> > > -	if (MSR_TM_SUSPENDED(mfmsr())) {
> > > -		tm_reclaim_current(TM_CAUSE_SIGNAL);
> > > -	} else {
> > > -		tm_enable();
> > > -		tm_save_sprs(&(tsk->thread));
> > > -	}
> > > +	WARN_ON(MSR_TM_SUSPENDED(mfmsr()));
> > > +
> > > +	tm_enable();
> > > +	tm_save_sprs(&(tsk->thread));
> >=20
> > Do we need to check if TM was enabled in the task before saving the TM =
SPRs?
> >=20
> > What happens if TM was lazily off and hence we had someone else's TM SP=
Rs in
> > the
> > CPU currently?  Wouldn't this flush the wrong values to the task_struct=
?
> >=20
> > I think we need to check the processes MSR before doing this.
>=20
> Yes, it is a *very* good point, and I think we are vulnerable even before
> this patch (in the current kernel). Take a look above, we are calling
> tm_save_sprs() if MSR is not TM suspended independently if TM is lazily o=
ff.

I think you're right, we might already have an issue.  There are some paths=
 in
here that don't check the userspace msr or any of the lazy tm enable. :(

Mikey


> It shouldn't be hard to create a test case for it. I can try to call
> ptrace(PTRACE_GETVRREGS) on a task that sleeps until TM is lazily disable=
d,
> compare if the TM SPR changed in this mean time. (while doing HTM in para=
llel
> to keep HTM SPR changing). Let's see if I can read others task TM SPRs.
>=20
> Thank you.
>=20
