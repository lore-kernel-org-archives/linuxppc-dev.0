Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 94662DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 17:49:40 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1P6nGMY012818
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 17:49:16 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1P6nd8f4571170
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 17:49:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1P6ncjw010488
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 17:49:39 +1100
Date: Mon, 25 Feb 2008 17:49:25 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Use aliases instead of linux,network-index on Ebony
Message-ID: <20080225064925.GA18527@localhost.localdomain>
References: <20080225003339.GB16071@localhost.localdomain>
	<20080224223443.6f84d073@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080224223443.6f84d073@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 24, 2008 at 10:34:43PM -0600, Josh Boyer wrote:
> On Mon, 25 Feb 2008 11:33:39 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > This patch alters the Ebony bootwrapper to use the new preferred
> > method of using aliases to work out which MAC address to attach to
> > which ethernet device node, rather than the old method based on the
> > linux,network-index property.
> 
> I like it.  But do we have this new preferred method documented
> somewhere?  Doesn't seem to be in booting-without-of.txt.  It probably
> should be added there, and reference to the linux,network-index
> property removed if this is really preferred now.  Can you add
> something to this patch for that?

Hrm.  linux,network-index was mentioned in b-w-o.txt, but to be honest
I don't think it ever belonged there.  It describes a bootloader to
kernel interface, whereas network-index was always a bootwrapper
internal hack, applicable only when the device tree and the fixup code
were built into the one image.

aliases, on the other hand do warrent wider mention, and aren't
mentioned at all in b-w-o.txt, but that's a matter of larger scope
than just getting rid of the network-index hack.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
