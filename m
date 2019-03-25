Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE61C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:58:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A2B2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A2B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Shng08wBzDqK9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 04:58:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Shlh4CVWzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 04:56:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Shlh0WXjz8t5X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 04:56:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Shlg2hMhz9sSp; Tue, 26 Mar 2019 04:56:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Shlf2bGZz9sSk
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Mar 2019 04:56:29 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2PHsnKE019994;
 Mon, 25 Mar 2019 12:54:54 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2PHsd3H019973;
 Mon, 25 Mar 2019 12:54:39 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 25 Mar 2019 12:54:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
Message-ID: <20190325175431.GJ3969@gate.crashing.org>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
 <20190322182943.GF3969@gate.crashing.org>
 <877ecnp1zf.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ecnp1zf.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 11:33:56PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Fri, Mar 22, 2019 at 11:37:24PM +1100, Michael Ellerman wrote:
> >> +	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff
> >
> > You can just write
> >   rlwinm r6,r4,0,0x0fff
> 
> > if that is clearer?  Or do you still want a comment with that :-)
> 
> I don't think it's clearer doing a rotate of zero bits :)
> 
> And yeah I'd probably still leave the comment, so I'm inclined to stick
> with the clrldi?

I always have to think what the clrldi etc. do exactly, while with rlwinm
it is obvious.  But yeah this may be different for other people who are
used to different idiom.

> Would be nice if the assembler could support:
> 
> 	andi	r6, r4, 0x0fff
> 
> And turn it into the rlwinm, or rldicl :)

The extended mnemonics are *simple*, *one-to-one* mappings.  Having
"andi. 6,4,0x0f0f" a valid insn, but an extended mnemonic "andi 6,4,0x0f0f"
that is not (and the other way around for say 0xff0000ff) would violate that.

You could do some assembler macro, that can also expand to multiple insns
where that is useful.  Also one for loading constants, etc.  The downside
to that is you often do care how many insns are generated.

Instead you could do a macro for only those cases that can be done with *one*
insn.  But that then is pretty restricted in use, and people have to learn
what values are valid.

I don't see a perfect solution.


Segher
