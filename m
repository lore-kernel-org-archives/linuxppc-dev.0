Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E11631A1D98
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 19:47:17 +1000 (AEST)
Message-ID: <1439372831.24479.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/xmon: Allow limiting the size of the paca display
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Date: Wed, 12 Aug 2015 19:47:11 +1000
In-Reply-To: <55CAFBC6.8060700@linux.vnet.ibm.com>
References: <1439362653-14665-1-git-send-email-mpe@ellerman.id.au>
 <55CAFBC6.8060700@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-12 at 13:24 +0530, Anshuman Khandual wrote:
> On 08/12/2015 12:27 PM, Michael Ellerman wrote:
> > @@ -2090,9 +2092,12 @@ static void dump_one_paca(int cpu)
> >  	printf(" %-*s = %s\n", 16, "present", cpu_present(cpu) ? "yes" : "no");
> >  	printf(" %-*s = %s\n", 16, "online", cpu_online(cpu) ? "yes" : "no");
> >  
> > +	i = 4; /* We always print the first four lines */
> > +
> >  #define DUMP(paca, name, format) \
> > -	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 16, #name, 18, paca->name, \
> > -		offsetof(struct paca_struct, name));
> > +	if (!num_lines || i++ < num_lines)
> 
> All look good except the fact that we are using 0 to signify that
> there is no limit to the number of lines. Is not it bit confusing ?

Maybe a bit, but it's the simplest option, and it's not uncommon for zero to
mean "no limit". chage(1) springs to mind as an example.

And in terms of xmon it's hardly the most confusing part :)

cheers
