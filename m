Return-Path: <mgreer@mvista.com>
Date: Tue, 31 Oct 2006 16:02:01 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] bootwrapper: prevent fdt from being overwritten by kernel
Message-ID: <20061031230201.GA28709@mag.az.mvista.com>
References: <20061026225045.GA19839@mag.az.mvista.com>
	<17733.31929.136137.129244@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17733.31929.136137.129244@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 30, 2006 at 03:16:57PM +1100, Paul Mackerras wrote:
> Mark A. Greer writes:
> > In addition, I moved the vmlinux elf header decompress code from
> > prep_kernel() to its own routine and called it before platform_init.
> > I then pass the elf header ptr into platform_init.  That way,
> > platform_init can figure out where the end of the kernel will
> > be and put the dtb beyond it.  The OF code can now change
> > claim_base in platform_init instead of needing the platform_ops.image_hdr
> > hook.
> 
> Hmmm.  What if platform_init needs to e.g. turn on caches or do other
> things that need to be done before decompressing?  I think it's
> important to provide some way for the platform code to do things
> really early on.

Good point.  I'll make a separate hook so it'll be platform_init, then
get_elfheader, then call new hook, then open console & do the rest.

Mark
