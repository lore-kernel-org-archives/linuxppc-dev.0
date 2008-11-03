Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C599DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 19:31:29 +1100 (EST)
Date: Mon, 3 Nov 2008 09:31:19 +0100
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [rfc][patch] powerpc: replace isync with lwsync
Message-ID: <20081103083119.GA28262@wotan.suse.de>
References: <20081101123339.GA32055@wotan.suse.de>
	<20081101130715.GC32055@wotan.suse.de>
	<18702.36070.59703.535800@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18702.36070.59703.535800@cargo.ozlabs.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 03, 2008 at 04:32:22PM +1100, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > This is an interesting one for me. AFAIKS it is possible to use lwsync for
> > a full barrier after a successful ll/sc operation, right? (or stop me here
> > if I'm wrong).
> 
> An lwsync would order subsequent loads after the lwarx/ldarx, and
> subsequent stores after the stcwx./stcdx., which should be good
> enough.

OK, thanks for confirmation.
 

> > isync followed by a branch I guess does something like puts a bubble
> > into the pipeline until the branch retires? So it is probably always
> > going to cost some cycles.
> 
> I don't know about "retires", but isync is going to stop following
> instructions from executing until the outcome of the branch is known.

OK, I probably don't use the right terminology. I assume the branch
retires when its outcome is known and the CPU starts executing the
result.


> On machines that don't have lwsync we will still want to use isync
> (since the other alternative would be the full heavyweight sync).
> Your patch doesn't seem to do that.

No, it's just a quick hack at the moment. I think your reply gets it
past the not-totally-broken stage :) But at this point I can't justify
sending such a change upstream based on a small improvement on G5. I
would like to know about newer POWER CPUs, and even unreleased ones.
If there is some reason lwsync gets relatively more constraining or
difficult to execute than isync, then maybe this change is not useful.

Thanks,
Nick
