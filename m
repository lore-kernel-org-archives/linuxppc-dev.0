From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBD21@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with parse_bootinfo on a Board with 2Mb of SRAM
Date: Tue, 6 May 2003 19:40:51 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

I am trying to start Linux with a custom board.
This board has only 2Mb of SRAM.

Linux crashes in the function parse_bootinfo.

In my Systemp.map I have got __bss_start == 0xc0091000

In parse_bootinfo I have :

rec = ( struct bi_record *)_Align((ulong)__bss_start+(1<<20)-1, 1<<20))

So rec equals 0xc0200000

and then

if (rec->tag != BI_FIRST )

but this line crashes because it tries to access 0xc0200000 whereas my sram
is between 0xc0000000 and 0xc01fffff.

Does it means that I have'nt got enough memory to run Linux on this board ?

I tried to comment this line but Linux go into panic() in the function
mem_pieces_find().

Any idea ?

Thanks.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
