Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMRCM24tPzF0gZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 12:27:27 +1100 (AEDT)
Date: Thu, 18 Jan 2018 12:27:24 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 3/6] KVM: PPC: Book3S HV: Allow HPT and radix on the same
 core for POWER9 v2.2
Message-ID: <20180118012724.GB22300@fergus.ozlabs.ibm.com>
References: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
 <1516182675-25331-4-git-send-email-paulus@ozlabs.org>
 <1516187685.31850.190.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516187685.31850.190.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 17, 2018 at 10:14:45PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2018-01-17 at 20:51 +1100, Paul Mackerras wrote:
> > +
> > +       /*
> > +        * POWER9 chips before version 2.02 can't have some threads in
> > +        * HPT mode and some in radix mode on the same core.
> > +        */
> > +       if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +               unsigned int pvr = mfspr(SPRN_PVR);
> > +               if ((pvr >> 16) == PVR_POWER9 && (pvr & 0xfff) < 0x202)
> > +                       no_mixing_hpt_and_radix = true;
> > +       }
> > +
> >         return r;
> >  }
> 
> You need to check that it's a Nimbus using the top nimble of the bottom
> 16 bits of PVR. For Cumulus, the fixes are either in 1.0 or 1.1 (to
> check).

OK, how about this for the check:

	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
		unsigned int pvr = mfspr(SPRN_PVR);
		if ((pvr >> 16) == PVR_POWER9 &&
		    (((pvr & 0xe000) == 0 && (pvr & 0xfff) < 0x202) ||
		     ((pvr & 0xe000) == 0x2000 && (pvr & 0xfff) < 0x101)))
			no_mixing_hpt_and_radix = true;
	}

Paul.
