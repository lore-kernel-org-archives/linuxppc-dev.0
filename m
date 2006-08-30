Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id ADEED67B32
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 08:49:24 +1000 (EST)
Message-ID: <44F60DFF.9080508@mvista.com>
Date: Wed, 30 Aug 2006 15:15:27 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: Re: [QUESTION] Enable coherency for all pages on 83xx to fix PCI
	data corruption
References: <995B09A8299C2C44B59866F6391D263511B9EA@zch01exm21.fsl.freescale.net>
	<43765FEB-22D2-4435-A074-7DEF969E466B@kernel.crashing.org>
In-Reply-To: <43765FEB-22D2-4435-A074-7DEF969E466B@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Randy may remember but this fixed an issue related that he was seeing  
> with an e100 or e1000 and it was the solution provided by the  Freescale 
> Apps team in Austin.
Hi All,
  Sorry for the delay in responding, I've been out sick on and off.

  The patch does not solve an erratum. It is required for proper operation if prefetching is enabled for any inbound PCI window.

  The problem is related to the buffers in the I/O Sequencer (Page 11-1 of the MPC8349 Manual Rev 2). There are 12 of these buffers, each the length of a cache line. When memory prefetching is enabled for an inbound PCI window, these buffers can get pre-loaded with data from main memory. If the processor subsequently modifies this data in main memory and cache coherency is not enabled, the contents of the I/O Sequencer's buffers do not get snooped and stale data is delivered to the PCI bus. If memory coherency is enabled, subsequent writes to pre-fetchable memory are snooped by the I/O Sequencer and the stale data problem is avoided.

  The connection to PCI erratum 5 was false. Marking the inbound PCI memory windows non-prefetchable solved the problem because the I/O Sequencers internal buffers were not pre-loaded and could not contain stale data.

  Kumar is correct in that the solution was provided by the folks at Freescale. Similar corruption has been seen when using a MPC107 host bridge with 74[45]x processors as the MPC107 also has an internal set of buffers that can contain stale data if prefetching is enabled on inbound PCI windows. In fact, there is a comment to that effect just above the comment adding the 83xx in the patch.

		Randy V.
