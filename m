Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FA5CDE19E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:12:32 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5PKEbf0028689
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:14:37 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5PKC7Lm220354
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:12:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5PKC62v025635
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:12:07 -0400
Date: Wed, 25 Jun 2008 15:12:03 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 00/18 v2] powerpc: pSeries Cooperative Memory
	Overcommitment support
Message-ID: <20080625201202.GB17020@linux.vnet.ibm.com>
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

This is version 2 of the full patchset pulling in all prior changes
posted to the list.

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
This patch set has been written against 2.6.26-rc8 and has been tested
at that level.

Regards,
Robert Jennings
