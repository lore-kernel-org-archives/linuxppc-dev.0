Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRk3J3TTPzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 13:49:32 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id h64so14916735pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 20:49:32 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [RFC 0/2] Consolidate patch_instruction
Date: Tue, 16 May 2017 13:49:11 +1000
Message-Id: <20170516034913.21163-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

patch_instruction is enhanced in this RFC to support
patching via a different virtual address (text_poke_area).
The mapping of text_poke_area->addr is RW and not RWX.
This way the mapping allows write for patching and then we tear
down the mapping. The downside is that we introduce a spinlock
which serializes our patching to one patch at a time.

In this patchset we also consolidate instruction changes
in kprobes to use patch_instruction().

Balbir Singh (2):
  powerpc/lib/code-patching: Enhance code patching
  powerpc/kprobes: Move kprobes over to patch_instruction

 arch/powerpc/kernel/kprobes.c    |  4 +-
 arch/powerpc/lib/code-patching.c | 88 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 6 deletions(-)

-- 
2.9.3
