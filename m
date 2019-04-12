Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF12C10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF082186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF082186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gLL74S9WzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:44:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gLJ36nBHzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 11:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44gLJ33sR8z8vqL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 11:42:59 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44gLJ33Vmzz9s7T; Fri, 12 Apr 2019 11:42:59 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44gLJ24gCpz9s5c
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Apr 2019 11:42:57 +1000 (AEST)
Received: from MTA-10.privateemail.com (unknown [10.20.147.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 9C4BF60600;
 Fri, 12 Apr 2019 01:42:53 +0000 (UTC)
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
 by MTA-10.privateemail.com (Postfix) with ESMTP id 785FA60038;
 Thu, 11 Apr 2019 21:42:53 -0400 (EDT)
Received: from APP-02 (unknown [10.20.147.152])
 by MTA-10.privateemail.com (Postfix) with ESMTPA id 5637C60033;
 Fri, 12 Apr 2019 01:42:53 +0000 (UTC)
Date: Thu, 11 Apr 2019 21:42:53 -0400 (EDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Michael Ellerman <mpe@ellerman.id.au>, Oliver <oohall@gmail.com>
Message-ID: <2135906361.58004.1555033373326@privateemail.com>
In-Reply-To: <87h8b4vhti.fsf@concordia.ellerman.id.au>
References: <20190408030804.5805-1-cmr@informatik.wtf>
 <CAOSf1CEZgHtz5u6F+N7egf3B+MiquFcsopm1yiMZvdYvKcip1w@mail.gmail.com>
 <864072306.101924.1554863718473@privateemail.com>
 <87h8b4vhti.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/xmon: add read-only mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: linuxppc-dev@ozlabs.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On April 11, 2019 at 8:37 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> 
> Christopher M Riedl <cmr@informatik.wtf> writes:
> >> On April 8, 2019 at 1:34 AM Oliver <oohall@gmail.com> wrote:
> >> On Mon, Apr 8, 2019 at 1:06 PM Christopher M. Riedl <cmr@informatik.wtf> wrote:
> ...
> >> >
> >> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> >> > index 4e00cb0a5464..0c7f21476018 100644
> >> > --- a/arch/powerpc/Kconfig.debug
> >> > +++ b/arch/powerpc/Kconfig.debug
> >> > @@ -117,6 +117,16 @@ config XMON_DISASSEMBLY
> >> >           to say Y here, unless you're building for a memory-constrained
> >> >           system.
> >> >
> >> 
> >> > +config XMON_RW
> >> > +       bool "Allow xmon read and write operations"
> >> > +       depends on XMON
> >> > +       default !STRICT_KERNEL_RWX
> >> > +       help
> >> > +         Allow xmon to read and write to memory and special-purpose registers.
> >> > +          Conversely, prevent xmon write access when set to N. Read and write
> >> > +          access can also be explicitly controlled with 'xmon=rw' or 'xmon=ro'
> >> > +          (read-only) cmdline options. Default is !STRICT_KERNEL_RWX.
> >> 
> >> Maybe I am a dumb, but I found this *extremely* confusing.
> >> Conventionally Kconfig options will control what code is and is not
> >> included in the kernel (see XMON_DISASSEMBLY) rather than changing the
> >> default behaviour of code. It's not wrong to do so and I'm going to
> >> assume that you were following the pattern of XMON_DEFAULT, but I
> >> think you need to be a little more clear about what option actually
> >> does. Renaming it to XMON_DEFAULT_RO_MODE and re-wording the
> >> description to indicate it's a only a mode change would help a lot.
> >> 
> >> Sorry if this comes across as pointless bikeshedding since it's the
> >> opposite of what Christophe said in the last patch, but this was a bit
> >> of a head scratcher.
> >
> > If anyone is dumb here it's me for making this confusing :)
> > I chatted with Michael Ellerman about this, so let me try to explain this more clearly.
> 
> Yeah it's my fault :)
>

"Signed-off-by: Christopher M. Riedl" -- I take full responsibility hah.

> 
> > There are two things I am trying to address with XMON_RW:
> > 1) provide a default access mode for xmon based on system "security"
> 
> I think I've gone off this idea. Tying them together is just enforcing a
> linkage that people may not want.
> 
> I think XMON_RW should just be an option that stands on its own. It
> should probably be default n, to give people a safe default.
> 

Next version includes this along with making it clear that this option
provides the default mode for XMON.

>
> > 2) replace XMON in the decision to write-protect kernel text at compile-time
> 
> We should do that as a separate patch. That's actually a bug in the
> current STRICT_KERNEL_RWX support.
> 
> ie. STRICT_KERNEL_RWX should always give you PAGE_KERNEL_ROX, regardless
> of XMON or anything else.
> 
> > I think a single Kconfig for both of those things is sensible as ultimately the
> > point is to allow xmon to operate in read-only mode on "secure" systems -- without
> > violating any integrity/security guarantees (such as write-protected kernel text).
> >
> > Christophe suggested looking at STRICT_KERNEL_RWX and I think that option makes the
> > most sense to base XMON_RW on since the description for STRICT_KERNEL_RWX states:
> 
> Once we fix the bugs in STRICT_KERNEL_RWX people are going to enable
> that by default, so it will essentially be always on in future.
> 
> 
> > With that said, I will remove the 'xmon=rw' cmdline option as it really doesn't work
> > since kernel text is write-protected at compile time.
> 
> I think 'xmon=rw' still makes sense. Only some of the RW functionality
> relies on being able to patch kernel text.
> 
> And once you have proccall() you can just call a function to make it
> read/write anyway, or use memex to manually frob the page tables.
> 
> cheers

Great, adding this back in the next version.
