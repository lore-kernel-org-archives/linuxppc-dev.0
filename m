Return-Path: <sfbest@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 376DCB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 04:21:15 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p11H8p5i028945
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 10:08:51 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p11HLBZh105016
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 10:21:11 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p11HLALS001578
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Feb 2011 10:21:10 -0700
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
From: Steve Best <sfbest@us.ibm.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110131134057.153d6844@udp111988uds.am.freescale.net>
References: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<20110131134057.153d6844@udp111988uds.am.freescale.net>
Content-Type: text/plain
Date: Tue, 01 Feb 2011 12:21:45 -0500
Message-Id: <1296580906.5343.6.camel@dhcp-100-2-27.bos.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2011-01-31 at 13:40 -0600, Scott Wood wrote:
> On Mon, 31 Jan 2011 14:16:00 -0500
> Steve Best <sfbest@us.ibm.com> wrote:
> 
> >     Provide devmem_is_allowed() routine to restrict access to kernel
> >     memory from userspace.
> >     Set CONFIG_STRICT_DEVMEM config option to switch on checking.
> > 
> > Signed-off-by: Steve Best <sfbest@us.ibm.com>
> > 
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index 2d38a50..6805d5d 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -299,4 +299,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
> >  	  platform probing is done, all platforms selected must
> >  	  share the same address.
> >  
> > +config STRICT_DEVMEM
> > +        def_bool y
> > +        prompt "Filter access to /dev/mem"
> > +        ---help---
> > +          This option restricts access to /dev/mem.  If this option is
> > +          disabled, you allow userspace access to all memory, including
> > +          kernel and userspace memory. Accidental memory access is likely
> > +          to be disastrous.
> > +          Memory access is required for experts who want to debug the kernel.
> > +
> > +          If you are unsure, say Y.
> > +
> >  endmenu
> > diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> > index 53b64be..f225032 100644
> > --- a/arch/powerpc/include/asm/page.h
> > +++ b/arch/powerpc/include/asm/page.h
> > @@ -262,6 +262,11 @@ extern void copy_user_page(void *to, void *from, unsigned long vaddr,
> >  		struct page *p);
> >  extern int page_is_ram(unsigned long pfn);
> >  
> > +static inline int devmem_is_allowed(unsigned long pfn)
> > +{
> > +        return 0;
> > +}
> > +
> 
> I don't see how this is a sane thing to turn on by default (you're not
> restricting it, BTW -- you're completely disabling it with that
> implementation of devmem_is_allowed).  It will break anything that
> uses /dev/mem to access I/O, 

could you expand on what I/O depends on /dev/mem, so I can take
that into account?

> possibly including desktoppy stuff like X
> servers, 

you are right just found out that X needs to access it. will 
take that into account
> as well as lots of stuff that goes on in embedded setups.

could you explain more about what needs access to /dev/mem in 
the embedded setups?

> 
> You need to be root to access /dev/mem, and root has plenty of
> other options for causing "disastrous" results.  You don't just stumble
> onto /dev/mem by accident.
> 
> -Scott

-Steve
