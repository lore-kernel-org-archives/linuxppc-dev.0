Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E49BD1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:27:22 +1100 (AEDT)
From: Luis Henriques <luis.henriques@canonical.com>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] powerpc/ps3: gelic_udbg: drop local versions of
 network data structs
Date: Mon,  8 Feb 2016 22:27:03 +0000
Message-Id: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several network-related data structures are defined in gelic_udbg.
These could be easily dropped and the standard ones defined in network
headers could be used instead.

The 4 patches that follow replace ethernet, vlan, ip and udp
structures in gelic_udbg.  Note that this has been compile-tested
only.

Changes since v1:
Include changes suggested by Joe Perches, namely the usage of
eth_broadcast_addr(), ETH_ALEN, ETH_P_8021Q and ETH_P_IP.

Luis Henriques (4):
  powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
  powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
  powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
  powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>

 arch/powerpc/platforms/ps3/gelic_udbg.c | 72 +++++++++++----------------------
 1 file changed, 24 insertions(+), 48 deletions(-)
