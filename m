Message-ID: <39201DA7.96674A96@pop.agri.ch>
Date: Mon, 15 May 2000 17:54:28 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: ppc assembler help needed
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have some problems understanding the following code snippet. It is
from misc.S in kernel 2.3.

The function call is like this:

void _insl_ns(volatile u32 *port, u32 *buf, int nl)

_GLOBAL(_insl_ns)
        cmpw  0,r5,0
        mtctr   r5
        subi    r4,r4,4
        blelr-
00:     lwz     r5,0(r3)
        eieio
        stwu    r5,4(r4)
        bdnz    00b
        blr

Am I right with port = r3, buf = r4, nl = r5?
If so, cmpw 0,r5,0 compares the content of r5, in my case nl, with zero
and stores the result in CR0?

What does blelr- exactly do? 'branch if less than or equal' according to
the 'Programming Environment for 32bit uPs' from Motorola.
Commenting out the cmpw and the blelr- line as in kernel-2.2, then the
function works. The values from nl are in the range from 10 to 20 (int).
So the the blelr- shouldn't happen.

The function in C looks a bit like: (Thanks to Paul)

void _insl_ns(volatile u32 *port, u32 *buf, int nl)
{
        if (nl <= 0)
                return;
        do {
                *buf++ = *port;
                eieio();
        } while (--nl != 0);
}

Thanks for any explanation

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
