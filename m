Message-ID: <B895EFF5AF34724880036BDB5B5B8148135684@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "Kerl, John" <John.Kerl@Avnet.com>,
	"'Brian S. Park'" <brian@corelis.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: getting Linux working on IBM Walnut demo board
Date: Wed, 28 May 2003 12:02:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ooooops, not reading your message well enough.
Of course you're using NFS, not RAM disk.

You can do a couple things:

*	cd into your export directory and make sure
	stuff is really there -- this is the Linux
	host looking at itself.

*	A nice diagnostic is to use another Linux PC,
	mounting the first Linux host's export directory
	over NFS.  I.e. the second PC is the NFS client,
	rather than the board.

*	You can resort to printk's ... you might do the
	following to assist in this:
	-	cd to kernel directory
	-	make tags
	-	Set up your editor for tags, e.g. in vim,
		.vimrc has a 'set tags=./tags' line in it.
	-	vim init/main.c, find the function you want,
		then control-] to dive in, control-t to
		come back out.

-----Original Message-----
From: Kerl, John [mailto:John.Kerl@avnet.com]
Sent: Wednesday, May 28, 2003 11:57 AM
To: 'Brian S. Park'
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: getting Linux working on IBM Walnut demo board



Brian:

You can get the "all network ports in use" error when
there do not exist /dev/ttyp* -- these are the pseudo-ttys
needed by telnet.  You can mknod them; but I would double-check
your /dev directory.  If you're using ELDK, /dev/ttyp* should
already be there.

The "Unable to open an initial console" message is in init/main.c,
and occurs when /dev/console can't be opened.  Again, this points
suspicion at your filesystem.

To peek at your RAM disk, you can do the following (as root):

# gunzip < ramdisk.image.gz > ramdisk.image
# mkdir foo
# mount -o loop ramdisk.image foo

and then cd into foo and ls, etc.  Don't forget
to then do:

# umount foo
# rmdir foo
# rm ramdisk.image



-----Original Message-----
From: Brian S. Park [mailto:brian@corelis.com]
Sent: Wednesday, May 28, 2003 11:53 AM
To: Eran Mann
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: getting Linux working on IBM Walnut demo board



Eran,
Thank you very much. Now the kernel comes up and I can ping the target. :)

Now to the next problem. I'm booting with NFS root file system. Below is
the bootargs that I'm using.

 >bootargs=root=/dev/nfs rw nfsroot=192.168.1.78:/home/ELDK/ppc_4xx
console=ttyS0,115200
 >              console=tty0
ip=192.168.1.146:192.168.1.78:192.168.1.2:255.255.255.0:netusb::off

exports file on my development station has
 >/home/ELDK/ppc_4xx      netusb(rw,no_root_squash)

/home/ELDK/ppc_4xx is where ELDK installed the target file system on my
development machine.
Even though I can now ping the target, I can't telnet to it. I get the
following error.

 >telnet netusb
 >Trying 192.168.1.146...
 >Connected to netusb.
 >Escape character is '^]'.
 >telnetd: All network ports in use.
 >Connection closed by foreign host.

Is this normal? Do I now need to configure the target file system to enable
telnet?
Or is there still something wrong with my bootargs?

Also, after the kernel comes up, I can no longer type any command through
the serial terminal.
The following the message at the end of kernel boot. It says it was unable
to open the console.

 >IP-Config: Complete:
 >      device=eth0, addr=192.168.1.146, mask=255.255.255.0, gw=192.168.1.2,
 >     host=192.168.1.146, domain=, nis-domain=(none),
 >     bootserver=192.168.1.78, rootserver=192.168.1.78, rootpath=
 >NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
 >Looking up port of RPC 100003/2 on 192.168.1.78
 >Looking up port of RPC 100005/1 on 192.168.1.78
 >VFS: Mounted root (nfs filesystem).
 >Freeing unused kernel memory: 76k init
 >Warning: unable to open an initial console.

Any help will be appreciated.

Thank you

Brian

At 12:53 PM 5/28/2003 +0300, you wrote:
>Hello Brian,
>You can try what I suggested in:
>http://lists.linuxppc.org/linuxppc-embedded/200305/msg00222.html
>i.e. in the file arch/ppc/platforms/walnut.h to replace
>typedef struct board_info {
>...
>} bd_t;
>
>with:
>#include <asm/ppcboot.h>
>Hope that helps,
>         Eran.


===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
