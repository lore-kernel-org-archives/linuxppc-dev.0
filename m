Date: Sat, 21 Aug 2004 11:41:55 +1000
From: CaT <cat@zip.com.au>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 hoses 2.4 on old-world?
Message-ID: <20040821014155.GB1005@zip.com.au>
References: <p06100200bd4c49c3daeb@[192.168.0.23]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06100200bd4c49c3daeb@[192.168.0.23]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 20, 2004 at 09:04:23PM -0400, Stefan Jeglinski wrote:
> But if I try e2fsck /dev/sda6, I get 'couldn't open /dev/null
> (read-only file system)' despite what mtab says. I can't seem to
> umount anything to try remounting.

do an 'ls -l /dev/null'. Does it look something like this?

crw-rw-rw-  1 root root 1, 3 2004-08-14 04:37 /dev/null

If not then remove it and type

mknod /dev/null c 1 3

You'll need to mount the fs rw first though. This should do it:

mount -o 'remount,rw' /

And don't forget to remount ro when you're done.

--
    Red herrings strewn hither and yon.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
