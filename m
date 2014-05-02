Return-Path: <linuxram@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7A353140159
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:47:47 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 2 May 2014 13:47:44 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 473406E8041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 13:47:34 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s42HlfxA55377990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 May 2014 17:47:41 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s42HleI6014446
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 May 2014 13:47:40 -0400
Date: Fri, 2 May 2014 10:47:36 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is
 enabled
Message-ID: <20140502174736.GA5045@ram.oc3035372033.ibm.com>
References: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
 <87wqe4age2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wqe4age2.fsf@linux.vnet.ibm.com>
Cc: hartb@us.ibm.com, paulus@samba.org, anton@samba.org, tony@ozlabs.au.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 02, 2014 at 11:09:17AM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> >     powerpc: crtsaveres.o needed only when -Os flag is enabled
> >     
> >     Currently on powerpc arch, out-of-tree module fails to build without
> >     crtsaveres.o, even when the module has no dependency on the symbols
> >     provided by the file; when built without the -Os flag.
> >     
> >     BTW: '-Os' flag is enabled when CONFIG_CC_OPTIMIZE_FOR_SIZE is
> >     configured.
> >     
> >     This patch fixes that problem.
> >     
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 4c0cedf..cf12f38 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -157,7 +157,10 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
> >  
> >  CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
> >  
> > +ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> > +endif
> > +
> >  
> >  # No AltiVec or VSX instructions when building kernel
> >  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
> >
> 
> So if we enable CONFIG_CC_OPTIMIZE_FOR_SIZE can we build out-of-tree
> module with this patch ?

	Yes, provided crtsaveres.o is available.


If crtsaveres.o is not available; some distro dont ship it, than
out-of-tree module linking will fail.

Some distro don't ship crtsaveres.o since they do not want
kernel and modules to be built with space optimization. In such cases
requiring crtsaveres.o to be available during module building, even
when the module is not built for space optimization is wrong.

This patch fixes that issue.

RP
