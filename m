Return-Path: <kumagai-atsushi@mxc.nes.nec.co.jp>
Received: from tyo200.gate.nec.co.jp (TYO200.gate.nec.co.jp [210.143.35.50])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A21022C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 19:00:06 +1000 (EST)
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id r3A7BDMC021961
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 16:11:13 +0900 (JST)
Date: Wed, 10 Apr 2013 15:05:24 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
To: kexec@lists.infradead.org
Subject: [RESEND PATCH 0/4] Add support for vmap_area_list.
Message-Id: <20130410150524.804cd23b99a697f71146be67@mxc.nes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

# CCing linuxppc-dev to get advice on ppc for makedumpfile.
# makedumpfile is a userspace utility to create a smaller dump file,
# you can download it from the following URL.
# http://sourceforge.net/projects/makedumpfile/

-----
Hello,

This patchset is to work with "remove vm_struct list management":

  https://lkml.org/lkml/2013/3/13/40

In more detail, this patchset try to use vmap_area_list to get the
start address of vmalloc region.

I tested this on i386/x86_64, but I can't do it on other 
architectures. So, please let me know if you find any problems.

---

Atsushi Kumagai (4):
      Introduce new symbols to look at the first vmap_area.
      Use vmap_area_list to get vmalloc_start for i386.
      Use vmap_area_list to get vmalloc_start for ppc32.
      Use vmap_area_list to get vmalloc_start for ppc64.

 arch/ppc.c     | 46 ++++++++++++++++++++++++++++++++--------------
 arch/ppc64.c   | 46 ++++++++++++++++++++++++++++++++--------------
 arch/x86.c     | 46 ++++++++++++++++++++++++++++++++--------------
 makedumpfile.c |  9 +++++++++
 makedumpfile.h |  5 +++++
 5 files changed, 110 insertions(+), 42 deletions(-)


Thanks
Atsushi Kumagai
