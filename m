Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E44BBDDF5E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 06:01:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 22:01:25 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706082126.23435.arnd@arndb.de>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
In-Reply-To: <65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706082201.26308.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 June 2007, Segher Boessenkool wrote:

> >> So where is the of_node_put() done for the of_node_get()
> >> inside the loop?
> >
> > of_find_compatible_node does an of_node_put() on the device_node
> > that you pass in as the 'from' argument. In the last step, 'node'
> > is set to NULL and we put the previous element.
> 
> That wasn't my question though?

Sorry, I misread this. The of_node_get is done because we keep
a reference to the device node in the axon_msic struct. There is
no module_exit function in the driver that could clean up the
axon_msic, so we must never have an of_node_put as far as I
understand.

	Arnd <><
