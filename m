Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23D121A0038
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 21:06:38 +1000 (AEST)
Date: Sun, 27 Sep 2015 13:06:33 +0200
From: Torsten Duwe <duwe@lst.de>
To: Anton Blanchard <anton@samba.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: -mprofile-kernel vs. notrace in ppc64(le) Linux kernels
Message-ID: <20150927110633.GA9572@lst.de>
References: <20150926143008.GA14606@lst.de>
 <20150926145243.GA14958@gate.crashing.org> <20150927090348.3c725ab4@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150927090348.3c725ab4@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 27, 2015 at 09:03:48AM +1000, Anton Blanchard wrote:
> > On Sat, Sep 26, 2015 at 04:30:08PM +0200, Torsten Duwe wrote:
> > > kernel. It is mapped to GCC's (4.8, FWIW)
> > > __attribute__((no_instrument_function)), which, to my surprise,
> > > works for -p and -pg nicely, but does not affect -mprofile-kernel
> > > at all!
> 
> This sounds like the issue below, fixed by Pat.
> 
> diff --git a/gcc/config/rs6000/rs6000.c b/gcc/config/rs6000/rs6000.c
> index 289b52c..a479219 100644
> --- a/gcc/config/rs6000/rs6000.c
> +++ b/gcc/config/rs6000/rs6000.c
> @@ -23198,7 +23198,7 @@ rs6000_output_function_prologue (FILE *file,
>    /* Output -mprofile-kernel code.  This needs to be done here instead of
>       in output_function_profile since it must go after the ELFv2 ABI
>       local entry point.  */
> -  if (TARGET_PROFILE_KERNEL)
> +  if (TARGET_PROFILE_KERNEL && crtl->profile)
>      {
>        gcc_assert (DEFAULT_ABI == ABI_AIX || DEFAULT_ABI == ABI_ELFv2);
>        gcc_assert (!TARGET_32BIT);

Yes, indeed!
I can see the fix in the 4.9 branch, it's in 5.x and 6.x, but _not_ in 4.8.5 :(
That's what you get when you use "stable" distributions.

Thanks a lot for the pointer!

	Torsten
