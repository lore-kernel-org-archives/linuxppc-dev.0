Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 580CADDED8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 20:50:47 +1000 (EST)
Date: Tue, 5 Aug 2008 10:27:49 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] powerpc - Initialize the irq radix tree earlier
Message-ID: <20080805102749.6ae24947@bull.net>
In-Reply-To: <1217898303.24157.122.camel@pasglop>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-2-git-send-email-sebastien.dugue@bull.net>
	<1217898226.24157.120.camel@pasglop>
	<1217898303.24157.122.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 05 Aug 2008 11:05:03 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >  - Remove the populating of the tree from the revmap function as
> >    you already do
> >  - Move it to irq_create_mapping() for the normal case
> >  - For pre-existing interrupt, have the generic code that initializes
> >    the radix tree walk through all interrupts and setup the revmap for
> >    them. If that needs locking vs. concurrent irq_create_mapping, it's
> >    easy to use one of the available spinlocks for that.
> 
> And in fact, you may even be able to avoid GFP_ATOMIC completely here
> and switch it to GFP_KERNEL since irq_create_mapping() can sleep afaik,
> provided that you avoid the spinlocking.

  Well, maybe, will have to look into this in details.

  Thanks,

  Sebastien.

> 
> Ben.
> 
> 
> 
