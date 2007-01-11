Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BD3ADDFAA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 05:26:15 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0BIQAdK291402
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:26:11 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0BIQAch1175746
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:26:10 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0BIQAaN007975
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 18:26:10 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.21 0/8] ehca: remove use of do_mmap() from kernel
	space and minor cleanup
Date: Thu, 11 Jan 2007 19:22:27 +0100
References: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200701111807.08593.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701111922.27474.hnguyen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please ignore this. Pushed the send button to fast again.
Regards
Nam

On Thursday 11 January 2007 18:07, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> Here is a set of patches for ehca, whose main purpose is to remove unproper use of
> do_mmap() in ehca kernel space as suggested by Christoph H. Other "small" changes
> are:
> * Remove "dead" prototype declarations (those without code implementation)
> * Use SLAB_ defines instead GFP_ ones when allocating memory from slab cache
> 
> Actually I should separate those patches for more clarity. Unfortunately that
> code cleanup above has been incorporated much earlier in our repository, and
> I had not paid attention on when I started to rework the mmap() stuff. Sorry
> for this inconvenience!
> 
> Now more detail on mmap() rework:
> - For eHCA hardware register block we use remap_pfn_range() as previously.
> - For queue pages we call pattern vm_insert_page() to register each allocated
> kernel page.
> - For each mmap-ed resource (hardware register block, send/recv and completion
> queue) we introduce a use counter that is incremented and decremented by
> the call-backs open()/close(). Destroying a completion queue or queue pair
> will succeed only if all associated counters are zero. That means those resources
> must be mmap-ed resp. munmap-ed properly by user space.
> 
> Thanks
> Nam
> 
