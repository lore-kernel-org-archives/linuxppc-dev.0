Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4E76DDF44
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 20:28:37 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070528102327.GA9675@iram.es>
References: <1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
	<1179831375.3827.4.camel@localhost.localdomain>
	<1179873742.32247.864.camel@localhost.localdomain>
	<1179887929.3656.2.camel@localhost.localdomain>
	<1179889736.32247.893.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF5F@zch01exm21.fsl.freescale.net>
	<1180344249.19517.74.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D263595EF6C@zch01exm21.fsl.freescale.net>
	<1180346421.19517.79.camel@localhost.localdomain>
	<20070528102327.GA9675@iram.es>
Content-Type: text/plain
Date: Mon, 28 May 2007 20:28:19 +1000
Message-Id: <1180348099.19517.81.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Liu Dave-r63238 <DaveLiu@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-28 at 12:23 +0200, Gabriel Paubert wrote:
> On SMP with single die and integrated memory controllers (PASemi), 
> I'd bet that tlb invalidation broadcast is typically much cheaper 
> since no external signals are involved (from a hardware point of view
> it's not very different from a store to a shared cache line that has 
> to be invalidated in the cache of the other processors). 

Except that is often has strong locking requirements along with a race
or two to deal with when not having a HW reload on the TLB. So in the
case of Freescale BookE, it is really something that should be measured.

Ben.
