Return-Path: <SRS0=kV/c=XT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FECC4320D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 15:31:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A5020665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 15:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A5020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46d4t56s7rzDqVd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 01:31:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.49.171; helo=4.mo178.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 12606 seconds by postgrey-1.36 at bilbo;
 Wed, 25 Sep 2019 01:29:21 AEST
Received: from 4.mo178.mail-out.ovh.net (4.mo178.mail-out.ovh.net
 [46.105.49.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46d4qP5LpfzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 01:29:17 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.143.223])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4747C75280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2019 13:50:08 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 69B17A1A10C8;
 Tue, 24 Sep 2019 11:49:56 +0000 (UTC)
Date: Tue, 24 Sep 2019 13:49:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/6] KVM: PPC: Book3S HV: XIVE: initialize private
 pointer when VPs are allocated
Message-ID: <20190924134954.2a6bf5f4@bahia.lan>
In-Reply-To: <20190924052855.GA7950@oak.ozlabs.ibm.com>
References: <156925341155.974393.11681611197111945710.stgit@bahia.lan>
 <156925341736.974393.18379970954169086891.stgit@bahia.lan>
 <20190924052855.GA7950@oak.ozlabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 211669184222501307
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedtgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 kvm-ppc@vger.kernel.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 24 Sep 2019 15:28:55 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Mon, Sep 23, 2019 at 05:43:37PM +0200, Greg Kurz wrote:
> > From: C=C3=A9dric Le Goater <clg@kaod.org>
> >=20
> > Do not assign the device private pointer before making sure the XIVE
> > VPs are allocated in OPAL and test pointer validity when releasing
> > the device.
> >=20
> > Fixes: 5422e95103cf ("KVM: PPC: Book3S HV: XIVE: Replace the 'destroy' =
method by a 'release' method")
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> What happens in the case where the OPAL allocation fails?  Does the
> host crash, or hang, or leak resources?  I presume that users can
> trigger the allocation failure just by starting a suitably large
> number of guests - is that right?  Is there an easier way?  I'm trying
> to work out whether this is urgently needed in 5.4 and the stable
> trees or not.
>=20

Wait... I don't quite remember how this patch landed in my tree but when
I look at it again I have the impression it tries to fix something that
cannot happen.

It is indeed easy to trigger the allocation failure, eg. start more than
127 guests on a Witherspoon system. But if this happens, the create
function returns an error and the device isn't created. I don't see how
the release function could hence get called with a "partially initialized"
device.

Please ignore this patch. Unfortunately the rest of the series doesn't
apply cleanly without it... I'll rebase and post a v2.

Sorry for the noise :-\

> Paul.

