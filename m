To: nunninger@web.de
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Switching on virtual adresses -> TLB miss -> break 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Mar 2001 16:15:47 +0100."
             <3A9E75B3.23216.ABFCB3D@localhost>
Date: Thu, 01 Mar 2001 17:34:29 +0100
Message-Id: <20010301163434.EA99A2881E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A9E75B3.23216.ABFCB3D@localhost> Stefan wrote:
>
> I got a problem running linux on a custom MPC860 board for which
> I hope somebody knows a solution. I'm using linux 2.2.14 from
> Montavista.
>
> My code arrives at the point in /kernel/head.S where virtual address
> translation is switched on.

This is a FAQ!!! Did you bother to check the archive?
Did you initialize DER to a useful value like 0x2002000f ?

...
> I found this using the debugger of VisionClick. By now I switched to

Vision* does not understand virtual addresses. You cannot use it once
Linux has turned on the MMU. There is no MMU support  available  now,
nor has WRS any plans to add it in the near future.

> BDM4GDB. However with GDB I can not verify wheter these
> instruction work or not as I don't get propper symbol information in
> the assembler files. However no matter which debugger I'm using

Why not? This works fine for me...

> the code stops in the exception described above.

...probaly you just think  it  stops,  while  in  fact  you  did  not
initialize DER correctly.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Deliver yesterday, code today, think tomorrow."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
