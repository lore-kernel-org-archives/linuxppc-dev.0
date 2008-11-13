Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 057ACDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 02:16:41 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linux-raid@vger.kernel.org
Subject: [RFC PATCH 00/11] md: support for asynchronous execution of RAID6
	operations
Date: Thu, 13 Nov 2008 18:15:53 +0300
Message-Id: <1226589364-5619-1-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 The following patch-set includes enhancements to the async_tx api and
modifications to md-raid6 to issue memory copies and parity calculations
asynchronously. Thus we may process copy operations and RAID-6 calculations
on the dedicated DMA engines accessible with ASYNC_TX API, and, as a result
off-load CPU, and improve the performance.

 To reduce the code duplication in the raid driver this patch-set modifies
some raid-5 functions to make them possible to use in the raid-6 case.

 The patch-set can be broken down into thee following main categories: 

1) Additions to ASYNC_TX API (patches 1-3)
2) RAID-6 implementation (patches 4-10)
3) ppc440spe ADMA driver (patch 11) (it still has a number of problems,
provided only as a reference here)
