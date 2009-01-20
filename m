Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id B1F00DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 09:51:34 +1100 (EST)
Date: Wed, 21 Jan 2009 08:30:01 +1100
From: Simon Horman <horms@verge.net.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [patch] Possible fix for kexec-tools dynamic range allocation
Message-ID: <20090120212959.GA3564@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231308086.27416.14.camel@localhost>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, muvarov@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 05:01:26PM +1100, Michael Ellerman wrote:
> Hi all,
> 
> The patch to dynamically allocate memory regions for ppc64 kexec-tools,
> ie. "ppc64: kexec memory ranges dynamic allocation" (d182ce5), has never
> worked AFAICT.
> 
> Chandru reported it as broken when it was posted:
> http://lists.infradead.org/pipermail/kexec/2008-October/002751.html
> 
> Still, it's in now, and I'm trying to work out what's going wrong.
> 
> The symptom is as reported by Chandru, we end up not being able to
> allocate any memory (in locate_hole()). This is caused by the list of
> memory_ranges being empty.
> 
> The memory_ranges are empty because they have been realloc'ed (by the
> dynamic alloc code), and the generic code is still looking at the old
> version.
> 
> What I'm not clear on is why the ppc64 code is even calling
> setup_memory_ranges() a second time (in elf_ppc64_load()). It's already
> been called by get_memory_ranges() from my_load(). Or is there another
> route into elf_ppc64_load() that I'm not seeing?
> 
> And in fact if I just remove that call, then everything is peachy.
> 
> The following patch makes it work for me at least.

Hi Michael,

I must confess that I don't have a complete understanding of this problem.
Does Bernhard's recent patch (sorry that I applied it even though
it came in after your patch) help this problem?

commit 95c74405638c786bc76fbca5e4e8427dfe26e907
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jan 16 19:11:34 2009 +0100
Subject: Fix memory corruption when using realloc_memory_ranges()

> >From 40958d8f957876ca612b666f40bebf28ea335314 Mon Sep 17 00:00:00 2001
> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Wed, 7 Jan 2009 16:57:05 +1100
> Subject: [PATCH] Don't call setup_memory_ranges() again
> 
> There's no need to call setup_memory_ranges() again. Furthermore it can
> lead to the memory_ranges being realloc'ed, which results in the generic
> code (locate_hole() etc.) using the free'd memory_ranges.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  kexec/arch/ppc64/kexec-elf-ppc64.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
> index 21533cb..1e2d5a3 100644
> --- a/kexec/arch/ppc64/kexec-elf-ppc64.c
> +++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
> @@ -151,8 +151,6 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
>  	if (ramdisk && reuse_initrd)
>  		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
>  
> -	setup_memory_ranges(info->kexec_flags);
> -
>  	/* Need to append some command line parameters internally in case of
>  	 * taking crash dumps.
>  	 */
> -- 
> 1.5.3.7.1.g4e596e
> 
> 

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
