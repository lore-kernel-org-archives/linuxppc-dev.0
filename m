Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Follow up on 4 Gig of DDR on  MPC8548E
Date: Fri, 22 Jun 2007 13:49:42 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108361D90@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org>
References: <mailman.1956.1182519826.2671.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>, <ltib@nongnu.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

We are running into a very strange problem that I=20
am hoping someone here might have some insight upon.

Setup:
   1) 4 Gig of DDR RAM (at physical addresses 0-0xF_FFFF_FFFF)

   2) LTIB/Linux Kernel (2.6.11++) - I know we are behind the
	times, but it was too risky to go with latest/greatest.

   3) U-boot passes a Max MEM of 3 GIG to the kernel at boot...
	But, we are using on the bootcmd =3D=3D> mem=3D2 GIG + a few pages

Symptoms:
  a) 	Kernel boots - but fails / and hangs when it attempts to=20
	open the initial console:

>> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
>> VFS: Mounted root (ext2 filesystem).
>>  316k init
>> EXT2-fs error (device sda1): ext2_check_page: bad entry in directory
#2: >> unaligned directory entry - offset=3D0, inode=3D128,
rec_len=3D8961,name_len=3D69
>> Warning: unable to open an initial console.

--- a little debugging indicates that it is trying to open the      ----
--- /dev/console device - and one of first physical pages allocated ----
--- is above the 2 GIG boundary (0x80000000)                        ----

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dfurther =
tests=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =20
   b) if we pass a 'mem=3D2GIG' or less (even though 4 GIG of DDR) -=20
	it works correctly, and we boot up normally...

   d) Further, If we do #b, and ioremap a physical address=20
	above the 2GIG and read/write those addresses - it works.....
	=3D=3D> This tells me the memory is working...

My gut tells me this might be something to do with the 2=20
Gig boundary and specifically a "signed" versus "unsigned"=20
address/offsets mismatch maybe somewhere in the file system??

We are debugging this - but it is painful and slow process=20
to narrow the root problem - I am hoping somebody around=20
here has some knowledge of this type of failure and can help us!

All the Best~!

Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
(781) 266 - 3567
