Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D66ADDF6B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 11:05:58 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc - Initialize the irq radix tree earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1217898226.24157.120.camel@pasglop>
References: <1217848124-3719-1-git-send-email-sebastien.dugue@bull.net>
	<1217848124-3719-2-git-send-email-sebastien.dugue@bull.net>
	<1217898226.24157.120.camel@pasglop>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 11:05:03 +1000
Message-Id: <1217898303.24157.122.camel@pasglop>
Mime-Version: 1.0
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  - Remove the populating of the tree from the revmap function as
>    you already do
>  - Move it to irq_create_mapping() for the normal case
>  - For pre-existing interrupt, have the generic code that initializes
>    the radix tree walk through all interrupts and setup the revmap for
>    them. If that needs locking vs. concurrent irq_create_mapping, it's
>    easy to use one of the available spinlocks for that.

And in fact, you may even be able to avoid GFP_ATOMIC completely here
and switch it to GFP_KERNEL since irq_create_mapping() can sleep afaik,
provided that you avoid the spinlocking.

Ben.
