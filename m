Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPlNB3qPWzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 20:41:14 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org,
 cyrilbur@gmail.com
Subject: [PATCH v6 0/3] POWER9 Load Monitor Support
Date: Wed,  8 Jun 2016 20:38:33 +1000
Message-Id: <1465382316-18588-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1462501822-11262-1-git-send-email-mikey@neuling.org>
References: <1462501822-11262-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patches series adds support for the POWER9 Load Monitor
instruction (ldmx) based on work from Jack Miller.

The first patch is a clean up of the FSCR handling. The second patch
adds the actual ldmx support to the kernel. The third patch is a
couple of ldmx selftests.

v6:
  - PATCH 1/3:
    - Suggestions from mpe.
    - Init the FSCR using existing INIT_THREAD macro rather than
      init_fscr() function.
    - Set fscr when taking DSCR exception in
      facility_unavailable_exception().
  - PATCH 2/3:
    - Remove erroneous semicolons in restore_sprs().
  - PATCH 3/3:
    - no change.

v5:
  - PATCH 1/3:
    - Change FSCR cleanup more extensive.
  - PATCH 2/3:
    - Moves FSCR_LM clearing to new init_fscr().
  - PATCH 3/3:
    - Added test cases to .gitignore.
    - Removed test again PPC_FEATURE2_EBB since it's not needed.
    - Added parenthesis on input parameter usage for LDMX() macro.

Jack Miller (2):
  powerpc: Load Monitor Register Support
  powerpc: Load Monitor Register Tests

Michael Neuling (1):
  powerpc: Improve FSCR init and context switching
