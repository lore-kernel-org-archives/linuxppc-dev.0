Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0764BDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 09:04:54 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-raid@vger.kernel.org
Subject: [RFC PATCH 00/11][v2] md: support for asynchronous execution of RAID6
	operations
Date: Tue, 9 Dec 2008 00:55:04 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812090055.04265.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com, wd@denx.de, dzu@denx.de,
	yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Hello,

 This is the next attempt on asynchronous RAID-6 support. This patch-set
has the Dan Williams' comments (Nov, 15) addressed. These were mainly
about the ASYNC_TX part of the code.

 The following patch-set includes enhancements to the async_tx api and
modifications to md-raid6 to issue memory copies and parity calculations
asynchronously. Thus we may process copy operations and RAID-6 calculations
on the dedicated DMA engines accessible with ASYNC_TX API, and, as a result
off-load CPU, and improve the performance.

 To reduce the code duplication in the raid driver this patch-set modifies
some raid-5 functions to make them possible to use in the raid-6 case.

 The patch-set can be broken down into thee following main categories: 

1) Additions to ASYNC_TX API (patches 1-3; without the patch 1 the ASYNC_TX
can't be compiled for 44x in 2.6.27-rc6 or later);

2) RAID-6 implementation (patches 4-10)

3) ppc440spe ADMA driver (patch 11) (provided as a reference here)

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
