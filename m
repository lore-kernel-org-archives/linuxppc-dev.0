Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8D04DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:42:20 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0N1gGsR018895
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 20:42:16 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0N1gGAW112104
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 18:42:16 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0N1gF8C014128
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 18:42:16 -0700
Date: Tue, 22 Jan 2008 19:39:17 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
Message-ID: <20080122193917.2bc4ec7c@zod.rchland.ibm.com>
In-Reply-To: <1201048396.6807.52.camel@pasglop>
References: <E1JHRkS-0005du-O1@jdl.com>
	<fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
	<1201048396.6807.52.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Loeliger <jdl@jdl.com>, Jon
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Jan 2008 11:33:16 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > +
> > > +               mpic: interrupt-controller@40000 {
> > > +                       #interrupt-cells = <2>;
> > > +                       #address-cells = <0>;
> > 
> > Is #address-cells needed?  There are no child nodes.
> 
> It's preferrable for interrupt controllers as #address-cells of the
> parent interrupt controller defines the size of the interrupt unit
> specifier in the child in the interrupt tree.
> 
> I think there's an ongoing argument as to whether the absence of
> #address-cells should be the same as #address-cells = 0 in that specific
> case but I'm not sure the code does the right thing so let's have it
> explicit.

The code doesn't handle the lack of #address-cells in nodes where
there is an interrupt-map. It pukes if there is no reg property and
addrsize != 0. In the absence of the #address-cells property, it will
try to look at the parent's #address-cells, and if that lacks it, it
will assign 2 which it then merrily decides is incorrect.

josh
