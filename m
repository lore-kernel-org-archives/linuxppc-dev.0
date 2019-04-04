Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F6FC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 14:55:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52715205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 14:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52715205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZmG0660zzDqN1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZmDC3vTwzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 01:53:47 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x34ErYke020057;
 Thu, 4 Apr 2019 09:53:35 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x34ErXJF020056;
 Thu, 4 Apr 2019 09:53:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 4 Apr 2019 09:53:33 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc/vmlinux.lds: Drop binutils < 2.18 workarounds
Message-ID: <20190404145333.GC8599@gate.crashing.org>
References: <20190329064453.12761-1-joel@jms.id.au>
 <20190329095318.GJ3969@gate.crashing.org>
 <CACPK8Xes6+j+bjCbqwBLJpvP-Hi_WzbtEwfUSzJjeAW9jwFRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xes6+j+bjCbqwBLJpvP-Hi_WzbtEwfUSzJjeAW9jwFRKA@mail.gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Joel,

On Thu, Apr 04, 2019 at 12:17:40PM +0000, Joel Stanley wrote:
> On Fri, 29 Mar 2019 at 09:53, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Fri, Mar 29, 2019 at 05:14:53PM +1030, Joel Stanley wrote:
> > > -     NOTES :kernel :notes
> > > +     NOTES
> >
> > I think this still need to be
> >
> >         NOTES :kernel
> >
> > or the linker will complain.  Did you try to build ppc64_defconfig?
> 
> Yeah, I did build (and boot, in qemu) the ppc64_defconfig. I tried
> leaving in/removing the :kernel annotation in a bunch of places and as
> long as I had it in the first spot, the kernel linked.
> 
> Shall I respin with this added?

Yes please, if only so we are testing the exact same thing :-)

There may be a binutils version difference here.

> > (And I do not know if there are any tools that expect the notes in a phdr,
> > or even specifically the second phdr).

^^^ This question remains?


Segher
