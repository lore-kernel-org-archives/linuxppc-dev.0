In-Reply-To: <20040601173804.04313C109F@atlas.denx.de>
Subject: no core dump from the kernel on SIGSEGV
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF256E275C.8F4C3907-ON85256EA6.006EE439-85256EA6.006FEE36@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Tue, 1 Jun 2004 16:22:34 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm looking at making the kernel core dump on a process that seg vaulted.
What I did was recompiled the kernel specifying a non-zero core file size
rlim[RLIMIT_CORE] = { RLIM_INFINITY, RLIM_INFINITY }.  I was still not
getting a core dump.

The following test program was used to signal a seg vault (SIGSEGV).

#include <stdio.h>

int main(int argc, char** argv) {

        unsigned int* pointer = (unsigned int*) 0x12345678;

        /* generate a SIGSEGV - invalid memory reference */
        *pointer = 0xdeadbeef;

        return 0;
}

Anyone can shred some light on this?

Thanks a lot,
David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
