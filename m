Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EE0A1A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 11:01:43 +1100 (AEDT)
Message-ID: <1418601701.19970.4.camel@ellerman.id.au>
Subject: Re: [v4,4/4] powernv: powerpc: Add winkle support for offline cpus
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Date: Mon, 15 Dec 2014 11:01:41 +1100
In-Reply-To: <548D7A0E.2060107@linux.vnet.ibm.com>
References: <20141214100600.3446B140119@ozlabs.org>
 <548D7A0E.2060107@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-12-14 at 17:22 +0530, Shreyas B Prabhu wrote:
> On Sunday 14 December 2014 03:35 PM, Michael Ellerman wrote:
> >> diff --git a/arch/powerpc/platforms/powernv/subcore.h b/arch/powerpc/platforms/powernv/subcore.h
> >> index 148abc9..604eb40 100644
> >> --- a/arch/powerpc/platforms/powernv/subcore.h
> >> +++ b/arch/powerpc/platforms/powernv/subcore.h
> >> @@ -15,4 +15,5 @@
> >>  
> >>  #ifndef __ASSEMBLY__
> >>  void split_core_secondary_loop(u8 *state);
> >> +extern void update_subcore_sibling_mask(void);
> >>  #endif
> > 
> > subcore.c isn't built for CONFIG_SMP=n, resulting in:
> > 
> >   setup.c:(.init.text+0x34b0): undefined reference to `.update_subcore_sibling_mask'
> > 
> > I needed to add:
> > 
> > +#else
> > +static inline void update_subcore_sibling_mask(void) { };
> > +#endif /* CONFIG_SMP */

> Sorry I missed that.

No worries.

Can you please do a quick test with a SMP=n kernel.

It looks like it should work, but it would be good to test.

cheers
