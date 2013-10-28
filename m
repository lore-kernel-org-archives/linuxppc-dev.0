Return-Path: <michael@ellerman.id.au>
Date: Mon, 28 Oct 2013 12:28:19 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Robert C Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Move local setup.h declarations to arch
 includes
Message-ID: <20131028012819.GB8331@concordia>
References: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
 <1382729107-13560-3-git-send-email-rcj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382729107-13560-3-git-send-email-rcj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 25, 2013 at 02:25:07PM -0500, Robert C Jennings wrote:
> Move the few declarations from arch/powerpc/kernel/setup.h
> into arch/powerpc/include/asm/setup.h.  This resolves a
> sparse warning for arch/powerpc/mm/numa.c which defines
> do_init_bootmem() but can't include the setup.h header
> in the prior path.
> 
> Resolves:
> arch/powerpc/mm/numa.c:998:13:
>         warning: symbol 'do_init_bootmem' was not declared.
>                  Should it be static?

There's always a tension between too many well-focused-micro-headers,
and too few random-piles-of-junk headers. I tend towards the former, but
in this case I think you're right to drop setup.h.

> diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
> index d3ca855..5e24df0 100644
> --- a/arch/powerpc/include/asm/setup.h
> +++ b/arch/powerpc/include/asm/setup.h
> @@ -23,6 +23,11 @@ extern void reloc_got2(unsigned long);
>  
>  #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
>  
> +extern void check_for_initrd(void);
> +extern void do_init_bootmem(void);
> +extern void setup_panic(void);
> +extern int do_early_xmon;

I don't see do_early_xmon used anywhere? Looks like I forgot to clean it
up in 47679283. Mind dropping it?

I think these days it's trendy to not use extern in headers.

cheers
