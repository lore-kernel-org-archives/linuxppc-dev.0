Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BDC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:29:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3D12170E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 05:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3D12170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42M0bn1yfGzF3Bg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 15:29:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42M0YZ6TGVzF37x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:27:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42M0YZ5WXLz9s4Z;
 Fri, 28 Sep 2018 15:27:30 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 393EFEE78BF; Fri, 28 Sep 2018 15:27:30 +1000 (AEST)
Message-ID: <488686b8f1663c731d3b4ffcd1383573c015388d.camel@neuling.org>
Subject: Re: [RFC PATCH 05/11] powerpc/tm: Function that updates the failure
 code
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Sep 2018 15:27:30 +1000
In-Reply-To: <205eceb0-1f6f-340c-fea4-97b31297272d@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-6-git-send-email-leitao@debian.org>
 <53c7daa6af9a502827e877d04b4a45b7eea5efbe.camel@neuling.org>
 <205eceb0-1f6f-340c-fea4-97b31297272d@debian.org>
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

On Thu, 2018-09-27 at 17:58 -0300, Breno Leitao wrote:
> Hi Mikey,
>=20
> On 09/17/2018 10:29 PM, Michael Neuling wrote:
> > On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
> > > Now the transaction reclaims happens very earlier in the trap handler=
, and
> > > it is impossible to know precisely, at that early time, what should b=
e set
> > > as the failure cause for some specific cases, as, if the task will be
> > > rescheduled, thus, the transaction abort case should be updated from
> > > TM_CAUSE_MISC to TM_CAUSE_RESCHED, for example.
> >=20
> > Please add comments to where this is used (in EXCEPTION_COMMON macro I
> > think)
> > that say this might happen.
>=20
> Is it OK if I comment it in TM_KERNEL_ENTRY macro, since the failure caus=
e
> could be updated independently of the exception being execute, so, every =
call
> to TM_KERNEL_ENTRY can have the cause overwritten.

Sure.


> I.e. it does not matter if  the exception is a systemcall or a page fault=
,
> the failure cause will be updated if there is a process reschedule after =
the
> exception/syscall is handled.
>=20
> Thank you
>=20
