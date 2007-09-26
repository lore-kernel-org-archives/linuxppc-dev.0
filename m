Return-Path: <bwalle@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21911DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 18:15:40 +1000 (EST)
Date: Wed, 26 Sep 2007 10:15:34 +0200
From: Bernhard Walle <bwalle@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 5/7] Use extended crashkernel command line on ppc64
Message-ID: <20070926081534.GD11385@suse.de>
References: <20070925182257.900701776@strauss.suse.de>
	<20070925182259.398924232@strauss.suse.de>
	<20070925124534.b9da41a2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070925124534.b9da41a2.akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

* Andrew Morton <akpm@linux-foundation.org> [2007-09-25 21:45]:
> On Tue, 25 Sep 2007 20:23:02 +0200 Bernhard Walle <bwalle@suse.de> wrote:
> 
> > This patch adapts the ppc64 code to use the generic parse_crashkernel()
> > function introduced in the generic patch of that series.
> 
> I really don't like to see patches get a wholesale replacement, especially
> when they've been looked at by a few people and have had some testing, etc.
> It's not possible to see what changed and people need to re-review stuff
> they've already reviewed, etc.

Sorry, I didn't know that this is the preferred way. I just thought
it's more clear if the patches are replaced if the patch set is
finally pushed into Linus' tree.

> diff -puN arch/powerpc/kernel/machine_kexec.c~use-extended-crashkernel-command-line-on-ppc64-update arch/powerpc/kernel/machine_kexec.c
> --- a/arch/powerpc/kernel/machine_kexec.c~use-extended-crashkernel-command-line-on-ppc64-update
> +++ a/arch/powerpc/kernel/machine_kexec.c
> @@ -63,7 +63,7 @@ NORET_TYPE void machine_kexec(struct kim
>  
>  void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_size = 0, crash_base;
> +	unsigned long long crash_size, crash_base;
>  	int ret;
>  
>  	/* this is necessary because of lmb_phys_mem_size() */
> _
> 
> 
> which I suspect will now create a compiler warning.

No, it doesn't. I just verified this.

  CHK     include/linux/compile.h
  CC      arch/powerpc/kernel/machine_kexec.o
  LD      arch/powerpc/kernel/built-in.o


Thanks,
   Bernhard
-- 
Bernhard Walle <bwalle@suse.de>, Architecture Maintenance
SUSE LINUX Products GmbH, Nürnberg, Germany
GF: Markus Rex, HRB 16746 (AG Nürnberg)
OpenPGP: F61F 34CC 09CA FB82 C9F6  BA4B 8865 3696 DDAF 6454
