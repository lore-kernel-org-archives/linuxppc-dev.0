To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Oct 2003 10:52:17 BST."
             <DEF39A0710293E489D45B10E06645CBD0243B1A7@dub-msx1.spectelcorp.com>
Date: Thu, 09 Oct 2003 14:38:07 +0200
Message-Id: <20031009123812.E439CC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD0243B1A7@dub-msx1.spectelcorp.com> you wrote:
>
> I am trying to boot the ppc kernel on a MPC8260 based custom board.
...
> One of the doubts that I have is that when I look into the system.map file, it shows that the start address is at 0xc0000000 (as shown below)
>
> c0000000 T _start

Yes, this is the correct kernel virtual address.

> To the best of my knowledge the kernel image is not relocatable, so I am wondering if this could be my problem or just one of them ...
> Should the map file be showing
>
> 00000000 T _start

No!!!

> If so, where should I change the .text address so that that happens ?

Don't change anything!

> I am also trying to debug the code from that address with gdb/BDI2000, but I am not getting very far.
> Basically I can see the program counter incrementing when I single step, but I cannot see the source even though I am trying to load the symbol table at 0x00000000 with the  'add-symbol-file vmlinux 0x00000000' gdb command, after invoking gdb from the k
> ernel base directory (where vmlinux is)

Just use the vmlinux file _without_ relocating  any  addresses.  Make
sure  to  enable  "MMU  XLAT"  and define "PTBASE" in your BDI config
file.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If people are good only because they fear punishment, and  hope  for
reward, then we are a sorry lot indeed."            - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
