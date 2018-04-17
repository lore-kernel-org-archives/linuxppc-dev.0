Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QKk1649GzF1vG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:30:49 +1000 (AEST)
Date: Tue, 17 Apr 2018 19:30:44 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/misc: get rid of add_reloc_offset()
Message-ID: <20180417093044.GA9105@fergus.ozlabs.ibm.com>
References: <20180417075624.962AB6C038@po15720vm.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180417075624.962AB6C038@po15720vm.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 09:56:24AM +0200, Christophe Leroy wrote:
> add_reloc_offset() is almost redundant with reloc_offset()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/setup.h       |  3 +--
>  arch/powerpc/kernel/misc.S             | 16 ----------------
>  arch/powerpc/kernel/prom_init_check.sh |  2 +-
>  3 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
> index 27fa52ed6d00..115e0896ffa7 100644
> --- a/arch/powerpc/include/asm/setup.h
> +++ b/arch/powerpc/include/asm/setup.h
> @@ -17,10 +17,9 @@ extern void note_scsi_host(struct device_node *, void *);
>  
>  /* Used in very early kernel initialization. */
>  extern unsigned long reloc_offset(void);
> -extern unsigned long add_reloc_offset(unsigned long);
>  extern void reloc_got2(unsigned long);
>  
> -#define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
> +#define PTRRELOC(x)	((typeof(x)) ((unsigned long)(x) + reloc_offset()))

NAK.  This is how it used to be, and we changed it in order to prevent
gcc from making incorrect assumptions.  If you use the form with the
explicit addition, and x is the address of an array, gcc will assume
that the result is within the bounds of the array (apparently the C
standard says it can do that) and potentially generate incorrect
code.  I recall that we had an actual case where gcc was generating
incorrect code, though I don't recall the details, as this was some
time before 2002.

Paul.
