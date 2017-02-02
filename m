Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDSZq0W4VzDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 16:04:03 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vDSZn72Mhz9s7B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2017 16:04:01 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 3so708320pgj.1
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Feb 2017 21:04:01 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Peter Bergner <bergner@vnet.ibm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Update xmon disassembly
Date: Thu,  2 Feb 2017 10:33:41 +0530
Message-Id: <20170202050344.6825-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series updates xmon to allow disassembly of
upto POWER9 instructions. 

With a lot of help from Peter Bergner and help
from Paul Mckenney I was able to get help in relicensing
the new binutils ppc-opc.c/ppc-dis.c and ppc.h to
GPLv2. The details of the commits are in patch 2 in the
series. The authors of the various commits have generously
allowed their commits to be relicensed under GPLv2.

The first patch updates the files in xmon to latest GPLv2
version.  The second patch are commits relicensed as GPLv2
The third patch makes modifications necessary to integration
with xmon

This series is not git-bisect friendly, the first two patches
will not compile, but are split for ease of understanding
and better understanding of how we got to patch 3. In addition
the CodingStyle followed in these files is not the Linux
CodingStyle, so scripts like checkpatch do not warm up
to the series nicely.

Cc: Peter Bergner <bergner@vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

NOTE: This is an internal posting at the moment for review
and criticism.

Balbir Singh (3):
  powerpc/xmon Update ppc-dis/opc.c and ppc.h
  powerpc/xmon: Apply binutils changes to upgrade disassembly
  powerpc/xmon: Enable disassembly files (compilation changes)

 arch/powerpc/xmon/ppc-dis.c |  260 +-
 arch/powerpc/xmon/ppc-opc.c | 8999 +++++++++++++++++++++++++++----------------
 arch/powerpc/xmon/ppc.h     |  268 +-
 3 files changed, 6030 insertions(+), 3497 deletions(-)

-- 
2.9.3
