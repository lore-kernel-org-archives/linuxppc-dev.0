Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EAA3CDDEBB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 06:23:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA5JNF94015956
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:23:15 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA5JNDAC125108
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 12:23:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA5JNCGf027913
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 12:23:13 -0700
Date: Mon, 5 Nov 2007 13:23:12 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 11/16] Use of_get_next_child() in eeh_restore_bars()
Message-ID: <20071105192312.GH4415@austin.ibm.com>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
	<ef7facd658919117aa7c693b4eeb12241ca859d8.1193381582.git.michael@ellerman.id.au>
	<20071026172909.f7a085e9.sfr@canb.auug.org.au>
	<1193629573.7280.11.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193629573.7280.11.camel@concordia>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S.Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 02:46:13PM +1100, Michael Ellerman wrote:
> 
> On Fri, 2007-10-26 at 17:29 +1000, Stephen Rothwell wrote:
> > On Fri, 26 Oct 2007 16:54:43 +1000 (EST) Michael Ellerman <michael@ellerman.id.au> wrote:
> > >
> > > -	dn = pdn->node->child;
> > > -	while (dn) {
> > > +	for (dn = NULL; (dn = of_get_next_child(pdn->node, dn));)
> > 
> > Just wondering if we need
> > 
> > #define for_each_child_node(dn, parent) \
> > 	for (dn = of_get_next_child(parent, NULL); dn; \
> > 		dn = of_get_next_child(parent, dn))

Yes, I like this much better too, if for no other reason than
the for-loop tructure is more orthodox.

> Should we perhaps make it for_each_child_device_node() ?

foreach_of_device_node_child() or

of_foreach_device_node_child()
