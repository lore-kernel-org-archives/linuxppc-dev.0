Mime-Version: 1.0
Message-Id: <p05100301b7d2a21bdfe1@[10.0.0.42]>
In-Reply-To: <8xu1xvi9sf.fsf@s63.informatik.uni-bremen.de>
References: <200109211848.f8LImlT19616@saturn.cs.uml.edu>
 <8xu1xvi9sf.fsf@s63.informatik.uni-bremen.de>
Date: Sat, 22 Sep 2001 13:26:58 -0700
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:23 PM +0200 9/22/01, Holger Bettag wrote:
>"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
>
>[...]
>>  Now do an unconditional 64-bit byte swap on the motherboard.
>>  Consider an array of four __u16 values affected by this.
>>  They get converted from big-endian to little-endian, and they
>>  get moved to different addresses. Excellent! All the weirdness
>>  just cancels out, giving perfect little-endian. This works for
>>  8-bit, 16-bit, 32-bit, and 64-bit data. Life is good.
>>
>Does it work for 128 bit data? The 74x0's most promiment feature,
>AltiVec, would expose a strange mixed endianness to programmers
>otherwise.

For compatability's sake, when AltiVec quad word loads/stores are
performed in LE mode, you get a double munge (one munge for each of
the two doublewords in the quadword) and a swap of the two munged
doublewords.  Details are in the AltiVec PEM.  So AltiVec has true LE
ordering of doublewords and munged up contents inside doublewords,
and an unconditional 64-bit swap on the motherboard will fix the
munging inside each doubleword.
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
