Message-ID: <3E365DA5.7060201@elitedvb.net>
Date: Tue, 28 Jan 2003 11:38:29 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: C++ Library recommendations ...
References: <200301280810.JAA19807@hzsms01.nl.lucent.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jaap-Jan Boor wrote:
> I just use libstd++ coming with gnu g++, it's not too big (shared ~300k)
> compared to glibc (shared ~1.2 M)

problem is that the STL is a template library, so a lot of code is
produced when using these tamplates.

i highly recommend to use normal lists and cast pointers (like in good
old C times) again, even with the need of allocating two chunks per list
item (pointer and data itself).
Using STL makes your application MUCH bigger, and, often slower.
STL is optimized for huge data structures, but for most things
memcpy'ing (and using for example an array/vector) is much faster than
using a list or hash, which has optimal - for example linear or even log
- complexity. The thing the STL guy forgot is to keep in mind than
1000*linear (list insertions... ) is still worse than 1*exp (memcpy when
doing vector insertions... but take this only as an example) when your
list has, for example, 5 entries.

and most of the lists are NOT accessed ten thousand times, do NOT have
one million entries where 1000*linear is a LOT more than 1*exp complexity.

just my 2 cent...

felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
