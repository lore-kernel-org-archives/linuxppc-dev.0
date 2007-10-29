Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 29 Oct 2007 07:08:24 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] powerpc: Pass PID argument to _tlbie (WAS: Apparent
	kernel bug with GDB on ppc405)
Message-ID: <20071029070824.72854629@weaponx.rchland.ibm.com>
In-Reply-To: <1193470322.18243.63.camel@pasglop>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop>
	<20071026144134.GW19691@waste.org>
	<1193448653.18243.9.camel@pasglop>
	<1193470322.18243.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org,
	Kumar Gala <galak@gate.crashing.org>, Matt Mackall <mpm@selenic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 27 Oct 2007 17:32:02 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Allright, so Matt, let me know if that fixes your problem with gdb, and
> I'll clean the patch up a bit and submit it. I want to double check if
> something similar may be needed for freescale booke.
> 
> Basically, the problem is that things like get_user_pages() can cause
> COW operations which in turn call _tlbie() to be called for translations
> that aren't in the current address space.
> 
> The current 40x and 44x implementation of _tlbie doesn't handle that
> properly as it only invalidates entries in the current PID.
> 
> This is an attempt at fixing it. Untested, I just checked it builds for
> arch/powerpc and arch/ppc. I also haven't looked whether the freescale
> BookE _tlbie needs similar treatement (it will get passed the pid in r4
> with that patch, so if it needs to do something with it, it can). Kumar,
> can you have a look ?

This looks pretty good at first glance.  I'll try to test it out today,
but I'd still like to hear if it solves Matt's problem as I doubt I'll
be able to duplicate it.

josh
