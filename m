Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDXgn3x2XzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 19:08:37 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v127wdDT115820
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 03:08:34 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bt81c3u6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 03:08:33 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 2 Feb 2017 13:38:31 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 049AD3940060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 13:38:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1288TB239059698
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 13:38:29 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1288SAw002080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 13:38:29 +0530
Date: Thu, 2 Feb 2017 13:38:27 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/3] powerpc: allow compilation on cross-endian toolchain
References: <20161123130209.1667-1-npiggin@gmail.com>
 <20161123130209.1667-3-npiggin@gmail.com>
 <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
 <87lgw6snp4.fsf@concordia.ellerman.id.au>
 <20161127134620.74007843@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161127134620.74007843@roar.ozlabs.ibm.com>
Message-Id: <20170202080827.GC4090@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/27 01:46PM, Nicholas Piggin wrote:
> On Sat, 26 Nov 2016 18:30:15 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > > On Thu, 24 Nov 2016 00:02:08 +1100
> > > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > > index 617dece..8828807 100644
> > > --- a/arch/powerpc/Makefile
> > > +++ b/arch/powerpc/Makefile
> > > @@ -73,13 +73,18 @@ MULTIPLEWORD	:= -mmultiple
> > >  endif
> > >  
> > >  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
> > > +cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
> > > +cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)  
> > 
> > This blew up the world:
> > 
> >   http://kisskb.ellerman.id.au/kisskb/head/1ba4cb3d67e181bdc9a911d7be81f64e3d7597d2/
> > 
> >   Successful:	24% 63/258
> > 
> > I suspect you need to make -mcall-aixdesc 64-bit only.
> 
> Yes, I forgot 32-bit will pick those up. 3rd time's a charm, this compiles
> 64 bit be/le and 32-bit now.
> 
> --
> 
> Subject: [PATCH] powerpc: allow compilation on cross-endian toolchain
> 
> GCC can compile with either endian, but the ABI version always
> defaults to the default endian. Alan Modra says:
> 
>   you need both -mbig and -mabi=elfv1 to make a powerpc64le gcc
>   generate powerpc64 code
> 
> The opposite is true for powerpc64 when generating -mlittle it
> requires -mabi=elfv2 to generate v2 ABI. This change adds ABI
> annotations together with endianness. The kernel with ELFv2 ABI
> also uses -mcall-aixdesc, but boot/ does not.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

FWIW, this fixes the issue with vmx build when doing a BE build with LE 
toolchain:
	/tmp/ccR5lr0U.s: Error: .size expression for aes_p8_set_encrypt_key does not evaluate to a constant
	/tmp/ccR5lr0U.s: Error: .size expression for .aes_p8_set_encrypt_key does not evaluate to a constant
	/tmp/ccR5lr0U.s: Error: .size expression for aes_p8_set_decrypt_key does not evaluate to a constant
	/tmp/ccR5lr0U.s: Error: .size expression for .aes_p8_set_decrypt_key does not evaluate to a constant
	/tmp/ccR5lr0U.s: Error: .size expression for aes_p8_encrypt does not evaluate to a constant
	/tmp/ccR5lr0U.s: Error: .size expression for .aes_p8_encrypt does not evaluate to a constant

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen
