Message-ID: <20020524230359.33739.qmail@web11507.mail.yahoo.com>
Date: Fri, 24 May 2002 16:03:59 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: RE: in_ntoa built error
To: Dan Kegel <dkegel@ixiacom.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <9A9C83C019F35D47A570460E87D5D8AB0125EAC0@racerx.ixiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


By the way, the snippet of the failing log of the
kernel when it was downloading are captured below:

Sending BOOTP requests . OK

IP-Config: Got BOOTP answer from 199.254.9.151, my
address is 199.254.9.207

IP-Config: Complete:

      device=eth0, addr=199.254.9.207,
mask=255.255.255.0, gw=199.254.9.254,

     host=199.254.9.207, domain=, nis-domain=(none),

     bootserver=199.254.9.151,
rootserver=199.254.9.151,
rootpath=/projects/hardhat/khai/devkit/ppc/405/target

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

kmod: failed to exec /sbin/modprobe -s -k
block-major-22, errno = 2

VFS: Cannot open root device "" or 16:01

Please append a correct "root=" boot option

Kernel panic: VFS: Unable to mount root fs on 16:01

 <0>Rebooting in 180 seconds..

Thanks,

--Khai
--- Dan Kegel <dkegel@ixiacom.com> wrote:
>
> Yes.  References to inet_ntoa must be replaced
> with references to NIPQUAD. e.g.
>
> printk("s_addr=%d.%d.%d.%d, data_saddr=%d.%d.%d.%d,
> data_sport=%d",
>  NIPQUAD(ms->saddr), NIPQUAD(data_saddr),
> ntohs(data_sport));
>
> %u is probably better than %d.
> - Dan
>
>
> -----Original Message-----
> From: Khai Trinh
> To: linuxppc-embedded@lists.linuxppc.org
> Sent: 5/24/2002 2:57 PM
> Subject: in_ntoa built error
>
>
> I downloaded the linuxppc2.4 devel tree from
> bitmover
> and tried to build the the ebony kernel for my ebony
> board. I got the built error in that in_ntoa is
> referenced in the fs/nfs/nfsroot.c file but no
> include
> lib for it.
>
> What is this call anyway? It sounds like the root
> file
> system is broken.
>
> I then went and disable the NFS stuff in the
> defconfig
> file. The kernel is then built. When I loaded the
> kernel to Ebony, it failed on mounting the root
> filesystem as expected.
>
> Does anybody have a fix for this problem yet?
>
> Regards,
>
> --Khai
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
