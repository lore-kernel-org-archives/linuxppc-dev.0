Date: Tue, 29 Jul 2003 11:20:11 +0100
From: Malcolm Dodds <mdodds@totalise.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cramfs mount problems
Message-ID: <3F26D0E5@mail.totalise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having a strange problem. I create a cramfs image, mount it and then look
at the contents - these are wrong! In fact they are my root filesystem
again.I'm at a complete loss.

Here's what I've done:

# uname -r
2.4.2_hhl20
# mkdir /tmp/cram
# cp /bin/ash /bin/cat /bin/ls /tmp/cram
# mkcramfs /tmp/cram /tmp/cramfs.img
  ash
  cat
  ls
Directory data: 124 bytes
  0.00% (+1648 bytes)   .ÿüx
Everything: 92 kilobytes
Super block: 76 bytes
CRC: 4731a9e0
# eraseall /dev/mtd4
Erased 2560 Kibyte @ 0 -- 100% complete.
# cp /tmp/cramfs.img /dev/mtd4
Invalid ioctl 402c7413 (MEMGETINFO = 40204d01)
# mount -t cramfs /dev/mtdblock4 /mnt
# mount
/dev/root on / type nfs
(rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=10.0.)
/proc on /proc type proc (rw)
none on /var type ramfs (rw)
/dev/mtdblock4 on /mnt type cramfs (rw)
# ls -l /mnt
drwxrwxr-x    1 root     root          612 Jun  4 16:17 bin
drwxr-xr-x    1 root     root            0 Jan  1  1970 boot
drwxr-xr-x    1 root     root        18868 Jan  1  1970 dev
drwxrwxr-x    1 root     root          348 Jun  4 16:17 etc
drwxr-xr-x    1 505      249            36 Jan  1  1970 home
drwxrwxr-x    1 root     root          728 Jun  4 16:17 lib
drwxr-xr-x    1 root     root            0 Jan  1  1970 mnt
drwxr-xr-x    1 root     root            0 Jan  1  1970 opt
drwxr-xr-x    1 root     root            0 Jan  1  1970 proc
drwxr-xr-x    1 root     root            0 Jan  1  1970 root
drwxrwxr-x    1 root     root          316 Jun  4 16:17 sbin
lrwxrwxrwx    1 root     root            5 Jan  1  1970 tmp -> ./var
drwxrwxr-x    1 root     root           88 Jan  1  1970 usr
drwxrwxr-x    1 root     root          164 Jan  1  1970 var
#

Any help greatly appreciated - I'm a bit stuck here.

Malcolm.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
