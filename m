Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83EA9B70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Oct 2010 21:03:52 +1100 (EST)
Subject: Re: 64K PAGE_SIZE and arch/powerpc/kernel/vdso.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <7015.1287359052@neuling.org>
References: <1287216239.9909.234.camel@haakon2.linux-iscsi.org>
	<7015.1287359052@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Oct 2010 21:03:36 +1100
Message-ID: <1287396216.2341.4.camel@pasglop>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, Tim Abbott <tabbott@ksplice.com>,
	linuxppc-dev@lists.ozlabs.org,
	"Nicholas A. Bellinger" <nab@linux-iscsi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-18 at 10:44 +1100, Michael Neuling wrote:
> > Greetings Linux-ppc64 folks,
> > 
> > While trying to compile v2.6.36-rc8 with PAGE_SIZE=65536 I run into the
> > following compile failure w/ strict checking on a RHEL5.4 / gcc (GCC)
> > 4.1.2 20080704 (Red Hat 4.1.2-46) system:
> > 
> > cc1: warnings being treated as errors
> > arch/powerpc/kernel/vdso.c:81: warning: alignment of ‘vdso_data_store’
> > is greater than maximum object file alignment.  Using 32768
> >   CC      arch/powerpc/sysdev/msi_bitmap.o
> > make[1]: *** [arch/powerpc/kernel/vdso.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > 
> > Any ideas folks..?
> 
> It seems this broke it:

Yes, this is a known (old) issue. You can apply the workaround locally
if you really want to build with that old toolchain, but the risk is
that if an object whose size is not a multiple of PAGE_SIZE is put in
the .data.page_aligned section, your vdso data page might end up not
being aligned properly. Fortunately that doesn't generally happen but
it's worth double checking your System.map...

This is the reason I decided to leave it alone in the kernel and
encourage people to update their toolchain (and binutils).

Cheers,
Ben.

> commit abe1ee3a221d53778c3e58747bbec6e518e5471b
> Author: Tim Abbott <tabbott@ksplice.com>
> Date:   Sun Sep 20 18:14:15 2009 -0400
> 
>     Use macros for .data.page_aligned section.
>     
>     This patch changes the remaining direct references to
>     .data.page_aligned in C and assembly code to use the macros in
>     include/linux/linkage.h.
> 
> Backing out just that part of the change (see below) fixes it.
> 
> FYI the error only occurs on gcc 4.1 and 4.2.  4.3 and greater is fine.  
> 
> Mikey
> 
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index 13002fe..c140fce 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -78,7 +78,7 @@ static int vdso_ready;
>  static union {
>  	struct vdso_data	data;
>  	u8			page[PAGE_SIZE];
> -} vdso_data_store __page_aligned_data;
> +} vdso_data_store __attribute__((__section__(".data.page_aligned")));
>  struct vdso_data *vdso_data = &vdso_data_store.data;
>  
>  /* Format of the patch table */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
