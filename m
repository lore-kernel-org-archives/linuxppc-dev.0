Date: Wed, 8 Dec 1999 16:45:22 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: PPC Cache Flush and Invalidate Routines
Message-ID: <Pine.SGI.4.10.9912081623090.145056-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In trying to accomodate the 4xx-based code into the Linux kernel, I've
encountered an issue which relates to the cache flushing and invalidation
routines in misc.S.

Among the 4xx-based processors, the 403s have 16 byte cache lines and the
405s have 32 byte cache lines. Among the 8xx processors, all appear to
have 16 byte cache lines. All the rest seem to have 32 byte cache lines.

There are several solutions here:

 - Use ifdef's as is done at present.

 - Check the PVR on entry to each of these routines and "do the right
   thing".

 - Set global variables ppc_cache_linesize and ppc_cache_lineshift
   somewhere in MMU_init or setup_arch which then get loaded in the cache
   routines.

The first option keeps the code small and fast, but doesn't easily cover
the dichotomy between the line sizes in 403 and 405 with a simple
CONFIG_4xx.

The second option incurs a lot of unnecessary overhead per invocation of
the routines and adds a lot of special-case code to each routine.

The final option seems the best compromise, increasing kernel memory usage
by 8 bytes and adding a little code to load the values of
ppc_cache_line{size,shift}. All the overhead is then left to a one time
invocation in MMU_init or setup_arch.

Thoughts, opinions?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
