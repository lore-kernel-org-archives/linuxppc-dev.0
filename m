MIME-Version: 1.0
Message-Id: <39275EFF.14793@mta2>
Date: Sun, 21 May 2000 11:58:55 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: my port problem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>zzh wrote:
>
>> 0x00200000 0x002e0f77 'vmlinux'
>> 0x002e0f78 0x002e0f94 board information
>> 0x00000000 0x000d0f94 relocated vmlinux and board info
>> 0x00c00000 0x01000000 relocated initrd
>> (0x0000000c)(0x000d0f78, 0x00c00000, 0x00400000, 0x00000000, 0x00000000)
>
>I don't know where these came from.  I guess someone modified misc.c?
>I don't know what they indicate, either.
>
I choose to not uncompressing kernel.I modified 8xxrom to load vmlinux
and initrd.
Memory layout is : 0x0-0xd0f94 vmlinux+bdinfo
                   0xc00000-0x1000000 initrd
>> Total Memoty = 16MB;unsing 64kb for hash table (at c00d0000).
>> Linux version 2.2.11.......
>> Boot arguments:
>> Calibrating delay loop...14.44 BogoMIPS
>> remove_mem_piece: bad overlap [c8000,f4000) with [c8000, d0000) [e0000, 1000000)
>
I will check this.maybe this is the reason.
>Don't messages like this get your attention?  Something is wrong with
>the memory map, board information structure, or where you loaded the
>software kernel and ram disk.
>
>>
>> Memory: 15408k available (552k kernel code, 396k data, 28k init) [c0000000,c1000
>> 000]
>> DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
>> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
>> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
>> POSIX conformance testing by UNIFIX
>> Linux NET4.0 for Linux 2.2
>> Based upon Sw<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
>> NET4: Linux TCP/IP 1.0 for NET4.0
>> IP Protocols: ICMP, UDP, TCP
>> TCP: Hash tables configured (ehash 16384 bhash 16384)
>> Starting kswapd v 1.5
>> CPM UART driver version 0.02
>> ttyS00 at 0x0100 is a SCC        //i use scc2 as ttyS0
>
>Really?  So, you modified arch/ppc/mbxboot/m8260_tty.c to use an SCC?
>You have to make lots of changes to use SCC as a console.  I don't have
>any board that uses the SCC for a serial port (easily, without some
>hardware hacking), so I haven't tried this.
>
>
Why? Because motorola ads board has no smc,so i modified 8xxio/uart.c
.I seems to me that scc can be used as a console and ttyS0 simulataneously.
I cannot find 8260 stuff in kernel.org when i began this port,
now i have pre7,should i read it?I know it is done on a EST board.
>> Warning: unable to open an initial console.
>> /*open("/dev/console",...);*/
>
>Not surprised if this is an SCC.  You have some work to contribute :-).
Explain to me why.rs_8xx_open not get called although i registered
it as c 4 64
>
>
>	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
