Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410FdH2MsFzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 12:10:24 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id g126-v6so531056qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 19:10:24 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org
Subject: [PATCH  0/5] powerpc/pkeys: fixes to pkeys
Date: Mon,  4 Jun 2018 19:09:49 -0700
Message-Id: <1528164594-23823-1-git-send-email-linuxram@us.ibm.com>
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

Patch 4  Makes pkey-0 less special.

Ram Pai (5):
  powerpc/pkeys: Enable all user-allocatable pkeys at init.
  powerpc/pkeys: Save the pkey registers before fork
  powerpc/pkeys: fix calculation of total pkeys.
  powerpc/pkeys: Preallocate execute-only key
  powerpc/pkeys: make protection key 0 less special

 arch/powerpc/include/asm/pkeys.h |   29 ++++++++--
 arch/powerpc/kernel/process.c    |    1 +
 arch/powerpc/mm/pkeys.c          |  107 ++++++++++++++------------------------
 3 files changed, 64 insertions(+), 73 deletions(-)
