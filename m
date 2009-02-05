Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1E1BDDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 11:17:31 +1100 (EST)
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Oren Laadan <orenl@cs.columbia.edu>
In-Reply-To: <498A284E.4050501@cs.columbia.edu>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
	<1233718789.16867.156.camel@pasglop> <20090204155406.GA2039@us.ibm.com>
	<1233781099.4612.1.camel@pasglop>  <498A284E.4050501@cs.columbia.edu>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 11:16:52 +1100
Message-Id: <1233793012.4612.32.camel@pasglop>
Mime-Version: 1.0
Cc: containers@lists.osdl.org, "Serge E. Hallyn" <serue@us.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-04 at 18:44 -0500, Oren Laadan wrote:
> * Anything that is decided at compiled time should probably go to the arch-
> dependent header.
> 
> * Anything that can change at boot time (e.g., for x86 that would include
> the capabilities of the FPU), or even run time (is there any ?) should
> be described to the letter (in fine print) in 'struct cr_hdr_cpu' and
> friends.

I think we should avoid compile time completely.

We mostly try to have kernels running on everything anyway, and there's
no reason not to be able to move a snapshot to a different CPU if it's
not using a feature of the CPU that is different.

Nathan, what about you start the structure with a 64 bit bitmask that
indicates what "records" are present followed by concatenated records ?

IE. The "main" state (pt_regs) wouldn't change, but then, you could have
a list of things:

 - FPRs
 - old style VSX
 - VSRs
 - Freescale SPE state
 - DABR
 - BookE IAC/DACs
 - tbd...

Then, when resuming a snapshot, we can use some bit masks trickery
indicating the validity on a given target. IE. If CPU has no VSX and
original program uses VSX then you can't resume. But if CPU has VSR you
can.. etc... We can keep it trivial at fist, especting the same
features, and try to be smart later.

Ben.
