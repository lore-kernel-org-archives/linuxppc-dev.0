Message-ID: <3CB6B3D7.8030007@poczta.onet.pl>
Date: Fri, 12 Apr 2002 12:15:51 +0200
From: Krzysztof Jankowski <kjankow@poczta.onet.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: early stage boot progress indication
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm pretty new to PPC but I was following this newsgroup for some time.
I've got PPC405 on a custom design board and I'd like to debug the reason why my
linux kernel doesn't work on it. I've downloaded the latest kernel sources
(2.4-devel) so there is no problem with missing or broken 405 support on it.
I wanted to use UART0 for debugging purposes, so I've created simple C function
sending a character to a physical PLB address of UART0 (this function doesn't use
stack for sure, a character to be send is being passed via R3). I'm accessing
physical memory using writel() and readl() macros. The idea seems to be OK.

I put a few my function calls into head_4xx.S file and everything seems to work (I
could see characters on minicom) till the kernel started to execute after
'start_here' label. I know that at this stage kernel's addresses were remapped
from 0x0000xxxx to 0xc000xxxx (am I right?) due MMU being enabled by
'turn_on_mmu'. So I remapped UART's memory space by 'io_block_mapping' - but this
didn't help.

What's going on ? Why I'm not seeing characters now ? Did the kernel hang
somewhere in the middle or am I tottaly wrong in the early debugging idea ?

Thanks for any help,
Krzysztof



--
Encyklopedia multimedialna w prezencie!
http://www.e-mail.onet.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
