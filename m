Subject: NFS mount timeouts in linux-2.4.0-test5-pre2
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 19 Jul 2000 15:21:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000719052102.3B9D924A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just tried running linux-2.4.0-test5-pre2 on one of our Embedded Planet
CLLF860T boards, and I'm finding NFS mounting times out using CPM Ethernet.

The kernel starts up OK, manages to NFS mount the root filesystem from the
MontaVista journeyman release.  I've moved /bin/init aside so it gives me a
simple shell prompt.  From here when I try to mount something manually, and I
get:

    init-2.03# /bin/mount -t nfs 10.8.1.11:/a/brixi/home /home/brixi
    nfs warning: mount version older than kernel
    <waits for over 2 minutes>
    portmap: server localhost not responding, timed out
    <waits another minute>
    portmap: server localhost not responding, timed out
    lockd_up: makesock failed, error=-5
    <waits another 90 seconds>
    portmap: server localhost not responding, timed out

When it finally does exit, the NFS mount has been completed successfully.

Looking at /var/log/messages on the server (10.8.1.11), it authenticates the
mount request almost immediately.  I upgraded "mount" to the version from
util-linux-2.10m to suppress the warning about mount being older than the
kernel, but it still waits ages before completing.  The mount completes within
a second on the stable series 2.2.13 MontaVista 8xx kernel.

The "lockd_up" message made me suspicious, so I tried mounting with
"-o nolock", but then I get:
    mount: RPC: Unable to receive; errno = Bad address

I've searched the linux-kernel & linuxppc-dev archives for other reports of
NFS mount problems with 2.4.0, but haven't seen any.  Any ideas what might be
going wrong here?

Thanks,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
