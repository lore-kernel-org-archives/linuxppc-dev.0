Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C22E6DE1BA
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 11:52:27 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-raid@vger.kernel.org
Subject: [RFC PATCH 00/11][v3] md: support for asynchronous execution of RAID6
	operations
Date: Tue, 13 Jan 2009 03:42:55 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901130342.55633.yur@emcraft.com>
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
has the Dan Williams' comments (Dec, 17) addressed with the following
exception:

- I still think that using 'enum dma_ctrl_flags' for PQ-specific 
operations is better than introducing another group of flags and 
enhance the device_prep_dma_pq()/device_prep_dma_pqzero_sum() with one 
more parameter. If unchanged 'enum dma_ctrl_flags' will be a criteria 
of acceptance, please let me know - I'll re-implement this exactly as 
Dan suggested.


 Fearing to look like a spammer, I post only those patches, which had 
been affected by the changes intended to address Dan's comments. These 
are the following five:

0002-async_tx-add-support-for-asynchronous-GF-multiplica.patch
0003-async_tx-add-support-for-asynchronous-RAID6-recover.patch
0004-md-run-RAID-6-stripe-operations-outside-the-lock.patch
0008-md-asynchronous-handle_parity_check6.patch
0011-ppc440spe-adma-ADMA-driver-for-the-PPC440SP-e-syst.patch

 As regarding the other six patches of asynchronous RAID-6 support 
patchset:

0001-async_tx-don-t-use-src_list-argument-of-async_xor.patch
0005-md-common-schedule_reconstruction-for-raid5-6.patch
0006-md-change-handle_stripe_fill6-to-work-in-asynchrono.patch
0007-md-rewrite-handle_stripe_dirtying6-in-asynchronous.patch
0009-md-change-handle_stripe6-to-work-asynchronously.patch
0010-md-remove-unused-functions.patch

 they are the same as in my 09 Dec 2008 post:

 https://kerneltrap.org/mailarchive/linux-raid/2008/12/8/4367574

 and are waiting for your comments.

 Regards, Yuri
