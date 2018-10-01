Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B491C004D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:36:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496E920666
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496E920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NjyM4TQYzF37k
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 10:36:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NjwJ2Y7mzF35T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 10:34:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42NjwJ16xCz9s3C;
 Mon,  1 Oct 2018 10:34:40 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id C67F7EE78BF; Mon,  1 Oct 2018 10:34:39 +1000 (AEST)
Message-ID: <6c62c1935785fe9dc41d354417bf1772b424e465.camel@neuling.org>
Subject: Re: [RFC PATCH 08/11] powerpc/tm: Do not reclaim on ptrace
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 01 Oct 2018 10:34:39 +1000
In-Reply-To: <64e4d511-bfe6-fe37-1145-eed90939d079@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-9-git-send-email-leitao@debian.org>
 <743b29dab736700c1b284fabb8fccf7c83ddb3c2.camel@neuling.org>
 <18dcf8b7-1001-d6cc-1847-af9c679f9435@debian.org>
 <ceb1c2179b62ff0d418c727d9f016bb854578252.camel@neuling.org>
 <64e4d511-bfe6-fe37-1145-eed90939d079@debian.org>
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

On Sun, 2018-09-30 at 20:51 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/28/2018 02:36 AM, Michael Neuling wrote:
> > > > > +	WARN_ON(MSR_TM_SUSPENDED(mfmsr())); + +	tm_enable(); +=20
> > > > > tm_save_sprs(&(tsk->thread));
> > > >=20
> > > > Do we need to check if TM was enabled in the task before saving the
> > > > TM SPRs?
> > > >=20
> > > > What happens if TM was lazily off and hence we had someone else's T=
M=20
> > > > SPRs in the CPU currently?  Wouldn't this flush the wrong values to=
=20
> > > > the task_struct?
> > > >=20
> > > > I think we need to check the processes MSR before doing this.
> > >=20
> > > Yes, it is a *very* good point, and I think we are vulnerable even=
=20
> > > before this patch (in the current kernel). Take a look above, we are=
=20
> > > calling tm_save_sprs() if MSR is not TM suspended independently if TM
> > > is lazily off.
> >=20
> > I think you're right, we might already have an issue.  There are some=
=20
> > paths in here that don't check the userspace msr or any of the lazy tm=
=20
> > enable. :(
>=20
> I was able to create a test case that reproduces this bug cleanly.
>=20
> The testcase basically sleeps for N cycles, and then segfaults.
>=20
> If N is high enough to have load_tm overflowed, then you see a corrupted
> TEXASR value in the core dump file. If load_tm !=3D 0 during the coredump=
, you
> see the expected TEXASR value.
>=20
> I wrote a small bash that check for both cases.
>=20
>   $ git clone https://github.com/leitao/texasr_corrupt.git
>   $ make check
>=20
> Anyway, I will propose a fix for this problem soon, since this whole patc=
hset
> may delay to get ready. Is it OK?

Yeah, best to get a fix for this one out soon.

Mikey
