Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A2C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:19:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EAE2152F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EAE2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M0N13js9zF3BR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:19:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M0L66ZpBzF37s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:17:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42M0L64tDgz9s3Z;
 Fri, 28 Sep 2018 15:17:34 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 6A4D5EE78BF; Fri, 28 Sep 2018 15:17:34 +1000 (AEST)
Message-ID: <51a0d5bad5b498065b30fd3e126a24d5d81f52ae.camel@neuling.org>
Subject: Re: [RFC PATCH 10/11] powerpc/tm: Set failure summary
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Sep 2018 15:17:34 +1000
In-Reply-To: <85a2de6d-6cb5-6052-252e-858e61eb00ab@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-11-git-send-email-leitao@debian.org>
 <7647a2d788ceb979e6de8bb8bb988f4d37fb1877.camel@neuling.org>
 <85a2de6d-6cb5-6052-252e-858e61eb00ab@debian.org>
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

On Thu, 2018-09-27 at 17:52 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/18/2018 02:50 AM, Michael Neuling wrote:
> > On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> > > Since the transaction will be doomed with treckpt., the TEXASR[FS]
> > > should be set, to reflect that the transaction is a failure. This pat=
ch
> > > ensures it before recheckpointing, and remove changes from other plac=
es
> > > that were calling recheckpoint.
> >=20
> > TEXASR[FS] should be set by the reclaim.=20
>=20
> Do you mean that the CPU should set TEXASR[FS] when treclaim is called, o=
r,
> that the tm_reclaim?
>=20
> Looking at the ISA, I didn't see TEXASR[FS] being set automatically when =
a
> reclaim happens,=20
treclaim in ISA talks about "TMRecordFailure(cause)" and that macro sets
TEXASR[FS]=3D1.=20

So yes treclaim always sets TEXASR[FS]=3D1.

> although, I see it needs TEXASR[FS] to be set when executing a=20
> trecheckpoint, otherwise it will cause a TM Bad Thing.

Yep

> That is why I am forcing TEXASR[FS]=3D1 to doom the transaction so we can
> recheckpoint it, but it seems I understood this wrongly.

You shouldn't need to.  We do a bug_on() just before the trecheckpoint to m=
ake
sure it's set, but you shouldn't need to set it (other than the signals cas=
e).

> > I don't know why you'd need to set this
> > explicitly in process.c. The only case is when the user supplies a bad
> > signal
> > context, but we should check that in the signals code, not process.c
> >=20
> > Hence I think this patch is wrong.
> >=20
> > Also, according to the architecture, TEXASR[FS] HAS TO BE SET on
> > trecheckpoint
> > otherwise you'll get a TM Bad Thing. You should say that rather than
> > suggesting
> > it's because the transaction is doomed. It's ilqlegal to not do it. Tha=
t's
> > why we
> > have this check in arch/powerpc/kernel/tm.S.
>=20
> When you say "HAS TO BE SET", do you mean that the hardware will set it a=
nd
> we shouldn't care about this flag? Thus, if I am hitting EMIT_BUG_ENTRY, =
it
> means my TEXASR was messed somehow?

I'm just saying what you said before about the tm bad thing.  We have to ma=
ke
sure it's set before we do the trecheckpoint otherwise we end up in the TM =
bad
thing. The treclaim should handle this for us (but again the signals case n=
eed
to be checked).

Mikey
