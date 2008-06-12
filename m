Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E8D0DE4F7
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 07:54:46 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CLshi5028410
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 17:54:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CLshng179606
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 15:54:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CLsgnb000576
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 15:54:43 -0600
Date: Thu, 12 Jun 2008 16:53:13 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 00/19] powerpc: pSeries Cooperative Memory Overcommitment
	support
Message-ID: <20080612215312.GF30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cooperative Memory Overcommitment (CMO) is a pSeries platform feature
that enables the allocation of more memory to a set logical partitions
than is physically present.  For example, a system with 16Gb of memory
can be configured to simultaneously run 3 logical partitions each with
8Gb of memory allocated to them.

The system firmware can page out memory as needed to meet the needs
of each partition.  To minimize the effects of firmware paging memory,
the Collaborative Memory Manager (CMM) driver acts as a balloon driver
to work with firmware to provide memory ahead of any paging needs.

The OS is provided with an entitlement of IO memory for device drivers
to map.  This amount varies with the number of virtual IO adapters
present and can change as devices are hot-plugged.  The VIO bus code
distributes this memory to devices.  Logical partitions supporting CMO
may only have virtual IO devices, physical devices are not supported.
Above the entitled level, IO mappings can fail and the IOMMU needed be
updated to handle this change.

Virtual IO adapters have been updated to handle DMA mapping failures and
to size their entitlement needs.

Platform support for for CMM and hot-plug entitlement events are also
included in the following patches.

The changes should have minimal impact to non-CMO enabled environments.
This patch set has been written against 2.6.26-rc5 and has been tested
at that level.

Regards,
Robert Jennings
