Message-ID: <3845CAC4.6C2ED79@263.net>
Date: Thu, 02 Dec 1999 09:26:28 +0800
From: Wang Yong <wung_y@263.net>
Reply-To: wung_y@263.net
MIME-Version: 1.0
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ask for help
References: <38451447.BFB42D44@263.net> <384532AA.E0EB8B8E@switchboard.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>    You read it out to register r3.
> 
>    r3 = 0xefbeadde - not the same 32bit value as on the x86!

yes, that is the problem.

i do my work follow these steps:

  1. make a loopback minix on i386 linux box and dd it to a image
  2. burn the image to flash
  3. when linux startup, uncompress the image to the buffer of a
     ramdisk
  4. use this ramdisk as root file system and mount it as root.

when mount root, the super block should be read first. the super
block in the image made in i386 looked like this:

00000400h: 02 a0 07 d0 00 01 00 01 00 19 00 00 1c 00 10 08
00000410h: 13 8f 00 01 00 00 00 00 00 00 00 00 00 00 00 00
           ^^^^^ the magic number of minix

the code in minix_read_super() (fs/minix/inode.c) is like below:

	struct minix_super_block *ms;
	if (!(bh = bread(dev,1,BLOCK_SIZE)))
		goto out_bad_sb;

	ms = (struct minix_super_block *) bh->b_data;
        /* 
           now ms points to the start of superblock
           that is 0x00000400+baseaddress
         */
	s->s_magic = ms->s_magic;
s->s_magic is 0x8f13 but not 0x138f due to the endian problem. so
the magic number is wrong and the root fs mount fail.

if i make a minix fs image in a big endian machine, the image 
should be looked like this:

00000410h:  8f 13 00 01 00 00 00 00 00 00 00 00 00 00 00 00

is this correct? if yes, there is no problem any more.


Wang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
