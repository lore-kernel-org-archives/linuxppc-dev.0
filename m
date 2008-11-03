Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18702.36070.59703.535800@cargo.ozlabs.ibm.com>
Date: Mon, 3 Nov 2008 16:32:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch] powerpc: replace isync with lwsync
In-Reply-To: <20081101130715.GC32055@wotan.suse.de>
References: <20081101123339.GA32055@wotan.suse.de>
	<20081101130715.GC32055@wotan.suse.de>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> This is an interesting one for me. AFAIKS it is possible to use lwsync for
> a full barrier after a successful ll/sc operation, right? (or stop me here
> if I'm wrong).

An lwsync would order subsequent loads after the lwarx/ldarx, and
subsequent stores after the stcwx./stcdx., which should be good
enough.

> isync followed by a branch I guess does something like puts a bubble
> into the pipeline until the branch retires? So it is probably always
> going to cost some cycles.

I don't know about "retires", but isync is going to stop following
instructions from executing until the outcome of the branch is known.

On machines that don't have lwsync we will still want to use isync
(since the other alternative would be the full heavyweight sync).
Your patch doesn't seem to do that.

Paul.
