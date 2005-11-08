Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id AF353686C2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 06:46:10 +1100 (EST)
Message-ID: <27139.213.84.146.227.1131479070.squirrel@protonic.xs4all.nl>
Date: Tue, 8 Nov 2005 20:44:30 +0100 (CET)
From: "David Jander" <david.jander@protonic.nl>
To: "Dan Malek" <dan@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
References: <20051107151011.GA17161@logos.cnet><b4fb08107c7bd17161f36e023035080a@embeddedalley.com><200511081259.26525.david.jander@protonic.nl><20051108175658.GO3839@smtp.west.cox.net>
	<ae77b5dcfdaa24efebf92042907e2ce8@embeddededge.com>
In-Reply-To: <ae77b5dcfdaa24efebf92042907e2ce8@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> I think Dan might be in the camp that says a properly designed embedded
>> system won't need to swap.
>
> I'm actually in the camp that knows the majority of systems
> running Linux aren't workstations and don't have disk drives.
> It would be nice to have selectable features for such applications.

Well, me too, but there are people out there trying to do strange stuff. I
remember myself even once trying to get swapping to work over nfs, because
I wanted to compile perl5 natively (overnight of course), since
cross-compiling perl is quite a bit of pain. Perl intends to
"include-together" enormous source files, that exhausted the whole 64Mbyte
RAM on my embedded board ;-)
Needless to say, swap over nfs did never work reliably enough to even
start compiling.

>>> It sounds tempting indeed, but should you really notice a performance
>>> increase out of this?
>
> Yes.  Most importantly it adds some predictability which is quite
> measurable on this class of processor. It was a coding mistake way back
> in 2.2 that actually exposed this.  I was taking some liberties by
> updating more status in the PTE than I should have, and Paulus
> made me fix it in 2.4 :-)  It basically eliminates TLB faults associated
> with system status tracking, since we aren't paging there isn't any need
> to track page aging and such.  If you are paging, it still
> functions properly, you may just not pick the most suitable pages to
> steal.

FYI, I have some benchmark results of yesterday's git of kernel-2.6 (with
_tlbie(address); just moved out of the two innermost if()'s in the
function update_mmu_cache()) compared to kernel 2.4.25 from denx, made
with "nbench". The results are quite interesting, and contradicting
(older) benchmark results, Wolfgang made a few months back:

kernel-2.6.14-git-20051107:
---------------------------
TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          32.654  :       0.84  :       0.28
STRING SORT         :          1.7408  :       0.78  :       0.12
BITFIELD            :      8.3466e+06  :       1.43  :       0.30
FP EMULATION        :           3.506  :       1.68  :       0.39
IDEA                :           115.3  :       1.76  :       0.52
HUFFMAN             :          27.855  :       0.77  :       0.25
LU DECOMPOSITION    :         0.35932  :       0.02  :       0.01

kernel-2.4.25-devel-denx:
-------------------------
TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          30.438  :       0.78  :       0.26
STRING SORT         :          1.5842  :       0.71  :       0.11
BITFIELD            :      7.9506e+06  :       1.36  :       0.28
FP EMULATION        :           3.258  :       1.56  :       0.36
IDEA                :          108.89  :       1.67  :       0.49
HUFFMAN             :          26.281  :       0.73  :       0.23
LU DECOMPOSITION    :         0.32765  :       0.02  :       0.01

This is all on the same hardware: MPC852T + 32Mbyte SDRAM running from
NFS. kernel 2.6 is faster all the way through!!
The results so far are pretty encouraging I'd say. Maybe something like
lmbench would help to shed more light on details important for kernel
testing, like context-switch overhead, mm, etc...
Nbench is quite useless here (a single task doing all sorts of nonsense,
almost no critical syscalls), but that's what makes the enormous
differences even more remarkable IMO. Maybe something is broken in 2.4?

Greetings,

-- 
David Jander
