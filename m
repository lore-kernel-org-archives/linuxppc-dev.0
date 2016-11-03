Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8bgb67d7zDt0W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 18:09:31 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so3981902pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 00:09:31 -0700 (PDT)
Date: Thu, 3 Nov 2016 18:09:21 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
Message-ID: <20161103180921.5506327e@roar.ozlabs.ibm.com>
In-Reply-To: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161103155531.4e86d906@roar.ozlabs.ibm.com>
 <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  3 Nov 2016 12:23:17 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2016/11/03 03:55PM, Nicholas Piggin wrote:
> > On Wed, 2 Nov 2016 13:49:39 +0300
> > Denis Kirjanov <kda@linux-powerpc.org> wrote:
> >   
> > > Hi guys,
> > > 
> > > compiling ppc head with bunch of asm errors on power8 box (gcc version 4.8.3 )
> > > checked commit log but found nothing special. Looks like it's asm issue?
> > > Has anybody seen that?
> > > 
> > > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > > arch/powerpc/kernel/exceptions-64s.S:421: Error: operand out of range
> > > (0xffffffffffff8680 is not between 0x0000000000000000 and
> > > 0x000000000000ffff)  
> > 
> > Hey, thanks for the report. It's likely due to the exception vectors rewrite,
> > and yes it's an assembler issue (what's your binutils version?). Your errors
> > look like they're coming from LOAD_HANDLER(). For some reason it seems to be
> > interpreting the immediate as signed, or the actual calculation ends up being
> > negative, neither of which should happen.
> > 
> > It might take a bit of trial and error, and the assembler doesn't give a lot
> > of good options to debug it, so if I can reproduce it here with your bintuils
> > version it will be helpful.  
> 
> I saw this issue when trying to do a BE build on RHEL 7.1. The below
> fixes this for me and it indeed looks like an issue with the assembler.
> Interestingly, the same assembler version on RHEL 7.1 LE does not throw
> these errors.
> 
> [root@rhel71be linux]# gcc --version
> gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-8)
> <snip>
> [root@rhel71be linux]# as --version
> GNU assembler version 2.23.52.0.1-26.el7 20130226
> <snip>
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 2e4e7d8..9b7b302 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -91,7 +91,7 @@
>   */
>  #define LOAD_HANDLER(reg, label)					\
>  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> -	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> +	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);
>  
>  /* Exception register prefixes */
>  #define EXC_HV	H

Thanks for taking a look. Does this patch fix it, or just hide the build
error? This would presumably hide real bugs too, so it will be good if we
can make it conditional on older assemblers, or otherwise do a test for
out of bounds value (you could try asm directives like .if/.error)

Thanks,
Nick
