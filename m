From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109222006.f8MK6gG71984@saturn.cs.uml.edu>
Subject: Re: ppc LE questions (seeking help hand info pointers)
To: hobold@Informatik.Uni-Bremen.DE
Date: Sat, 22 Sep 2001 16:06:42 -0400 (EDT)
Cc: linuxppc-dev@lists.linuxppc.org, dan@mvista.com,
	nicoya@apia.dhs.org
In-Reply-To: <p05100302b7d16386402f@[10.0.0.42]> from "Timothy A. Seufert" at Sep 21, 2001 05:22:29 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger Bettag writes:
>"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

>> Now do an unconditional 64-bit byte swap on the motherboard.
>> Consider an array of four __u16 values affected by this.
>> They get converted from big-endian to little-endian, and they
>> get moved to different addresses. Excellent! All the weirdness
>> just cancels out, giving perfect little-endian. This works for
>> 8-bit, 16-bit, 32-bit, and 64-bit data. Life is good.
>
> Does it work for 128 bit data? The 74x0's most promiment feature,
> AltiVec, would expose a strange mixed endianness to programmers
> otherwise.

Yes. Motorola noticed this problem, and added a built-in swap
to fix the problem. See page 3-6, section 3.1.4, figure 3-5 in
ALTIVECPEM.pdf, the "AltiVec Technology Programming Environments
Manual". Unaligned vectors don't work in big-endian or little-endian
mode, and the code needed to load them is equally long.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
