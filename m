Message-ID: <B162270C965FD511AB9600B0D0B0AB42064671@NAPA>
From: Hua Ji <hji@netscreen.com>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: paulus@samba.org
Subject: An interesting issue about ppc 750 page table.
Date: Tue, 24 Jul 2001 11:50:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I worked on my ppc 750 CPU, I set up a 32M page table to cover all 4G
mapping, which is recommended by PPC Manual Chapter 7--Memory Management
Page 7-52.

I suddently realized/found, actually only 8M is used for covering the whole
4G mapping. The first primary one uses 4M; and the second primary uses
another 4M.

In other words,  (8M / the size of per PTE entry) * 4K = (8M/8)*4k=4G.

And all the other (32-8) M page table space actually is NOT used and get
wasted. Very interesting to me.

Therefore, I am wondering that we can use this below approach, instead of
the recommended one in PPC Specification.

For covering 4G memory, for example, you ONLY need reserve 8M space.

* The first 4M HAVE TO be 32M aligned //This is required

* Put the second 4M to the location cacluated by the secondar Hash function.

And then all set.

For example (my current setting).

Page Table Base: 0x0800 0000  (128M Edge so that 32M aligned)

Thus, the first 4M for holding all **primary hash* values are :
from  0x0800 0000 to 0x083F FFFF

With second hash function, we can easily know that the start of the
secondary hash space is
from 0x09C0 0000 to 0x09FF FFFF

Therefore, you do NOT have to reserve the space between 0x0840 0000 to
0x09BF FFFF and can use them for other purposes.

Data Testing:

The last Primary Hash Group Entry:

083fffc0: 80 00 00 3f 0f ff f0 22  80 00 00 bf 1f ff e0 22   ...?..."
......."
083fffd0: 80 00 01 3f 2f ff d0 22  80 00 01 bf 3f ff c0 22   ...?/.."
....?.."
083fffe0: 80 00 02 3f 4f ff b0 22  80 00 02 bf 5f ff a0 22   ...?O.."
...._.."
083ffff0: 80 00 03 3f 6f ff 90 22  80 00 03 bf 7f ff 80 22   ...?o.."
......."
08400000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........
........
08400010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
// Note that, after 0x08400000, the memory is not used, or no any primary
hash PTE will be mapped to that area.

The first Secondar Hash Group Entry:

09bfffe0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........
........
09bffff0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   ........
........
09c00000: 80 00 04 7f 8f ff 70 42  80 00 04 ff 9f ff 60 42   ......pB
......`B
09c00010: 80 00 05 7f af ff 50 42  80 00 05 ff bf ff 40 42   ......PB
......@B
09c00020: 80 00 06 7f cf ff 30 42  80 00 06 ff df ff 20 42   ......0B
.......B
09c00030: 80 00 07 7f ef ff 10 42  80 00 07 ff ff ff 00 22   .......B
.......
// Note that, before 0x9c000000, the memory is not used, or no any secondar
hash PTE will be mapped to that area

We can easily extend this to cases in which the page table size are 4M, 8M
and 16M.

Conclusion: For setting up page table, you don't have to reserve the whole
space. Otherwise, waste memory.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
