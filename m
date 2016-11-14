Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTyt1kKXzDvhd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:16:38 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tHTyr50C4z9s5w
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2016 23:16:36 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so3569521pfb.3
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2016 04:16:36 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@ozlabs.org,
	mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com,
	Balbir Singh <bsingharora@gmail.com>
Subject: [powerpc v5 0/3] Enable IAMR storage keys for radix
Date: Mon, 14 Nov 2016 23:16:15 +1100
Message-Id: <1479125778-18496-1-git-send-email-bsingharora@gmail.com>
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

Changelog
  Remove __init annotation for iamr and amor init

Balbir Singh (3):
  Setup AMOR in HV mode
  Detect instruction fetch denied and report
  Enable storage keys for radix - user mode execution

 arch/powerpc/mm/fault.c         |  4 ++++
 arch/powerpc/mm/pgtable-radix.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.5.5
