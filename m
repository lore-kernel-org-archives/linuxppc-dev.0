Message-ID: <9A9C83C019F35D47A570460E87D5D8AB0125EAC0@racerx.ixiacom.com>
From: Dan Kegel <dkegel@ixiacom.com>
To: "'Khai Trinh '" <kqtrinh@yahoo.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: in_ntoa built error
Date: Fri, 24 May 2002 15:45:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes.  References to inet_ntoa must be replaced
with references to NIPQUAD. e.g.

printk("s_addr=%d.%d.%d.%d, data_saddr=%d.%d.%d.%d, data_sport=%d",
 NIPQUAD(ms->saddr), NIPQUAD(data_saddr), ntohs(data_sport));

%u is probably better than %d.
- Dan


-----Original Message-----
From: Khai Trinh
To: linuxppc-embedded@lists.linuxppc.org
Sent: 5/24/2002 2:57 PM
Subject: in_ntoa built error


I downloaded the linuxppc2.4 devel tree from bitmover
and tried to build the the ebony kernel for my ebony
board. I got the built error in that in_ntoa is
referenced in the fs/nfs/nfsroot.c file but no include
lib for it.

What is this call anyway? It sounds like the root file
system is broken.

I then went and disable the NFS stuff in the defconfig
file. The kernel is then built. When I loaded the
kernel to Ebony, it failed on mounting the root
filesystem as expected.

Does anybody have a fix for this problem yet?

Regards,

--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
