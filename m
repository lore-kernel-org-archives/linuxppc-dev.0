Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYCDn1Gb5zDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 10:00:24 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Andrzej Hajda
 <a.hajda@samsung.com>, Anton Blanchard <anton@samba.org>, Arnd Bergmann
 <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christian Krafft <krafft@de.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc: remove unused modular code from non-modular
 drivers
Date: Sun, 27 Mar 2016 18:08:14 -0400
Message-ID: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My ongoing audit looking for non-modular code that needlessly uses
modular macros (vs. built-in equivalents) and/or has dead code
relating to module unloading that can never be executed led to the
creation of these three powerpc related commits.

One is of the trivial kind, where we substitute in the non-modular
versions that CPP would have put in place anyway, resulting in no
actual changes, even at the binary output level.

The other two are almost as trivial.  In addition to the above, we
toss out the __exit function registered by module_exit, since that
will never get called for non modular code/drivers.

For anyone new to the underlying goal of this cleanup, we are trying to
not use module support for code that can never be built as a module since:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

Build tested on v4.6-rc1 to ensure no silly typos that would break
compilation crept in.

---
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Krafft <krafft@de.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Paul Gortmaker (3):
  powerpc: make cell/spu_base.c explicitly non-modular
  powerpc: make kernel/nvram_64.c explicitly non-modular
  drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver explicitly
    non-modular

 arch/powerpc/kernel/nvram_64.c         | 12 +-----------
 arch/powerpc/platforms/cell/spu_base.c |  7 ++-----
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  | 15 ++-------------
 3 files changed, 5 insertions(+), 29 deletions(-)

-- 
2.6.1
