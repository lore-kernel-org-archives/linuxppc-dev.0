Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16CDC32753
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 18:36:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BDD2133F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 18:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BDD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467ywm53cjzDr1S
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 04:36:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467ytF5SDKzDqwg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 04:34:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 467ytF1yjCz8tVP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 04:34:45 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 467ytF1NLFz9sND; Thu, 15 Aug 2019 04:34:45 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 467ytD4QtBz9sN6
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Aug 2019 04:34:44 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7EIYYlH007378;
 Wed, 14 Aug 2019 13:34:34 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7EIYWLs007377;
 Wed, 14 Aug 2019 13:34:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 14 Aug 2019 13:34:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 2/7] powerpc/kernel: Add ucall_norets() ultravisor call
 handler
Message-ID: <20190814183432.GG31406@gate.crashing.org>
References: <20190808040555.2371-1-cclaudio@linux.ibm.com>
 <20190808040555.2371-3-cclaudio@linux.ibm.com>
 <87wofgqb2g.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wofgqb2g.fsf@concordia.ellerman.id.au>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 Ryan Grimm <grimm@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Guerney Hunt <gdhh@linux.ibm.com>, Thiago Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 14, 2019 at 08:46:15PM +1000, Michael Ellerman wrote:
> Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> > +_GLOBAL(ucall_norets)
> > +EXPORT_SYMBOL_GPL(ucall_norets)
> > +	mfcr	r0
> > +	stw	r0,8(r1)
> > +
> > +	sc	2		/* Invoke the ultravisor */
> > +
> > +	lwz	r0,8(r1)
> > +	mtcrf	0xff,r0
> > +	blr			/* Return r3 = status */
> 
> Paulus points that we shouldn't need to save CR here. Our caller will
> have already saved it if it needed to, and we don't use CR in this
> function so we don't need to save it.
> 
> That's assuming the Ultravisor follows the hcall ABI in which CR2-4 are
> non-volatile (PAPR § 14.5.3).

And assuming the ultravisor already clears (or sets, or whatever) all CR
fields it does not want to leak the contents of (which it also should,
of course).

> I know plpar_hcall_norets() does save CR, but it shouldn't need to, that
> seems to be historical. aka. no one knows why it does it but it always
> has.


Segher
