Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B3C81A03D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Nov 2014 20:02:17 +1100 (AEDT)
Message-ID: <1417338119.2852.37.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2]powerpc: foundation code to handle CR5 for local_t
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Sun, 30 Nov 2014 20:01:59 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FE54E@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1417090721-25298-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1417136200.2852.14.camel@kernel.crashing.org>
 <5477E8C1.9030600@linux.vnet.ibm.com>
 <1417144874.2852.21.camel@au1.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FE54E@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-28 at 10:53 +0000, David Laight wrote:
> From: Benjamin Herrenschmidt
> > On Fri, 2014-11-28 at 08:45 +0530, Madhavan Srinivasan wrote:
> > > > Can't we just unconditionally clear at as long as we do that after we've
> > > > saved it ? In that case, it's just a matter for the fixup code to check
> > > > the saved version rather than the actual CR..
> > > >
> > > I use CR bit setting in the interrupt return path to enter the fixup
> > > section search. If we unconditionally clear it, we will have to enter
> > > the fixup section for every kernel return nip right?
> > 
> > As I said above. Can't we look at the saved version ?
> > 
> > IE.
> > 
> >  - On interrupt entry:
> > 
> > 	* Save CR to CCR(r1)
> > 	* clear CR5
> > 
> >  - On exit
> > 
> > 	* Check CCR(r1)'s CR5 field
> > 	* restore CR
> 
> Actually there is no real reason why the 'fixup' can't be done
> during interrupt entry.

Other than if we crash, we get the wrong PC in the log etc... unlikely
but I tend to prefer this. Also if we ever allow something like a local
atomic on a faulting (uesrspace) address, we want a precise PC on entry.

Generally, we have a lot more entry path than exit path, it's easier to
keep the entry path simpler.

Cheers,
Ben.

> 	David
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
