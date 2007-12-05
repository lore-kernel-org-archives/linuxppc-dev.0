Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 203F8DE0D3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 15:02:45 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB542gqI023531
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 23:02:42 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB542gGK138820
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 23:02:42 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB542fUm026797
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 23:02:42 -0500
Date: Tue, 4 Dec 2007 22:00:12 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Merge dtc
Message-ID: <20071204220012.1b91c27c@zod.rchland.ibm.com>
In-Reply-To: <20071204202625.05367103@zod.rchland.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<20071204163409.6d03c7a5@zod.rchland.ibm.com>
	<18262.2934.447856.686438@cargo.ozlabs.ibm.com>
	<20071204202625.05367103@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Dec 2007 20:26:25 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Wed, 5 Dec 2007 13:22:46 +1100
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Josh Boyer writes:
> > 
> > > Using that same reasoning, should we merge a mkimage patch for the
> > > boards that use U-Boot?
> > 
> > I think so.  It's fairly small and it would mean that people could
> > cross-compile all the defconfigs easily.
> 
> I'll try to work up a patch tonight.

OK so it won't be tonight.

The problem we have with mkimage, unlike DTC at the moment, is that it
_is_ used on other architectures.  There's already a mkuboot.sh script,
which calls mkimage, in scripts/ right now.  Adding mkimage to
arch/powerpc only seems pretty wrong.

So if mkimage is going to be put in-kernel, I'd rather it be in a more
generic place.  Arguably, dtc should go there as well seeing as how
microblaze could probably use it too.

josh
