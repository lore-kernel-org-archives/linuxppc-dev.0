Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJhnK6VsvzDvkw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:27:33 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGBNXBf044770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:27:30 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rjhe9nj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:27:29 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 21:27:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7C5583578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:27:25 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAGBRPo663504630
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:27:25 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAGBROiW017796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:27:25 +1100
Date: Wed, 16 Nov 2016 16:57:23 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc: crypto/vmx: clean up generated files
References: <20161115170549.10538-1-naveen.n.rao@linux.vnet.ibm.com>
 <87oa1fyc7s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oa1fyc7s.fsf@concordia.ellerman.id.au>
Message-Id: <20161116112723.GC4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/16 09:02PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > ..as stray .S files result in build errors, especially when using
> > cross-compilers.
> 
> They should be cleaned on make clean, so adding them to clean-files
> seems correct.
> 
> > More specifically, the generated .S files are endian-specific and will break
> > subsequent builds targeting the other endian architecture.
> 
> But that indicates we're missing an if_changed somewhere, ie. switching
> endian should cause them to be regenerated.
> 
> Also they should be generated into $(obj) not $(src) I think.
> 
> How about this?

Nice!

> 
> diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
> index de6e241..52f6ae9 100644
> --- a/drivers/crypto/vmx/Makefile
> +++ b/drivers/crypto/vmx/Makefile
> @@ -10,10 +10,10 @@ endif
>  quiet_cmd_perl = PERL $@
>        cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
> 

Looks like we also need:

targets += aesp8-ppc.S ghashp8-ppc.S

> -$(src)/aesp8-ppc.S: $(src)/aesp8-ppc.pl
> -       $(call cmd,perl)
> +$(obj)/aesp8-ppc.S: $(src)/aesp8-ppc.pl FORCE
> +       $(call if_changed,perl)
>    
> -$(src)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl
> -       $(call cmd,perl)
> +$(obj)/ghashp8-ppc.S: $(src)/ghashp8-ppc.pl FORCE
> +       $(call if_changed,perl)
> 
>  .PRECIOUS: $(obj)/aesp8-ppc.S $(obj)/ghashp8-ppc.S

I will send a v2 with these changes.

Thanks,
Naveen
