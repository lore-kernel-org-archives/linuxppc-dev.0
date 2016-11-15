Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHyq16wdCzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:56:29 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id x23so11034835pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:56:29 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [powerpc v6 0/3] Enable storage keys for radix
Date: Tue, 15 Nov 2016 17:56:13 +1100
Message-Id: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
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

IAMR in radix mode, prevents the kernel from executing
code from user mode pages.

I've tested with patch series with a sample hack and
payload.

Chris Smart helped with the series, reviewing and
providing valuable feedback

Changelog from previous post
  Implement review comments and suggestions

Balbir Singh (3):
  powerpc:Setup AMOR in HV mode
  powerpc/mm/radix:Detect instruction fetch denied and report
  powerpc:Enable storage keys for radix - user mode execution

 arch/powerpc/mm/fault.c         |  8 ++++++++
 arch/powerpc/mm/pgtable-radix.c | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

-- 
2.5.5
