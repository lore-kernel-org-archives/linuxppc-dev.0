Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415kyS6NjTzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:29:20 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id s9-v6so4253257qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:29:20 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
Date: Wed, 13 Jun 2018 17:28:58 -0700
Message-Id: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Assortment of fixes to pkey.

Patch 1  makes pkey consumable in multithreaded applications.

Patch 2  fixes fork behavior to inherit the key attributes.

Patch 3  A off-by-one bug made one key unusable. Fixes it.

Patch 4  Execute-only key is preallocated.

Patch 5  Makes pkey-0 less special.

Patch 6  Deny by default permissions on all unallocated keys.

Passes all selftests on powerpc. Also behavior verified to be correct
by Florian.

Changelog:

	v2: . fixed merge conflict with upstream code.
	    . Add patch 6. Makes the behavior consistent
	      with that on x86.

Ram Pai (6):
  powerpc/pkeys: Enable all user-allocatable pkeys at init.
  powerpc/pkeys: Save the pkey registers before fork
  powerpc/pkeys: fix calculation of total pkeys.
  powerpc/pkeys: Preallocate execute-only key
  powerpc/pkeys: make protection key 0 less special
  powerpc/pkeys: Deny read/write/execute by default

 arch/powerpc/include/asm/pkeys.h |   29 +++++++++--
 arch/powerpc/kernel/process.c    |    1 +
 arch/powerpc/mm/pkeys.c          |  102 ++++++++++++-------------------------
 3 files changed, 57 insertions(+), 75 deletions(-)
