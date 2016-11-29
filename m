Return-Path: <martin.petersen@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSqWh1tbxzDvrZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 03:58:55 +1100 (AEDT)
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-scsi@vger.kernel.org,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] scsi/ipr: Fix runaway IRQs when falling back from MSI to
 LSI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1479947042.10230.88.camel@kernel.crashing.org>
Date: Tue, 29 Nov 2016 11:58:38 -0500
In-Reply-To: <1479947042.10230.88.camel@kernel.crashing.org> (Benjamin
 Herrenschmidt's message of "Thu, 24 Nov 2016 11:24:02 +1100")
Message-ID: <yq1wpfmmddt.fsf@sermon.lab.mkp.net>
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

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Benjamin> LSIs must be ack'ed with an MMIO otherwise they remain
Benjamin> asserted forever. This is controlled by the "clear_isr" flag.

Benjamin> While we set that flag properly when deciding initially
Benjamin> whether to use LSIs or MSIs, we fail to set it if we first
Benjamin> chose MSIs, the test fails, then fallback to LSIs.

Brian: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
