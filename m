Return-Path: <fabf@skynet.be>
Received: from mailrelay003.isp.belgacom.be (mailrelay003.isp.belgacom.be
 [195.238.6.53])
 by lists.ozlabs.org (Postfix) with ESMTP id 565BE1A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jul 2014 21:36:34 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] arch/powerpc: convert single variable sscanf to
 kstrto<type>
Date: Sat, 12 Jul 2014 13:36:13 +0200
Message-Id: <1405164980-9525-1-git-send-email-fabf@skynet.be>
Cc: Fabian Frederick <fabf@skynet.be>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a small untested patchset to use the current string manipulation kstrto<type> functions
instead of sscanf like specified in checkpatch: "Prefer kstrto<type> to single variable sscanf"

autodetect base 0 has been used for both %d, %i, %ld, %lu, %u
and base 16 for %lx

Fabian Frederick (7):
  powerpc: fadump: replace sscanf by kstrtoint
  powerpc/mv64x60_pci: replace sscanf by kstrtou32
  powerpc/powernv: replace sscanf %lx by kstrtoul 16
  powerpc/sysfs: replace sscanf by kstrtol
  hugetlb: replace sscanf by kstrtoul
  powerpc/cell: replace sscanf by kstrtouint
  powerpc/pseries: replace sscanf by kstrtoul

 arch/powerpc/kernel/fadump.c              | 5 +++--
 arch/powerpc/kernel/sysfs.c               | 7 +++----
 arch/powerpc/mm/hugetlbpage.c             | 2 +-
 arch/powerpc/platforms/cell/cbe_thermal.c | 4 ++--
 arch/powerpc/platforms/powernv/subcore.c  | 6 +++---
 arch/powerpc/platforms/pseries/power.c    | 5 ++---
 arch/powerpc/sysdev/mv64x60_pci.c         | 7 +++++--
 7 files changed, 19 insertions(+), 17 deletions(-)

-- 
1.9.1
