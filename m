Message-ID: <392540BE.B5365308@embeddededge.com>
Date: Fri, 19 May 2000 09:25:18 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: zzh <david-1z@263.net>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: my port problem
References: <3924D822.22874@mta2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zzh wrote:

> 0x00200000 0x002e0f77 'vmlinux'
> 0x002e0f78 0x002e0f94 board information
> 0x00000000 0x000d0f94 relocated vmlinux and board info
> 0x00c00000 0x01000000 relocated initrd
> (0x0000000c)(0x000d0f78, 0x00c00000, 0x00400000, 0x00000000, 0x00000000)

I don't know where these came from.  I guess someone modified misc.c?
I don't know what they indicate, either.

> Total Memoty = 16MB;unsing 64kb for hash table (at c00d0000).
> Linux version 2.2.11.......
> Boot arguments:
> Calibrating delay loop...14.44 BogoMIPS
> remove_mem_piece: bad overlap [c8000,f4000) with [c8000, d0000) [e0000, 1000000)

Don't messages like this get your attention?  Something is wrong with
the memory map, board information structure, or where you loaded the
software kernel and ram disk.

>
> Memory: 15408k available (552k kernel code, 396k data, 28k init) [c0000000,c1000
> 000]
> DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.2
> Based upon Sw<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> TCP: Hash tables configured (ehash 16384 bhash 16384)
> Starting kswapd v 1.5
> CPM UART driver version 0.02
> ttyS00 at 0x0100 is a SCC        //i use scc2 as ttyS0

Really?  So, you modified arch/ppc/mbxboot/m8260_tty.c to use an SCC?
You have to make lots of changes to use SCC as a console.  I don't have
any board that uses the SCC for a serial port (easily, without some
hardware hacking), so I haven't tried this.


> Warning: unable to open an initial console.
> /*open("/dev/console",...);*/

Not surprised if this is an SCC.  You have some work to contribute :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
