Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 1731667B52
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 15:50:49 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so1838118nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 22:50:47 -0700 (PDT)
Message-ID: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
Date: Sat, 12 Aug 2006 01:50:47 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: PowerPC paxtest results w/ gcc-4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just ran paxtest on a Mac G4 Cube. Ouch. The results are shameful.
Does nobody care to fix this? (well heck, the patched firefox isn't
showing up via aptitude yet, and my browser just died a horrible
and unexpected death involving a pop-up ad, so I guess not!)

I suppose part of the problem is that paxtest requires serious
hacking to work right on PowerPC. Critical fixes are:

1. unnest the dummy() function (PaX marketing bullshit)
2. change the return opcode (see code below)
3. flush the cache as needed (see code below)
4. use the Makefile-portable that Gentoo has
5. compile with "-W -Wall -fno-strict-aliasing" and fix warnings

With all that done, gasp in horror at the truth:

Linux cube 2.6.17-rc5 #1 PREEMPT Sat May 27 20:35:12 EDT 2006 ppc GNU/Linux
Executable anonymous mapping             : Vulnerable
Executable bss                           : Vulnerable
Executable data                          : Vulnerable
Executable heap                          : Vulnerable
Executable stack                         : Vulnerable
Executable anonymous mapping (mprotect)  : Vulnerable
Executable bss (mprotect)                : Vulnerable
Executable data (mprotect)               : Vulnerable
Executable heap (mprotect)               : Vulnerable
Executable stack (mprotect)              : Vulnerable
Executable shared library bss (mprotect) : Vulnerable
Executable shared library data (mprotect): Vulnerable
Writable text segments                   : Vulnerable
Anonymous mapping randomisation test     : No randomisation
Heap randomisation test (ET_EXEC)        : No randomisation
Heap randomisation test (ET_DYN)         : No randomisation
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : No randomisation
Shared library randomisation test        : No randomisation
Stack randomisation test (SEGMEXEC)      : 11 bits (guessed)
Stack randomisation test (PAGEEXEC)      : 11 bits (guessed)
Return to function (strcpy)              : paxtest: bad luck
Return to function (memcpy)              : Vulnerable
Return to function (strcpy, RANDEXEC)    : paxtest: bad luck
Return to function (memcpy, RANDEXEC)    : Vulnerable
Executable shared library bss            : Vulnerable
Executable shared library data           : Vulnerable

About the only saving grace is that the attacker would have
to get lucky with the cache if they need code executed.

Look, it's not as if we get closed-source binaries on PowerPC
anyway. Non-free isn't the Debian way either. Screw the ABI.
We need a fail-safe (enabled by default) fix for this.

///////// code added to the top of paxtest body.h //////////
// use this code in the obvious way
#if defined(__ppc__) || defined(__powerpc__)
#define RET 0x4e800020     // "blr" or "bclr 20,0"
#define FLUSH(x) __asm__ __volatile__(\
  "dcbf 0,%0  ;  sync  ; icbi 0,%0  ; sync  ;  isync  ; sync" \
  :                        \
  : "r" (x)                \
  : "memory"              \
)
#endif

#if defined(__i386__) || defined(__x86_64__)
#define RET 0xc3c3c3c3     // ret ret ret ret
#define FLUSH(x)
#endif

#include <string.h>
///////////////////////////////////////////////////////////
