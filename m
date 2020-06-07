Return-Path: <SRS0=kDqf=7U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC34FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2020 08:02:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C40F20663
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2020 08:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C40F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49fpkd287DzDqjM
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2020 18:02:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.230; helo=relay10.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49fphR1mrHzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jun 2020 18:00:03 +1000 (AEST)
Received: from localhost.localdomain
 (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
 (Authenticated sender: alex@ghiti.fr)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id A5B6B240003;
 Sun,  7 Jun 2020 07:59:50 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <Anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
 Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/4] vmalloc kernel mapping and relocatable kernel
Date: Sun,  7 Jun 2020 03:59:45 -0400
Message-Id: <20200607075949.665-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patchset originally implemented relocatable kernel support but now          
also moves the kernel mapping into the vmalloc zone.                             
                                                                                 
The first patch explains why we need to move the kernel into vmalloc             
zone (instead of memcpying it around). That patch should ease KASLR              
implementation a lot.                                                            
                                                                                 
The second patch allows to build relocatable kernels but is not selected         
by default.                                                                      
                                                                                 
The third and fourth patches take advantage of an already existing powerpc       
script that checks relocations at compile-time, and uses it for riscv.           
                                                                                 
Changes in v5:
  * Add "static __init" to create_kernel_page_table function as reported by
    Kbuild test robot
  * Add reviewed-by from Zong
  * Rebase onto v5.7

Changes in v4:                                                                   
  * Fix BPF region that overlapped with kernel's as suggested by Zong            
  * Fix end of module region that could be larger than 2GB as suggested by Zong  
  * Fix the size of the vm area reserved for the kernel as we could lose         
    PMD_SIZE if the size was already aligned on PMD_SIZE                         
  * Split compile time relocations check patch into 2 patches as suggested by Anup
  * Applied Reviewed-by from Zong and Anup                                       
                                                                                 
Changes in v3:                                                                   
  * Move kernel mapping to vmalloc                                               
                                                                                 
Changes in v2:                                                                   
  * Make RELOCATABLE depend on MMU as suggested by Anup                          
  * Rename kernel_load_addr into kernel_virt_addr as suggested by Anup           
  * Use __pa_symbol instead of __pa, as suggested by Zong                        
  * Rebased on top of v5.6-rc3                                                   
  * Tested with sv48 patchset                                                    
  * Add Reviewed/Tested-by from Zong and Anup 

Alexandre Ghiti (4):
  riscv: Move kernel mapping to vmalloc zone
  riscv: Introduce CONFIG_RELOCATABLE
  powerpc: Move script to check relocations at compile time in scripts/
  riscv: Check relocations at compile time

 arch/powerpc/tools/relocs_check.sh |  18 +----
 arch/riscv/Kconfig                 |  12 +++
 arch/riscv/Makefile                |   5 +-
 arch/riscv/Makefile.postlink       |  36 +++++++++
 arch/riscv/boot/loader.lds.S       |   3 +-
 arch/riscv/include/asm/page.h      |  10 ++-
 arch/riscv/include/asm/pgtable.h   |  38 ++++++---
 arch/riscv/kernel/head.S           |   3 +-
 arch/riscv/kernel/module.c         |   4 +-
 arch/riscv/kernel/vmlinux.lds.S    |   9 ++-
 arch/riscv/mm/Makefile             |   4 +
 arch/riscv/mm/init.c               | 121 +++++++++++++++++++++++++----
 arch/riscv/mm/physaddr.c           |   2 +-
 arch/riscv/tools/relocs_check.sh   |  26 +++++++
 scripts/relocs_check.sh            |  20 +++++
 15 files changed, 259 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh

-- 
2.20.1

