From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200205281605.g4SG5db30977@hofr.at>
Subject: Re: FS problem when booting
In-Reply-To: <20020528164326.11858.qmail@web11507.mail.yahoo.com> from Khai Trinh
 at "May 28, 2002 09:43:26 am"
To: Khai Trinh <kqtrinh@yahoo.com>
Date: Tue, 28 May 2002 18:05:39 +0200 (CEST)
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I got the following boot up problem with 2.4 devel
> kernel when booting on the IBM ebony board:
>
> Sending BOOTP requests . OK
> IP-Config: Got BOOTP answer from 199.254.9.151, my
> address is 199.254.9.207
> IP-Config: Complete:
>       device=eth0, addr=199.254.9.207,
> mask=255.255.255.0, gw=199.254.9.254,
>      host=199.254.9.207, domain=, nis-domain=(none),
>      bootserver=199.254.9.151,
> rootserver=199.254.9.151, rootpath=/projects/hard
> hat/khai/devkit/ppc/405/target
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 199.254.9.151
> Root-NFS: Unable to get nfsd port number from server,
> using default
> Looking up port of RPC 100005/1 on 199.254.9.151
> Root-NFS: Unable to get mountd port number from
> server, using default
> mount: server 199.254.9.151 not responding, timed out
> Root-NFS: Server returned error -5 while mounting
> /projects/hardhat/khai/devkit/
> ppc/405/target
> VFS: Unable to mount root fs via NFS, trying floppy.
> kmod: failed to exec /sbin/modprobe -s -k
> block-major-2, errno = 2
> VFS: Cannot open root device "" or 02:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00
>  <0>Rebooting in 180 seconds..
>
> It didn't seem to like the root filesystem directory I
> specified on the Host. Where should I point the fs
> directory for it in the Ebony kernel directory? I just
> arbitrarily pointed it to the 405 target file system
> dir existed on my Host system.
>
I would recomend you check on the server side in /var/log/messages what nfsd
is fussing about - did you export it with (rw,no_root_squash) ?? if not then
uid 0 becommes uid -1 (nobody) and will have access/perm problems.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
