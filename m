Date: Sat, 15 Nov 2003 23:37:06 +0100
From: Olaf Hering <olh@suse.de>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
Message-ID: <20031115223706.GA15879@suse.de>
References: <20031115210449.GA10105@suse.de> <20031115222430.GA13820@suse.de> <200311152230.hAFMUwT32990@makai.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200311152230.hAFMUwT32990@makai.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Nov 15, David Edelsohn wrote:

> >>>>> Olaf Hering writes:
>
> Olaf> 2.6 has a function parse_header(), its part of gunzip and used for
> Olaf> initramfs as example. I got an oops, exception 600, sig 7. I think that
> Olaf> means unaligned access.
>
> Olaf> +               memcpy(buf, s, 7 + j); /* s might be unaligned, gcc will optimized the call to lswi on ppc */
>
> 	lswi specifically accepts unaligned addresses.

Thanks. Then the bug is somewhere else, because it crashes like this if
I use '8' instead of '7 + j' (no memcpy call):

Calibrating delay loop... 89.49 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Serial port locked ON by debugger !
vector: 600 at pc = c025bf14, lr = c025bf20
msr = 9030, sp = c02598c0 [c0259810]
dar = c043cffa, dsisr = a53f
current = c02191c8, pid = 0, comm = swapper
mon> di c025bf14
c025bf14  7d3f44aa      lswi    r9,r31,8
c025bf18  7d3c45aa      stswi   r9,r28,8
c025bf1c  4be62ee1      bl      0xc00bedfc
c025bf20  2c1e000b      cmpwi   r30,11
c025bf24  3bff0008      addi    r31,r31,8
c025bf28  7c7dd92e      stwx    r3,r29,r27
c025bf2c  4081ffd4      ble     0xc025bf00
c025bf30  8001002c      lwz     r0,44(r1)
c025bf34  81210030      lwz     r9,48(r1)
c025bf38  5400a016      rlwinm  r0,r0,20,0,11
c025bf3c  81610008      lwz     r11,8(r1)
c025bf40  7c004b78      or      r0,r0,r9
c025bf44  5409a32e      rlwinm  r9,r0,20,12,23
c025bf48  540a063e      clrlwi  r10,r0,24
c025bf4c  7d4a4b78      or      r10,r10,r9
c025bf50  54006016      rlwinm  r0,r0,12,0,11
mon> r
R00 = 00000008   R01 = c02598c0   R02 = c02191c8   R03 = c02598f8
R04 = 00000000   R05 = 00000010   R06 = c043cfb1   R07 = 00000001
R08 = 00000000   R09 = c02224f4   R10 = ffffffd0   R11 = 00000000
R12 = 00014fac   R13 = deadbeef   R14 = deadbeef   R15 = deadbeef
R16 = deadbeef   R17 = deadbeef   R18 = deadbeef   R19 = deadbeef
R20 = 0000003f   R21 = 000001ff   R22 = c47f1408   R23 = c032e008
R24 = 00000006   R25 = 00000009   R26 = 0000000f   R27 = c02598c8
R28 = c02598f8   R29 = 00000024   R30 = 0000000a   R31 = c043cffa
pc  = c025bf14   msr = 00009030   lr  = c025bf20   cr  = 95000053
ctr = 00000000   xer = c000be6f   trap =  600
mon>


pmac 7200/90 with 601 cpu.


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
