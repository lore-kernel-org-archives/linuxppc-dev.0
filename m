Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id 94AE1DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 01:33:09 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] swiotlb: Introduce architecture-specific APIs to
	replace __weak functions (v2)
Date: Mon, 1 Jun 2009 16:32:52 +0100
Message-ID: <1243870383-12954-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: x86@kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Ian Campbell <ian.campbell@citrix.com>,
	Olaf Kirch <okir@suse.de>, Greg KH <gregkh@suse.de>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series:
* removes the swiotlb_(arch_)_phys_to_bus and bus_to_phys __weak
  hooks, replacing them with an architecture-specific phys_to_dma and
  dma_to_phys interface. These are used by both PowerPC and Xen to
  provide the correct mapping from physical to DMA addresses.
* removes the swiotlb_address_needs_mapping and
  swiotlb_range_needs_mapping __weak functions as well as
  is_buffer_dma_capable (which should never have been a generic
  function). All three are replaced by a single architecture-specific
  interface which meets the needs of both PowerPC and Xen.
* removes the swiotlb_virt_to_bus __weak function and replaces it with
  a CONFIG_HIGHMEM compatible version when high memory is in use. This
  is needed for 32 bit PowerPC swiotlb support.
* removes the swiotlb_alloc* __weak functions and replaces them with
  swiotlb_init_with_buffer which allows the use of a caller allocated
  buffer (and emergency pool).

I think these new interfaces are cleaner than the existing __weak
functions and isolate the swiotlb code from architecture internals.

This series does not contain any Xen or PowerPC specific changes, those
will follow in separate postings. The complete patchset has been boot
tested under Xen and native-x86 and compiled for IA64 and PowerPC

Changes since v1: 
- Fixed compile error in swiotlb_dma_to_virt highmem version. Moved
  #ifdef into function to avoid prototype drift.
- checkpatch fixes.
- missed a swiotlb_arch_range_needs_mapping in swiotlb.h and x86
  pci-swiotlb.c and swiotlb_bus_to_phys/phys_to_bus implementations in
  x86.
- additionally replaced __weak swiotlb_alloc* with
  swiotlb_init_with_buffer.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Becky Bruce <beckyb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Greg KH <gregkh@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Olaf Kirch <okir@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Cc: x86@kernel.org
