Message-Id: <4.3.1.2.20000515180711.00b82540@mail.munich.netsurf.de>
Date: Mon, 15 May 2000 18:08:57 +0200
To: toa@pop.agri.ch
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: ppc assembler help needed
Cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <39201DA7.96674A96@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:54 15.05.00, Andreas Tobler wrote:

>Hi,
>
>I have some problems understanding the following code snippet. It is
>from misc.S in kernel 2.3.
>
>The function call is like this:
>
>void _insl_ns(volatile u32 *port, u32 *buf, int nl)
>
>_GLOBAL(_insl_ns)
>         cmpw  0,r5,0
>         mtctr   r5
>         subi    r4,r4,4
>         blelr-
>00:     lwz     r5,0(r3)
>         eieio
>         stwu    r5,4(r4)
>         bdnz    00b
>         blr
>
>Am I right with port = r3, buf = r4, nl = r5?
>If so, cmpw 0,r5,0 compares the content of r5, in my case nl, with zero
>and stores the result in CR0?

No, cmpw 0,r5,0 compares r5 to r0, use cmpwi 0,r5,0 to make a signed
compare of r5 against 0

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
