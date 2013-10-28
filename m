Return-Path: <rcj@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 663372C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 01:04:56 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcj@linux.vnet.ibm.com>;
 Mon, 28 Oct 2013 19:34:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 464033940017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:34:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9SE4kqZ26738812
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:34:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9SE4miR031981
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 19:34:48 +0530
Date: Mon, 28 Oct 2013 09:04:45 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Move local setup.h declarations to arch
 includes
Message-ID: <20131028140445.GA23635@linux.vnet.ibm.com>
References: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
 <1382729107-13560-3-git-send-email-rcj@linux.vnet.ibm.com>
 <20131028012819.GB8331@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131028012819.GB8331@concordia>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman (michael@ellerman.id.au) wrote:
> On Fri, Oct 25, 2013 at 02:25:07PM -0500, Robert C Jennings wrote:
> > Move the few declarations from arch/powerpc/kernel/setup.h
> > into arch/powerpc/include/asm/setup.h.  This resolves a
> > sparse warning for arch/powerpc/mm/numa.c which defines
> > do_init_bootmem() but can't include the setup.h header
> > in the prior path.
> > 
> > Resolves:
> > arch/powerpc/mm/numa.c:998:13:
> >         warning: symbol 'do_init_bootmem' was not declared.
> >                  Should it be static?
> 
> There's always a tension between too many well-focused-micro-headers,
> and too few random-piles-of-junk headers. I tend towards the former, but
> in this case I think you're right to drop setup.h.
> 
> > diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
> > index d3ca855..5e24df0 100644
> > --- a/arch/powerpc/include/asm/setup.h
> > +++ b/arch/powerpc/include/asm/setup.h
> > @@ -23,6 +23,11 @@ extern void reloc_got2(unsigned long);
> >  
> >  #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
> >  
> > +extern void check_for_initrd(void);
> > +extern void do_init_bootmem(void);
> > +extern void setup_panic(void);
> > +extern int do_early_xmon;
> 
> I don't see do_early_xmon used anywhere? Looks like I forgot to clean it
> up in 47679283. Mind dropping it?
> 
> I think these days it's trendy to not use extern in headers.
> 
> cheers

I'll clean that up and send again.

-Rob
