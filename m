Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711071259n29609954j78d4a3d2050bc267@mail.gmail.com>
Date: Wed, 7 Nov 2007 15:59:32 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: mpc5200, sysctl table check failed
In-Reply-To: <fa686aa40711071242kd6c3012lf36c0ea22149c9ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
	<9e4733910711071239v6e646590s906f22cb7a9564bb@mail.gmail.com>
	<fa686aa40711071242kd6c3012lf36c0ea22149c9ba@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/7/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Phytec pcm030.c depended on mpc52xx_setup_cpu which got removed. I
> > fixed it up by copying the old version into pcm030.c. There must be
> > more to the fix.
>
> Do "git log arch/powerpc/platforms/52xx" to see the when it got
> removed and why.  You should match that change in your pcm030.c.

Looking at it some more it may be the FEC that is stopping user space
from loading. DHCP gets an address but nfs can't mount my root
partition. The nfs server is working since I can mount it from another
machine. Of course user space won't start if nfs can't read the files.

I clipped out non-net related entries.

DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(0.230:1): initialized
mpc52xx MII bus: probed
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
net eth0: attached phy 0 to driver Generic PHY
Sending DHCP requests .<6>PHY: f0003000:00 - Link is Up - 100/Full
., OK
IP-Config: Got DHCP answer from 192.168.1.200, my address is 192.168.1.5
IP-Config: Complete:
      device=eth0, addr=192.168.1.5, mask=255.255.255.0, gw=192.168.1.200,
     host=MPC, domain=home, nis-domain=(none),
     bootserver=192.168.1.200, rootserver=192.168.1.4, rootpath=
Looking up port of RPC 100003/3 on 192.168.1.4
Looking up port of RPC 100005/3 on 192.168.1.4
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 172k init
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying

-- 
Jon Smirl
jonsmirl@gmail.com
