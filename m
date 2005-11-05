Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id D2BBF6868B
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 04:50:22 +1100 (EST)
Date: Sat, 5 Nov 2005 10:50:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051105175020.GZ3839@smtp.west.cox.net>
References: <20051103183256.GJ3839@smtp.west.cox.net>
	<20051104211605.2ccffef5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051104211605.2ccffef5.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2005 at 09:16:05PM -0800, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > The ppc (not ppc64) boot loader (zimage wrapper) has a hard coded limit of
> > 4 MB on the size of an uncompressed kernel it can boot. The boot loader has
> > been changed to dynamically determine the largest possible kernel and
> > support it. Relocating the boot loader to a higher address (currently
> > located at 8 MB) will provide additional room.
> > 
> 
> I'm getting an unpleasant reject here from Matt's
> ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot.patch.  In
> decompress_kernel he has added this ifdef:
> 
> @@ -164,7 +172,9 @@ decompress_kernel(unsigned long load_add
>  		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
>  	}
>  
> +#ifndef CONFIG_40x /* don't overwrite the 40x image located at 0x00400000! */
>  	avail_ram = (char *)0x00400000;
> +#endif
>  	end_avail = (char *)0x00800000;
>  	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
>  	puthex((unsigned long)end_avail); puts("\n");
> 
> 
> Which would appear to leave avail_ram at zero on CONFIG_40x.  There's no
> mention in the changelog that this was the intent, so I dunno what's going
> on.

It's very confusing code, I'll agree, and it's not helped by a
long-missing cleanup.  Going back to
http://linux.bkbits.net:8080/linux-2.6/diffs/arch/ppc/boot/simple/misc.c@1.3?nav=index.html|src/|src/arch/ppc/boot/simple/|hist/arch/ppc/boot/simple/misc.c
we got to the point of doing:
avail_ram = good aligned end of images value;
... do nothing to or with avail_ram ...
avail_ram = 4MB;

What Mark's patch does is get us to use and aligned value again.  So if
I read everything right we should just be able to drop that hunk of
Matt's patch as we really won't be overwriting anyones image.  If you
throw out an interm tree somewhere hopefully Matt can do a quick boot
test on some 4xx board (I unfortunaly don't have one).

-- 
Tom Rini
http://gate.crashing.org/~trini/
