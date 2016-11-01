Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7XQj0gFkzDsxk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 00:39:41 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t7XQh3H74z9t0q
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2016 00:39:39 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id a136so8341113pfa.0
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2016 06:39:39 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, Chris Smart <chris@distroguy.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] Enable IAMR storage keys for radix 
Date: Wed,  2 Nov 2016 00:38:17 +1100
Message-Id: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series follows up on
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147840.html

The first patch sets up AMOR in hypervisor mode. AMOR
needs to be setup before IAMR (details of AMOR/IAMR in
each patch). The second patch enables detection of exceptions
generated due to instruction fetch violations caused
and OOPSs' the task. The third patch enables IAMR for
both hypervisor and guest kernels.

I've tested with patch series with a sample hack and
payload.

Chris Smart helped with the series, reviewing and
providing valuable feedback

Cc: Chris Smart <chris@distroguy.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>

Balbir Singh (3):
  Setup AMOR in HV mode
  Detect instruction fetch denied and report
  Enable storage keys for radix - user mode execution

 arch/powerpc/mm/fault.c         |  4 ++++
 arch/powerpc/mm/pgtable-radix.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.5.5
