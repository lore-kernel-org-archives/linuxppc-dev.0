Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 2B33367B83
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 08:31:22 +1000 (EST)
Date: Thu, 19 Oct 2006 15:31:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17719.64246.555371.701194@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006, Paul Mackerras wrote:

> What exactly does "available" mean in this context?  The console log I
> posted earlier showed node 0 as having an active PFN range of 32768 -
> 278528 (245760 pages, or 960MB), and then showed a "freeing bootmem
> node 0" message, *before* we hit the BUG.

Available in the sense that the page allocator can allocate from them. 
Will's console output shows that all memory of node 0 is allocated and not 
available.

> If "available" doesn't mean "there are active pages which have been
> given to the VM system via free_all_bootmem_node()", what does it
> mean?

The page allocator must be running and able to serve pages from the boot 
node. This fails for some reason and the slab cannot bootstrap. The memory 
not available is the first guess. Could you trace the allocation in the 
page allocator (__alloc_pages) when the slab attempts to bootstrap and 
figure out why exactly the allocation fails?
