Message-ID: <3BD38515.40808@metaparadigm.com>
Date: Mon, 22 Oct 2001 10:31:49 +0800
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Late Broadcom link detection makes IP config (bootp) fail
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just compiled up 2.4.13-pres-benh0 and am trying to netboot my iMac.
I am using the following commandline:

     ip=bootp nfsroot=10.1.0.7:/nb/root,rw

The boot messages show that the broadcom is found:

     eth0: Found broadcom BCM5201 PHY

IP-Config initialises but doesn't send any request as I suspect the link
on eth0 is down. Root NFS then runs and fails due to network being down.

Later in the logs after unable to mount root kernel panic I see:

     eth0:    Link up ! BCM5201/5221 aux_stat: 0x003e
     eth0:    Full duplex: 0, Speed: 100

Why does the eth0 link come up so late? Is it possible to make the
broadcom driver wait for link before returning from the initialisation
function?

~mc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
