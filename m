Date: Wed, 19 Apr 2000 00:41:53 -0700 (PDT)
From: Matt McLean <keys@yikes.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Speculative Processing / 7500 with G3 upgrade
Message-ID: <Pine.BSF.4.21.0004190027440.18043-100000@nerf.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey,

I've been trying almost every version of the kernels around lately, dave's
CVS 2.2 and 3, paul's tree, and with all of them I have the same
problem: random machine lockups.

I use a 7500 with a G3/350 upgrade, running at 400 (I have considered
overclocking as a possible source of the problem...)

It just seems like places in memory are getting hosed (bad checksums, bad
memory addresses, etc, all which lock up the kernel, and I think it might
be a problem with Speculative Processing and my Adaptec 2940 ultra2 card.

Speculative processing was a new feature in the G3 CPUs to try and
"guess" what instructions will be given before they actually
were.

I ran across this information in the manual for my G3 upgrade; that there
is a problem with speculative processing on Macs with OF 1.x:

"...but the PowerSurge ROMs do not prevent Speculative Processing from
reading areas of memory that are potentially 'volatile,' i.e. those areas
of memory from which the very act of reading a value alters the value.

Therefore when a G3 upgrade card performs Speculative Processing in a
PowerSurge machine it may in fact have irriversible consequences because
of accesses to volatile memory.  If the speculation turns out to be
incorrect, the damage cannot be undone: the values cannot be restored."

Then it explains that symptoms are random machine lockups, or erratic
behavior of hardware devices..."

XLR8, and I'm sure other companies, work around this by
disabling speculative processing with their Mac OS software, but my
question is, is the problem currently being accounted for in the linux
kernel?  Do you just need to turn off a bit somewhere, would it be that
simple?

Thanks in advance,

Matt


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
