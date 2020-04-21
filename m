Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FCCC54FC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 17:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5BC206E9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 17:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5BC206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 496B3s6TlCzDqQ8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2020 03:52:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 496B122p6pzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2020 03:50:14 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03LHoA0l017894;
 Tue, 21 Apr 2020 12:50:10 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 03LHo8en017893;
 Tue, 21 Apr 2020 12:50:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 21 Apr 2020 12:50:08 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Add base support for ISA v3.1
Message-ID: <20200421175008.GU26902@gate.crashing.org>
References: <20200403041055.27535-1-alistair@popple.id.au>
 <20200403153208.GI26902@gate.crashing.org> <2217912.fZQhC0vD34@townsend>
 <2992996.BaUphQCMZx@townsend>
 <CAOSf1CGP02VW9adNyBcHF4_BZiv-jKohH4qihj7BmEgAif0VLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CGP02VW9adNyBcHF4_BZiv-jKohH4qihj7BmEgAif0VLA@mail.gmail.com>
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Tue, Apr 21, 2020 at 11:58:31AM +1000, Oliver O'Halloran wrote:
> On Tue, Apr 21, 2020 at 11:53 AM Alistair Popple <alistair@popple.id.au> wrote:
> >
> > On Tuesday, 21 April 2020 11:30:52 AM AEST Alistair Popple wrote:
> > > On Saturday, 4 April 2020 2:32:08 AM AEST Segher Boessenkool wrote:
> > > > Hi!
> > > >
> > > > On Fri, Apr 03, 2020 at 03:10:54PM +1100, Alistair Popple wrote:
> > > > > +#define   PCR_ARCH_300   0x10            /* Architecture 3.00 */
> > > >
> > > > It's called 3.0, not 3.00?
> > >
> > > Thanks. I'll fix that up.
> >
> > Actually we have already defined it upstream as CPU_FTR_ARCH_300 in arch/
> > powerpc/include/asm/cputable.h and PVR_ARCH_300 in arch/powerpc/include/asm/
> > reg.h so for consistency we should make it the same here. So either we leave
> > this patch as is or we change it to PCR_ARCH_30 along with the existing
> > upstream #defines. Thoughts?
> 
> I used 300 for consistency with the existing three digit definitions
> when I added the CPU_FTR macro. It doesn't really matter since these
> are all internal definitions, but I SAY THE BIKESHED SHOULD BE THREE
> DIGITS LONG.

You can do in your own symbols whatever you want, but the comment is
refering to an existing real-world version of the ISA, namely, 3.0 :-)

(It's important to get names right, and especially in the canonical
places, like this one.  IMO of course).


Segher
