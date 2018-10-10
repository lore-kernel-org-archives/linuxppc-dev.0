Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA16C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:07:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0142086E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 22:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0142086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Vp9V5wgjzF27h
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 09:07:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vp7Q6NTKzF14w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 09:05:22 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9AM5BTT023247;
 Wed, 10 Oct 2018 17:05:11 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w9AM59YW023230;
 Wed, 10 Oct 2018 17:05:09 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 10 Oct 2018 17:05:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 1/2] powerpc/boot: Disable vector instructions
Message-ID: <20181010220509.GF29268@gate.crashing.org>
References: <20181010024523.4921-1-joel@jms.id.au>
 <20181010024523.4921-2-joel@jms.id.au>
 <87lg762e94.fsf@concordia.ellerman.id.au>
 <CACPK8Xf+vF_87Ji+2XKzOM8HN6R8e+wKVYPZgQva9KwFSZDvJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf+vF_87Ji+2XKzOM8HN6R8e+wKVYPZgQva9KwFSZDvJg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 11, 2018 at 08:22:54AM +1030, Joel Stanley wrote:
> On Wed, 10 Oct 2018 at 22:41, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Joel Stanley <joel@jms.id.au> writes:
> > >  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> > > -              -fno-strict-aliasing -Os -msoft-float -pipe \
> > > -              -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
> > > +              -fno-strict-aliasing -Os -msoft-float -mno-altivec -mno-vsx \
> >
> > That's going to break if the compiler doesn't understand -mno-vsx isn't it?
> >
> > I'm not sure if "support" a compiler that old though.
> 
> Segher, the kernel mandates 4.6 as the minimum. Do we need to worry
> about the compiler not supporting  -mno-altivec -mno-vsx?

-mvsx is gcc 4.5 and later.
https://www.gnu.org/software/gcc/gcc-4.5/changes.html

-maltivec is...  Hrm, not so easy to find...  gcc 3.1 and later it seems.
https://www.gnu.org/software/gcc/gcc-3.1/changes.html

You should be fine.


Segher
