Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-33.bluehost.com (outbound-mail-33.bluehost.com
	[70.96.188.153]) by ozlabs.org (Postfix) with SMTP id 09BA46893D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 08:09:02 +1100 (EST)
Message-ID: <43CEAE65.8060106@secretlab.ca>
Date: Wed, 18 Jan 2006 14:08:53 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: inconsistent gdbserver behaviour on Virtex-4
References: <43CEA971.6050409@secretlab.ca>
In-Reply-To: <43CEA971.6050409@secretlab.ca>
Content-Type: multipart/mixed; boundary="------------070609060603090408060408"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070609060603090408060408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, wrong log file; correct one now attached.

Grant Likely wrote:
> I need some help;
> 
> I'm seeing odd inconsistent behaviour when debugging userspace on a 
> Virtex-4 (don't yet know if it's a gdbserver or kernel issue).
> 
> Here's the scenario:
> 
> - tested on kernel versions: 2.6.15, 2.6.16-rc1  both w/ ml403 patches
> - tested with gdb versions 6.1, 6.3 & 6.4
> - root file system contains: busybox-1.01, glibc-2.3.5, gdbserver
> - gcc version: 3.4.4 compiled with crosstool-0.38
> - BDI *not* attached, and CONFIG_BDI_SWITCH is *not set*
> 
> simple hello.c compiled for the target.  Program loops 20 times over 
> some printf's and simple math.
> 
> On target, I start the program with:
> $ gdbserver 192.168.0.37:2345 ./hello
> Process ./hello created; pid = 268
> Listening on port 2345
> 
> On the host, I connect gdb and set a breakpoint at main(), and at two 
> places in the loop.
> 
> Whenever I continue (c), I see one of the following behaviours (randomly 
> it seems):
> 
> 1. gdb stops exactly where it started from.  ie. no code gets executed,
> 2. continue behaves properly, and execution stops at the next 
> breakpoint, or
> 3. the program runs to completion, and no other breakpoints get hit. 
> program exits normally
> 
> When I do a single instruction step (si), I see either:
> 1. the pc does not move, or
> 2. the program runs freely until the next breakpoint.
> 
> I've attached a gdb log with 'set debug remote 1' turned on.  It looks 
> to me that the kernel single step support is still busted on my board. 
> It also seems to be that gdb single steps off of the previous breakpoint 
> before reestablishing all the breakpoints and letting the process run 
> again.  Therefore, if single step is busted, then it makes sense that 
> continue is busted to.
> 
> Any help would be appreciated.
> 
> Thanks,
> g.
> 
> 

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761

--------------070609060603090408060408
Content-Type: text/x-log;
 name="gdb.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb.log"

