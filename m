Message-ID: <38465F9E.D9B6FB0F@switchboard.ericsson.se>
Date: Thu, 02 Dec 1999 13:01:34 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: wung_y@263.net
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ask for help
References: <38451447.BFB42D44@263.net> <384532AA.E0EB8B8E@switchboard.ericsson.se> <3845CAC4.6C2ED79@263.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> the code in minix_read_super() (fs/minix/inode.c) is like below:
> 
>         struct minix_super_block *ms;
>         if (!(bh = bread(dev,1,BLOCK_SIZE)))
>                 goto out_bad_sb;
> 
>         ms = (struct minix_super_block *) bh->b_data;
>         /*
>            now ms points to the start of superblock
>            that is 0x00000400+baseaddress
>          */
>         s->s_magic = ms->s_magic;
> s->s_magic is 0x8f13 but not 0x138f due to the endian problem. so
> the magic number is wrong and the root fs mount fail.
> 
> if i make a minix fs image in a big endian machine, the image
> should be looked like this:
> 
> 00000410h:  8f 13 00 01 00 00 00 00 00 00 00 00 00 00 00 00
> 
> is this correct? if yes, there is no problem any more.

Seems correct after a quick glance.

Question 1: Why use minix?

If you really want minix I suggest you to improve
the funcionality of it and add endian macros to it.

If you look at fs/fat/inode.c you see that the fat
code use macros like CF_LE_x to read variables from the structs
that are mapped on the data from the disk.
So does ext2.
The CF_LE_x are translated to lexx_to_cpu in include/linux/msdos_fs.h
where x is the size.

I would use ext2.

Cheers /

magnus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
