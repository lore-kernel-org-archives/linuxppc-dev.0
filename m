Return-Path: <markn@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 497CFDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:19:20 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1P19UIh022029
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:09:30 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1P1JX1j463286
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:19:33 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1P1JEpN013779
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 12:19:15 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
Date: Wed, 25 Feb 2009 12:20:49 +1100
References: <49A2705D.9030008@in.ibm.com> <49A395ED.5030607@in.ibm.com>
	<20090224155119.GC22108@duck.suse.cz>
In-Reply-To: <20090224155119.GC22108@duck.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902251220.49265.markn@au1.ibm.com>
Cc: Jan Kara <jack@ucw.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Feb 2009 02:51:20 am Jan Kara wrote:
>   Hello,
> 
> On Tue 24-02-09 12:08:37, Sachin P. Sant wrote:
> > Jan Kara wrote:
> >>   Hmm, OK. But then I'm not sure how that can happen. Obviously, memcpy
> >> somehow got beyond end of the page referenced by bh->b_data. So it means
> >> that le16_to_cpu(entry->e_value_offs) + size > page_size. But
> >> ext3_xattr_find_entry() calls ext3_xattr_check_entry() which in
> >> particular checks whether e_value_offs + e_value_size isn't greater than
> >> bh->b_size. So I see no way how memcpy can get beyond end of the page.
> >>   Sachin, is the problem reproducible? If yes, can you send us contents
> >>   
> > Yes, i am able to recreate this problem easily. As i had mentioned if the
> > earlier kernel is booted with selinux enabled and then 2.6.29-rc6 is booted
> > i get this crash. But if i specify selinux=0 at command line, 2.6.29-rc6 boots
> > without any problem.
> >
> >> of the page just before the faulting address (i.e., for current fault it
> >> would be 0xc00000003f370000-0xc00000003f37ffff). As far as I can
> >> remember powerpc monitor could dump it.
> >>   
> > Here is the page dump. This time it crashed while accessing address
> > 0xc00000002d670000.
>   Thanks for the dump.
> 
> > Unable to handle kernel paging request for data at address 0xc0000
> > 0002d670000
> > Faulting instruction address: 0xc000000000039574
> > cpu 0x1: Vector: 300 (Data Access) at [c00000004288b0b0]
> >    pc: c000000000039574: .memcpy+0x74/0x244
> >    lr: c0000000001b497c: .ext3_xattr_get+0x288/0x2f4
> >    sp: c00000004288b330
> >   msr: 8000000000009032
> >
> > 1:mon> d 0xc00000002d660000
> > ............................... <SNIP> ...............................
> >
> > c00000002d66efd0 0000000000000000 0000000000000000  |................|
> > c00000002d66efe0 0000000000000000 0000000000000000  |................|
> > c00000002d66eff0 0000000000000000 0000000000000000  |................|
> > c00000002d66f000 000002ea00040000 01000000e200d20a  |................|
> > c00000002d66f010 0000000000000000 0000000000000000  |................|
> > c00000002d66f020 0706e40f00000000 1b000000e200d20a  |................|
> > c00000002d66f030 73656c696e757800 0000000000000000  |selinux.........|
> > c00000002d66f040 0000000000000000 0000000000000000  |................|
> > c00000002d66f050 0000000000000000 0000000000000000  |................|
> > c00000002d66f060 0000000000000000 0000000000000000  |................|
> >
> > ............................... <SNIP> ...............................
> >
> > c00000002d66ff60 0000000000000000 0000000000000000  |................|
> > c00000002d66ff70 0000000000000000 0000000000000000  |................|
> > c00000002d66ff80 0000000000000000 0000000000000000  |................|
> > c00000002d66ff90 0000000000000000 0000000000000000  |................|
> > c00000002d66ffa0 0000000000000000 0000000000000000  |................|
> > c00000002d66ffb0 0000000000000000 0000000000000000  |................|
> > c00000002d66ffc0 0000000000000000 0000000000000000  |................|
> > c00000002d66ffd0 0000000000000000 0000000000000000  |................|
> > c00000002d66ffe0 0000000073797374 656d5f753a6f626a  |....system_u:obj|
> > c00000002d66fff0 6563745f723a7573 725f743a73300000  |ect_r:usr_t:s0..|
> > c00000002d670000 **************** ****************  |                |
> > 1:mon> r
> > R00 = 000000000000e40f   R16 = 000000000000005d
> > R01 = c00000004288b330   R17 = 0000000000000000
> > R02 = c0000000009f59b8   R18 = 00000000fffbfe9e
> > R03 = c000000044aa34a0   R19 = 0000000010042638
> > R04 = c00000002d66fff4   R20 = 0000000010041610
> > R05 = 0000000000000003   R21 = 00000000000000ff
> > R06 = 0000000000000000   R22 = 0000000000000006
> > R07 = 0000000000000001   R23 = c0000000007d27c1
> > R08 = 723a7573725f743a   R24 = c00000002c0cd758
> > R09 = 3a6f626a6563745f   R25 = c000000044aa3488
> > R10 = c00000000017b43c   R26 = c00000002c0cd6f0
> > R11 = c00000002d66f020   R27 = c00000002c0cd860
> > R12 = d0000000023c14b0   R28 = c00000002c0b0840
> > R13 = c000000000a93680   R29 = 000000000000001b
> > R14 = 00000000000041ed   R30 = c0000000009880b0
> > R15 = 0000000010040000   R31 = ffffffffffffffde
> > pc  = c000000000039574 .memcpy+0x74/0x244
> > lr  = c0000000001b497c .ext3_xattr_get+0x288/0x2f4
> > msr = 8000000000009032   cr  = 4400044b
> > ctr = 0000000000000000   xer = 0000000020000001   trap =  300
> > dar = c00000002d670000   dsisr = 40000000
> > 1:mon> zr
> >
> >>   BTW, I suppose you use 4KB blocksize on the filesystem, right?
> >>   
> > Yes.
> >
> > dumpe2fs /dev/sda3 | grep -i "block size" dumpe2fs 1.39 (29-May-2006)
> > Block size:               4096
>   OK. The xattr block causing oops is completely correct. To me it seems
> more like some problem in powerpc memcpy() (I saw there went some changes
> into in in the end of December) - we call it to copy 27 bytes from
> address 0xc00000002d66ffe4 (which is one byte before end of the page).
> Could some of the powerpc guys have a look whether this could be the case?
> I'm not quite fluent in the powerpc assembly so it would take me ages ;).

You're right - it's a problem with the 64bit powerpc memcpy(). And the brown
paper bag is all mine (commit 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556). On
Power6 and Cell we're doing a load double that goes beyond the source size
we were given to copy. I'll see if I can find a nice way of fixing this up,
if not then I'll ask Ben to revert.

Sorry about the goose chase!

Mark