GNU gdb 6.4
Copyright 2005 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=x86_64-unknown-linux-gnu --target=powerpc-405-linux-gnu"...
(gdb) target remote 192.168.0.36 7:2345
Remote debugging using 192.168.0.37:2345
0x3000fa18 in ?? ()
warning: Unable to find dynamic linker breakpoint function.
GDB will be unable to debug shared library initializers
and track explicitly loaded dynamic code.
(gdb) br main
Breakpoint 1 at 0x100004c0: file hello.c, line 7.
(gdb) c
Continuing.
Error while mapping shared library sections:
/lib/ld.so.1: No such file or directory.
Error while reading shared library symbols:
/lib/ld.so.1: No such file or directory.

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) 
Continuing.

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) set debug remote 1
(gdb) list
2	
3	int
4	main (void)
5	{
6	    int i, j, k;
7	    setvbuf(stdout, NULL, _IONBF, 0);
8	    printf("Hello, world!\n");
9	
10	    j = 100; k=0;
11	    for (i = 0; i< 20; i++) {
(gdb) 
12	        printf("   i=%i j=%i k=%i\n", i, j, k);
13	        j += 4*i;
14	        k -= j/(i+1);
15	        printf("checkpoint\n", i, j, k);
16	    }
17	
18	    printf("done!\n", i, j);
19	
20	    return 0;
21	}
(gdb) br 13
Breakpoint 2 at 0x10000520: file hello.c, line 13.
(gdb) br 15
Breakpoint 3 at 0x10000550: file hello.c, line 15.
(gdb) x/x $pc
Sending packet: $m100004ac,4#b6...Ack
Packet received: 9421ffe0
Sending packet: $m100004b0,4#84...Ack
Packet received: 7c0802a6
Sending packet: $m100004b4,4#88...Ack
Packet received: 93e1001c
Sending packet: $m100004b8,4#8c...Ack
Packet received: 90010024
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m7ffa3da0,4#59...Ack
Packet received: 7ffa3dc0
Sending packet: $Hg0#df...Ack
Packet received: E01
Sending packet: $p1f#07...Ack
Packet received: 
Sending packet: $g#67...Ack
Packet received: 0fec312c7ffa3da030012b00000000017ffa3e247ffa3e2c7ffa3e5c100005b0100006480ffed2747ffa3e10000000000000000110018ab8ffff0000ffff0000ffffffffffff0000ffff00007f83aa100000000010071a0c7f83aa2810071a1c00000000100004ac7ffa3e5c00000001100005b07ffa3e240ffeace47ffa3da000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100004c00002d030220002220fec312c0fec31300000000000000000
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
0x100004c0 <main+20>:	0x3d201001
(gdb) si
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004ac,4#b6...Ack
Packet received: 9421ffe0
Sending packet: $m100004b0,4#84...Ack
Packet received: 7c0802a6
Sending packet: $m100004b4,4#88...Ack
Packet received: 93e1001c
Sending packet: $m100004b8,4#8c...Ack
Packet received: 90010024
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m7ffa3da0,4#59...Ack
Packet received: 7ffa3dc0
Sending packet: $g#67...Ack
Packet received: 0fec312c7ffa3da030012b00000000017ffa3e247ffa3e2c7ffa3e5c100005b0100006480ffed2747ffa3e10000000000000000110018ab8ffff0000ffff0000ffffffffffff0000ffff00007f83aa100000000010071a0c7f83aa2810071a1c00000000100004ac7ffa3e5c00000001100005b07ffa3e240ffeace47ffa3da000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100004c00002d230220002220fec312c0fec31300000000000000000
Sending packet: $m7ffa3dc4,4#5f...Ack
Packet received: 0fec312c
Sending packet: $mfec312c,4#f4...Ack
Packet received: 4801918d
Sending packet: $mfec3128,4#c9...Ack
Packet received: 4e800021
Sending packet: $mfec312c,4#f4...Ack
Packet received: 4801918d
Sending packet: $mfec3128,4#c9...Ack
Packet received: 4e800021
Sending packet: $mfec2f30,4#f6...Ack
Packet received: 93c10018
Sending packet: $mfec2f34,4#fa...Ack
Packet received: 93e1001c
Sending packet: $mfec2f38,4#fe...Ack
Packet received: 90010024
Sending packet: $mfec2f3c,4#29...Ack
Packet received: 48127da5
Sending packet: $m7ffa3dc0,4#5b...Ack
Packet received: 7ffa3df0
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) x/x $pc
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
0x100004c0 <main+20>:	0x3d201001
(gdb) c
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) c
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) c
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) c
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) c
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) 
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) 
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:100004c0;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $m100004bc,4#b7...Ack
Packet received: 7c3f0b78

Breakpoint 1, main () at hello.c:7
7	    setvbuf(stdout, NULL, _IONBF, 0);
(gdb) 
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:100004c4;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: T0501:7ffa3da0;40:10000520;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7d821008
Sending packet: $M10000328,4:7c290b78#7b...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 7d821008
Sending packet: $M100004c0,4:3d201001#5a...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 7d821008
Sending packet: $M10000520,4:801f0008#36...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 7d821008
Sending packet: $M10000550,4:3d201000#2c...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $m1000051c,4#87...Ack
Packet received: 480105f9
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $m1000051c,4#87...Ack
Packet received: 480105f9

Breakpoint 2, main () at hello.c:13
13	        j += 4*i;
(gdb) 
Continuing.
Sending packet: $vCont;s#b8...Ack
Packet received: T0501:7ffa3da0;40:10000524;
Sending packet: $m10000328,4#5b...Ack
Packet received: 7c290b78
Sending packet: $M10000328,4:7d821008#43...Ack
Packet received: OK
Sending packet: $m100004c0,4#85...Ack
Packet received: 3d201001
Sending packet: $M100004c0,4:7d821008#6d...Ack
Packet received: OK
Sending packet: $m10000520,4#55...Ack
Packet received: 801f0008
Sending packet: $M10000520,4:7d821008#3d...Ack
Packet received: OK
Sending packet: $m10000550,4#58...Ack
Packet received: 3d201000
Sending packet: $M10000550,4:7d821008#40...Ack
Packet received: OK
Sending packet: $vCont;c#a8...Ack
Packet received: W00

Program exited normally.
(gdb) quit

--------------070609060603090408060408--
