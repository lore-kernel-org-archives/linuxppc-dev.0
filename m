Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5722F68978
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:42:19 +1100 (EST)
Date: Thu, 29 Dec 2005 18:42:29 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20051229204229.GB9751@dmt.cnet>
References: <20051222195221.GA9494@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051222195221.GA9494@dmt.cnet>
Subject: Re: [PATCH] ppc32 8xx: last two 8MB D-TLB entries are incorrectly
	set
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2005 at 05:52:21PM -0200, Marcelo Tosatti wrote:
> Hi,
> 
> The last two 8MB TLB entries are being incorrectly set by initial_mmu on 8xx. 
> 
> The first entry is written with the same virtual/physical address, which
> renders it invalid:
> 
> BDI>rms 792 0x00001e00
> BDI>rms 824 1
> BDI>rds 824
> SPR  824 : 0xc08000c0  -1065353024
> BDI>rds 825
> SPR  825 : 0xc0800de0  -1065349664
> BDI>rds 826
> SPR  826 : 0x00000000            0
> 
> And the second entry, in addition, does not have its TLB index set
> correctly.
> 
> Dan, I'm afraid that, with this problem fixed, the issue you mentioned
> before with relation to conflicts with the vmalloc space becomes real.
> 
> * only pin available RAM at initial_mmu, the pinned mappings pointing
> beyond the end of physical RAM cause conflicts with vmalloc() space.
> 
> Is there any way to know the RAM size at this point in boot? The bd_t
> structure is board-specific, so no chance at offseting bd_t to reach the
> "mem_size" field.

None of this is necessary, we only need to define VMALLOC_START such
that it won't conflict with pinned space, as the Book-E 44x port already
does.
