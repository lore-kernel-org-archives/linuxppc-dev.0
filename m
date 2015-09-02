Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8D871A1E16
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 11:37:33 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0140.outbound.protection.outlook.com [157.56.111.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D6B9140281
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2015 11:37:31 +1000 (AEST)
Message-ID: <1441152192.4966.103.camel@freescale.com>
Subject: Re: powerpc: Add user-return-notifier support
From: Scott Wood <scottwood@freescale.com>
To: <ananth@in.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>, "Paul
 Mackerras" <paulus@samba.org>, <ego@linux.vnet.ibm.com>
Date: Tue, 1 Sep 2015 19:03:12 -0500
In-Reply-To: <20150901064113.GA1196@in.ibm.com>
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org> <20150901064113.GA1196@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-01 at 12:11 +0530, Ananth N Mavinakayanahalli wrote:
> On Mon, Aug 31, 2015 at 08:35:17PM +1000, Michael Ellerman wrote:
> > On Tue, 2015-25-08 at 05:41:10 UTC, Ananth N Mavinakayanahalli wrote:
> > > Add user return notifier support for powerpc. Similar to x86, this 
> > > feature
> > > keys off of the KVM Kconfig.
> > 
> > Please flesh this out.
> > 
> > What is it, why do we want it, why is your implementation correct.
> 
> The only current in-kernel user of the infrastructure is KVM on x86. It
> is useful for optimizations when MSR values can continue to be used
> between the host and guest. Commit log for 18863bdd60f8 upstream has a
> more complete explanation.
>
> I do not know the inner details of the KVM implementation on Power,
> perhaps Paul/Gautham can comment on if a similar optimization will
> benefit Power systems too?

"MSR" is x86-specific terminology and is pretty vague.  What specifically is 
the functionality being optimized, in terms of things that actually exist on 
PPC?

In any case, that commit log doesn't explain what user-return-notifier is or 
how it works, just that it's being used.

> We could certainly make this a generic config option.. but I am yet to
> see a real usecase outside of the KVM thingy. We do use TIF_UPROBE for
> something very similar, though that needs to fire much before the
> outstanding signals get handled. The user-return notifier is the last
> thing executed before return to userspace -- the two cannot be merged.
> 
> Ananth
> 
> PS: I am not sure having an 'ok' against the Documentation/features/ for
> powerpc is a valid enough argument for this :-)

So how did you test this?  What platforms did you test it on?  What hardware 
support does it need?

-Scott
