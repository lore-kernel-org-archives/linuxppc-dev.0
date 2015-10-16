Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2538C1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 18:57:29 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
To: David Gibson <dgibson@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <20151016132943.1386fda6@voom.fritz.box>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, thuth@redhat.com
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5620ADE4.9060701@redhat.com>
Date: Fri, 16 Oct 2015 09:57:24 +0200
MIME-Version: 1.0
In-Reply-To: <20151016132943.1386fda6@voom.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 16/10/2015 04:29, David Gibson wrote:
> On Thu, 15 Oct 2015 21:00:58 +0200 Laurent Vivier
> <lvivier@redhat.com> wrote:
> 
>> On kexec, all secondary offline CPUs are onlined before starting
>> the new kernel, this is not done in the case of kdump.
>> 
>> If kdump is configured and a kernel crash occurs whereas some
>> secondaries CPUs are offline (SMT=off), the new kernel is not
>> able to start them and displays some "Processor X is stuck.".
>> 
>> Starting with POWER8, subcore logic relies on all threads of core
>> being booted. So, on startup kernel tries to start all threads,
>> and asks OPAL (or RTAS) to start all CPUs (including threads). If
>> a CPU has been offlined by the previous kernel, it has not been
>> returned to OPAL, and thus OPAL cannot restart it: this CPU has
>> been lost...
>> 
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Nice analysis of the problem.  But, I'm a bit uneasy about this
> approach to fixing it: Onlining potentially hundreds of CPU threads
> seems like a risky operation in a kernel that's already crashed.

I agree.

> I don't have a terribly clear idea of what is the best way to
> address this.  Here's a few ideas in the right general direction:
> 
> * I'm already looking into a kdump userspace fixes to stop it 
> attempting to bring up secondary CPUs
> 
> * A working kernel option to say "only allow this many online cpus 
> ever" which we could pass to the kdump kernel would be nice
> 
> * Paulus had an idea about offline threads returning themselves 
> directly to OPAL by kicking a flag at kdump/kexec time.

For me the problem is: as these CPUs are offline, I guess the core has
been switched to 1 thread per core, so the CPUs (1 to 7 for core 0)
don't exist anymore, how can we return them to OPAL ?

> 
> BenH, Paulus,
> 
> OPAL <-> kernel cpu transitions don't seem to work quite how I
> thought they would.  IIUC there's a register we can use to directly
> control which threads on a core are active.  Given that I would
> have thought cpu "ownership" OPAL vs. kernel would be on a
> per-core, rather than per-thread basis.
> 
> Is there some way we can change the CPU onlining / offlining code
> so that if threads aren't in OPAL, we directly enable them, rather
> than just hoping they're in a nap loop somewhere?
> 

Laurent
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWIK3kAAoJEPMMOL0/L748S4UP/2rJIRavrB4QylPMYKpRIxf6
VCLuve3TRY40er5GO8bwQ+95yHUo8K57OzZAh8T2mDQGjHGJArMElWUbb+EGaDF2
z5FU0iH7TKkJ9FDBlz2ZTny0vrEK2eBwxAFggLcfF8PeKMs5H4Rh9FrTFKKuc9Z4
KSAdhi4niKVdn0ln8M6k5FGB3AE0gG7zeTPeO74Knrr8cvOX1Xk5pfgzo2WpD91w
zymDgG127xBL0G9gs8jrse+yXoB2dLsevdxS6CEH4vKnjsLokqnWlk1n9JeIUKiW
+BEZ0llb5jppBYzOmrghTS5fPwh+Nmkbc4Kk9i/1Tjb8LRXNBEiSxVtHu9XIdwve
K37gOIuqCkOap0NE/AbcDjsFEoCFVSHbdD6cCgtLEPVFq7f8w7U/qa9ty//PM8br
KGtfZ1sG2/LCapMuyx3QhplxrXEy/bpQwT3BPnS818OMxrE20QfR5PM2C+nCpd4H
8mpdLpOctLJ7lgmYSwSlbNkJrQJvTFXv8WhZB2Qkadi0yaq8C5JZ3Dr10HrijoVL
lsOfrevB/mHrZmLBkp8t4+UYa5fM59nNpFZ/0BTdWfP8CDAlkw2Kla5PVeKN4ssk
GzySgQwOPsyS27aAk005ZeXPtfrGD93A43EcwG4IULf5J8DbzmCt5gPoJ241D0IO
3Z8+/4nl3WVRVzQ/Lwlc
=yLqE
-----END PGP SIGNATURE-----
