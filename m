Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91D26B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 11:23:10 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9F07QMd028384
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 20:07:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9F0N4Cd124732
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 20:23:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9F0N3Jc009099
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 21:23:04 -0300
Date: Thu, 14 Oct 2010 17:23:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC PATCH] ppc: don't override CONFIG_PPC_PSERIES_DEBUG
Message-ID: <20101015002300.GB7522@us.ibm.com>
References: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
	<1287101663.4194.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287101663.4194.5.camel@concordia>
Cc: Michael Neuling <mikey@neuling.org>, Frans Pop <elendil@planet.nl>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Linas Vepstas <linasvepstas@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.10.2010 [11:14:23 +1100], Michael Ellerman wrote:
> On Thu, 2010-10-14 at 10:48 -0700, Nishanth Aravamudan wrote:
> > These files undef DEBUG, but I think they were added before the ability
> > to control this from Kconfig. 
> 
> Perhaps. Some people, *cough*, have a tendency to merge those back in
> again from time to time :)
> 
> > It's really annoying to only get some of the debug messages!
> 
> True, but ..
> 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > ---
> > Because the lpar and pci_dlpar code is pretty low-level & verbose,
> > perhaps it makes sense to add another Kconfig variable for really
> > low-level stuff? But it's annoying to have DEBUG *somewhat* effective,
> > especially in the EEH area when doing PCI stuff.
> 
> I really don't think you want to enable the lpar debug by default.
> Have you tried it? It can make for a pretty unusable system, just
> because of the console spam.

Yeah, you're right. After enabling it, I had to kill my boot and start
over w/o the lpar DEBUG on. I assume dlpar_pci is similar?

I dunno, would a patch to a least remove the EEH one be ok? Seems like
it isn't super-verbose, and does have some handy output.

> Also these days there is CONFIG_DYNAMIC_DEBUG which is much smarter than
> all this, but requires setup at runtime.

True, I started looking into it, but only realized today that eeh.c had
that #undef! :)

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
