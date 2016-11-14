Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHJrQ3W7NzDvPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 16:25:26 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so5543596pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 21:25:26 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>,
 Chris Smart <chris@distroguy.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [powerpc v4 0/3] Enable IAMR storage keys for radix
Date: Mon, 14 Nov 2016 16:25:09 +1100
Message-Id: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

Changelog
  Enable both primary and secondary MMU's (BUG FIX)
  Make the check for instruction violations common (SRR1_ISI_N_OR_G)

Balbir Singh (3):
  Setup AMOR in HV mode
  Detect instruction fetch denied and report
  Enable storage keys for radix - user mode execution

 arch/powerpc/mm/fault.c         |  4 ++++
 arch/powerpc/mm/pgtable-radix.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.5.5
