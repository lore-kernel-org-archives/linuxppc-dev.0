Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78214DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 13:23:33 +1100 (EST)
Date: Wed, 2 Apr 2008 19:22:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: yhlu.kernel@gmail.com
Subject: Re: [PATCH] mm: make mem_map allocation continuous v2.
Message-Id: <20080402192223.5e8754a0.akpm@linux-foundation.org>
In-Reply-To: <200804021830.24563.yhlu.kernel@gmail.com>
References: <200804021525.48799.yhlu.kernel@gmail.com>
	<20080402155247.5e746be7.akpm@linux-foundation.org>
	<86802c440804021744m7c6e3d94vcb6af3ebcaa71b5b@mail.gmail.com>
	<200804021830.24563.yhlu.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Balbir, Kamalesh, kernel list <linux-kernel@vger.kernel.org>,
	Babulal <kamalesh@linux.vnet.ibm.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>, linuxppc-dev@ozlabs.org,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2 Apr 2008 18:30:24 -0700 Yinghai Lu <yhlu.kernel.send@gmail.com> wrote:

> v2 replace:
> 	[PATCH] mm: make mem_map allocation continuous.
> 	[PATCH] mm: allocate section_map for sparse_init
> 	[PATCH] mm: allocate usemap at first instead of mem_map in sparse_init
> 

err, no.

> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6a43c0..2881222 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c

Sorry, but I'd rather not do it this way.  We presently have this:

mm-make-mem_map-allocation-continuous.patch
mm-make-mem_map-allocation-continuous-checkpatch-fixes.patch
mm-fix-alloc_bootmem_core-to-use-fast-searching-for-all-nodes.patch
mm-allocate-section_map-for-sparse_init.patch
mm-allocate-section_map-for-sparse_init-update.patch
mm-allocate-section_map-for-sparse_init-update-fix.patch
mm-allocate-section_map-for-sparse_init-powerpc-fix.patch
mm-offset-align-in-alloc_bootmem.patch
mm-make-reserve_bootmem-can-crossed-the-nodes.patch
mm-make-reserve_bootmem-can-crossed-the-nodes-checkpatch-fixes.patch

and you purport to throw some of them away and combine them into a single
patch?  We assume that the later patches will still apply and work on top
of this newer patch?  It is up to me to check that the replacement patch
incorporates the third-party changes to the original patches?

Too hard, too risky.  Can't we just do a fix against 2.6.25-rc8-mm1?
