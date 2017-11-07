Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyv02pxzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:15 +1100 (AEDT)
In-Reply-To: <20171011123020.17594-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: cxl: Rework the implementation of cxl_stop_trace_psl9()
Message-Id: <3yWlyt5V5Hz9s7m@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-11 at 12:30:20 UTC, Vaibhav Jain wrote:
> Presently the PSL9 specific cxl_stop_trace_psl9() only stops the RX0
> traces on the CXL adapter when a PSL error irq is triggered. The patch
> updates the function to stop all the traces arrays and move them to
> the FIN state. The implementation issues the mmio to TRACECFG register
> to stop the trace array iff it already not in FIN state. This prevents
> the issue of trace data being reset in case of multiple stop mmio
> issued for a single trace array.
> 
> Also the patch does some refactoring of existing cxl_stop_trace_psl9()
> and cxl_stop_trace_psl8() functions by moving them to 'pci.c' from
> 'debugfs.c' file and marking them as static.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cbb55eeb49b116bb3880137661ad8c

cheers
