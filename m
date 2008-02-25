Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC915DDFD5
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 22:57:07 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1PBuZpq013068
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 06:56:35 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1PBv2Za142744
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 04:57:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1PBv2TO013023
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 04:57:02 -0700
Date: Mon, 25 Feb 2008 05:56:08 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: Use aliases instead of linux,network-index on Ebony
Message-ID: <20080225055608.5a3ece92@zod.rchland.ibm.com>
In-Reply-To: <20080225064925.GA18527@localhost.localdomain>
References: <20080225003339.GB16071@localhost.localdomain>
	<20080224223443.6f84d073@zod.rchland.ibm.com>
	<20080225064925.GA18527@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 Feb 2008 17:49:25 +1100
David Gibson <dwg@au1.ibm.com> wrote:

> On Sun, Feb 24, 2008 at 10:34:43PM -0600, Josh Boyer wrote:
> > On Mon, 25 Feb 2008 11:33:39 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > This patch alters the Ebony bootwrapper to use the new preferred
> > > method of using aliases to work out which MAC address to attach to
> > > which ethernet device node, rather than the old method based on the
> > > linux,network-index property.
> > 
> > I like it.  But do we have this new preferred method documented
> > somewhere?  Doesn't seem to be in booting-without-of.txt.  It probably
> > should be added there, and reference to the linux,network-index
> > property removed if this is really preferred now.  Can you add
> > something to this patch for that?
> 
> Hrm.  linux,network-index was mentioned in b-w-o.txt, but to be honest
> I don't think it ever belonged there.  It describes a bootloader to
> kernel interface, whereas network-index was always a bootwrapper
> internal hack, applicable only when the device tree and the fixup code
> were built into the one image.

That's fine.  But can it you remove reference to it then?

> aliases, on the other hand do warrent wider mention, and aren't
> mentioned at all in b-w-o.txt, but that's a matter of larger scope
> than just getting rid of the network-index hack.

My concern is that people writing new ports will continue to copy DTS
files with linux,network-index in it.  Particularly since it's
recommended in b-w-of.txt, and there is no mentioned alternative.

josh
