Message-ID: <00b601c14753$525870f0$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: NFS mount for TQM823L
Date: Thu, 27 Sep 2001 14:52:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello to everybody.
We have got a STK8xxL400 with TQM823L minimodule on it,
running Linux-2.4.4-2001-07-23 (Denx Software Engineering)
from initial ramdisk.
We are experimenting with NFS: we succesfully mount a remote
directory (from host, the PC LinuxBox) under the target (STK8xxL400)
filesystem.
We give, on the target, the command

# mount -t nfs 126.126.126.106:/home /tmp

(being 126.126.126.106 our host's IP address, /home the
directory exported for other machines on the subnet and
/tmp the target mount point for remote directory) and we get
the following messages:

RPC: sendmsg returned error 101
portmap: RPC call returned 101
RPC: sendmsg returned error 101
portmap: RPC call returned 101
lockd_up: makesock failed, error =-101
RPC: sendmsg returned error 101
portmap: RPC call returned 101

but if we give (from target's command line )

# cat /proc/mounts

we get

/dev/root        /          ext2   rw   0   0
proc               /proc   proc  rw   0   0
126.126.126.106:/home       /tmp     nfs rw, v2, rsize=8192, wsize=8192,
hard, udp, lock, addr=126.126.126.106  0  0

and we correctly see the remote filesystem as (if it would be) local.
[Note that we previously modified the initial ramdisk, adding
"exports", "hosts.allow" and "hosts.deny" files under /etc,
modifying "hosts" file adding IP addresses of our machines
on the subnet (host, target and loopback at least) and finally
modifying the "host.conf" file, adding the line "multi on".
I give these details to best explain what we have done anymore!]


On the other hand, when we give the command (from host's
command line):

# mount -t nfs 126.126.126.107:/  /mydir

we get this error message:

Mount: RPC: Unable to receive; errno = Connection refused.

Our target's kernel's configuration is:
    <*> NFS file system support
    [*]        Provide NFSv3 client support
    [*]        Root file system on NFS
    <*> NFS Server support
    [*]        Provide NFSv3 server support
So we wouldn't need rpc.nfsd and rpc.mountd daemons
running on target...or would we?
Maybe is portmap daemon missing on target?
Or something else is still missing in our configurations?
If anybody could give hints about NFS we would appreciate
very much.
Thank you.

Best regards.

Piero Dominioni
R.S.R. srl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
