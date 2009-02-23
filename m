Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B115DDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:48:12 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1NAkw96011506
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:46:58 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1NAmSmm1196134
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:48:28 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1NAmAfI016209
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:48:10 +1100
Message-ID: <49A27EE8.5030700@in.ibm.com>
Date: Mon, 23 Feb 2009 16:18:08 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
References: <49A2705D.9030008@in.ibm.com>
	<20090223021320.11019d64.akpm@linux-foundation.org>
In-Reply-To: <20090223021320.11019d64.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	linux-ext4@vger.kernel.org, Jan Kara <jack@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> hm, I wonder what could have caused that - we haven't altered
> fs/ext3/xattr.c in ages.
>
> What is the most recent kernel version you know of which didn't do
> this?  Bear in mind that this crash might be triggered by the
> current contents of the filesystem, so if possible, please test
> some other kernel versions on that disk.
>   
I am trying to boot a vanilla kernel on this machine for the first
time. Haven't tried any other kernels. Will give it a try.

> It looks like we died in ext3_xattr_block_get():
>
> 		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
> 		       size);
>
> Perhaps entry->e_value_offs is no good.  I wonder if the filesystem is
> corrupted and this snuck through the defenses.
>
> I also wonder if there is enough info in that trace for a ppc person to
> be able to determine whether the faulting address is in the source or
> destination of the memcpy() (please)?
>   
Some more information if this could be of any help.

0:mon> di 0xc000000000039574
c000000000039574  e9240008      ld      r9,8(r4)
c000000000039578  409d0010      ble     cr7,c000000000039588    # .memcpy+0x88/0x244
c00000000003957c  79290002      rotldi  r9,r9,32
c000000000039580  91230000      stw     r9,0(r3)
c000000000039584  38630004      addi    r3,r3,4
c000000000039588  409e0010      bne     cr7,c000000000039598    # .memcpy+0x98/0x244
c00000000003958c  79298000      rotldi  r9,r9,16
c000000000039590  b1230000      sth     r9,0(r3)
c000000000039594  38630002      addi    r3,r3,2
c000000000039598  409f000c      bns     cr7,c0000000000395a4    # .memcpy+0xa4/0x244
c00000000003959c  79294000      rotldi  r9,r9,8
c0000000000395a0  99230000      stb     r9,0(r3)
c0000000000395a4  e8610030      ld      r3,48(r1)
c0000000000395a8  4e800020      blr
c0000000000395ac  78a6e8c2      rldicl  r6,r5,61,3
c0000000000395b0  38a5fff0      addi    r5,r5,-16
0:mon> r
R00 = 000000000000e40f   R16 = 00000000100edbc8
R01 = c00000003e59b3e0   R17 = 00000000100b0000
R02 = c0000000009c2110   R18 = 0000000000000005
R03 = c000000044bc90e0   R19 = 00000000fff0d7a8
R04 = c000000039cffff4   R20 = 00000000fff0d708
R05 = 0000000000000003   R21 = 00000000000000ff
R06 = 0000000000000000   R22 = 0000000000000006
R07 = 0000000000000001   R23 = c00000000079ab49
R08 = 723a7573725f743a   R24 = c0000000372fe2a8
R09 = 3a6f626a6563745f   R25 = c000000044bc90c8
R10 = c00000003b250968   R26 = c0000000372fe240
R11 = c000000000039500   R27 = c0000000372fe3b0
R12 = d00000000244c590   R28 = c0000000372c5280
R13 = c000000000a53480   R29 = 000000000000001b
R14 = 00000000100d0000   R30 = d0000000024654d0
R15 = 0000000000000000   R31 = ffffffffffffffde
pc  = c000000000039574 .memcpy+0x74/0x244
lr  = d00000000244916c .ext3_xattr_get+0x288/0x2f4 [ext3]
msr = 8000000000009032   cr  = 4400844b
ctr = 0000000000000000   xer = 0000000000000001   trap =  300
dar = c000000039d00000   dsisr = 40000000
0:mon>

So the other thing i noticed was that this machine was running
a kernel with selinux enabled. I turned off selinux and there
were no issues during bootup. It was a clean boot.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
