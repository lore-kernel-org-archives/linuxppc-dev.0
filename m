Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 4BEB7DDE25
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 17:49:13 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so826956rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 23:49:11 -0700 (PDT)
Date: Sat, 18 Oct 2008 00:49:09 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: build failure on powerpc with current -git
Message-ID: <20081018064909.GB5594@secretlab.ca>
References: <48F8E86B.702@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F8E86B.702@nortel.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 01:32:59PM -0600, Chris Friesen wrote:
> The current -git fails to build on 64-bit powerpc (failure log below) .  
> Initially I tried using my older toolchain, when I first saw the problem 
> I built a new toolchain with crosstool (gcc 4.1.2 and binutils 2.16.1) 
> and tried again but got the same problem.
>
> 2.6.27 doesn't show this problem.
>
> Any ideas what's going on and how I can fix it?

This is a know bug with binutils 2.16.1.  You can work around it by
either reverting commit 549e8152de8039506f69c677a4546e5427aa6ae7 or
upgrading to a newer version of binutils.

Nobody has a fix for this problem yet.  (it's definitely a binutils bug,
but the kernel exposed it where it wasn't an issue before.  I don't know
if support for 2.16.1 is going to be depreciated due to this.  It seems
like there are still a fair few users of binutils 2.16.1)

g.

>
> Thanks,
>
> Chris
>
>
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: modpost: Found 4 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
 
> /opt/crosstool/gcc-4.1.2-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: 
> BFD 2.16.1 internal error, aborting at  
> /home/cfriesen/crosstool-0.43/build/powerpc64-unknown-linux-gnu/gcc-4.1.2-glibc-2.3.6/binutils-2.16.1/bfd/elflink.c 
> line 6419 in elf_link_output_extsym
>
 
> /opt/crosstool/gcc-4.1.2-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: 
> Please report this bug.
>
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
