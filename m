Return-Path: <srs0=cfcn=ag=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmYLL3TnMzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xmYLL1ZcPz8vDW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 14:16:10 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xmYLK3htlz9s9Y
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2017 14:16:09 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g13so771427pfm.2
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Sep 2017 21:16:08 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com,
	alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [rfc 0/3] Revisit MCE handling for UE errors
Date: Tue,  5 Sep 2017 14:15:52 +1000
Message-Id: <20170905041555.27696-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is designed to hook up memory_failure on
UE errors, this is specially helpful for user_mode UE errors.

The first patch is a cleanup patch, it removes dead code.
I could not find any users of get_mce_fault_addr().
The second patch walks kernel/user mode page tables in
real mode to extract the effective address of the instruction
that caused the UE error and the effective address it was
trying to access (for load/store).
The third patch hooks up memory_failure to the MCE patch.

TODO:
Log the address in NVRAM, so that we can recover from
bad pages at boot and keep the blacklist persistent.

Balbir Singh (3):
  powerpc/mce.c: Remove unused function get_mce_fault_addr()
  powerpc/mce: Extract physical_address for UE errors
  powerpc/mce: hookup memory_failure for UE errors

 arch/powerpc/include/asm/mce.h  |   4 +-
 arch/powerpc/kernel/mce.c       | 107 ++++++++++++++++++++++++----------------
 arch/powerpc/kernel/mce_power.c |  60 ++++++++++++++++++++--
 3 files changed, 120 insertions(+), 51 deletions(-)

-- 
2.9.5
