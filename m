Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Using BDI-2000 to debug kernel 
Date: Thu, 13 Mar 2003 17:23:40 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNEEEGCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20030313211750.1365EC58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using an app note that came with the
BDI-2000.  The app note is Number 02-001.

Unless the app note is completely wrong then I am missing something.
The steps I take depicted below are exactly the same as in the
app note.

Jerry

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Thursday, March 13, 2003 4:18 PM
To: jwalden@digitalatlantic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using BDI-2000 to debug kernel



In message <EGEGIJHKDKJGAJMGIDPNKEEBCJAA.jwalden@digitalatlantic.com> you
wrote:
>
> I am having a strange problem trying to single step through the kernel.

Maybe this is because you are doing strange things? ;-)

> BDI>md 0x00210000
> 00210000 : 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378  |..x|.#x|.+x|.3x
> 00210010 : 7cfb3b78 3b000000 48002359 38001032  |.;x;...H.#Y8..2
...


Why did you load the kernel at this address? You are aware  that  the
Linux kernel expects to be loaded to asnd started at 0x0 ?

> I disassembled head_4xx.o and so far this looks fine:
> head_4xx.o:     file format elf32-powerpc
>
> Disassembly of section .text:
>
> 00000000 <_start>:
>        0:	7c 7f 1b 78 	mr	r31,r3
>        4:	7c 9e 23 78 	mr	r30,r4
>        8:	7c bd 2b 78 	mr	r29,r5
>        c:	7c dc 33 78 	mr	r28,r6
>       10:	7c fb 3b 78 	mr	r27,r7
>       14:	3b 00 00 00 	li	r24,0
>       18:	48 00 23 59 	bl	2370 <initial_mmu>

You disassembled this code. Pleasy try to understand what it does! It
start's saving some registers  (r3...r7).  Guess  why?  Because  they
contain  parameters  that  must  be passed to the Linux kernel. For a
description of the parameters see "arch/ppc/kernel/head_4xx.S".

> BDI>go

What makes you think you can start a Linux kernel by just jumping  to
it at a random address, without passing correct arguments to it?

> I get an exception indicating that an invalid opcode was fetched.
> I can't figure out what to try next - Any ideas?

Use a boot loader to start the Linux kernel - this  way  you  can  be
sure  that  the  kernel  gets loaded to the correct address, that the
registers contain the correct arguments, etc.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The use of anthropomorphic terminology when  dealing  with  computing
systems is a symptom of professional immaturity.   -- Edsger Dijkstra


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
