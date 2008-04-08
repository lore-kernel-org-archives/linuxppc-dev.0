Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2EEF6DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:33:04 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m382V8TP016961
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:31:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m382X1XE205438
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:33:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m382X0wL019319
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 20:33:00 -0600
Date: Mon, 7 Apr 2008 21:31:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080407213127.7bb9a769@zod.rchland.ibm.com>
In-Reply-To: <200804080417.37272.arnd@arndb.de>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<1207289558.6971.15.camel@thinkpadL>
	<20080404064741.69f8669b@zod.rchland.ibm.com>
	<200804080417.37272.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Apr 2008 04:17:36 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 04 April 2008, Josh Boyer wrote:
> > On Fri, 04 Apr 2008 01:12:38 -0500
> > Jerone Young <jyoung5@us.ibm.com> wrote: 
> > > > 
> > > > > +static int current_mode = 0;
> > > > 
> > > > Leave this as: static int current_mode;, so it'll end up in the bss
> > > 
> > > The problem here is that this defines the default case. Is there really
> > > a benefit having this in bss ?
> > 
> > It's still defined to 0 if it's in the BSS, as that is all initialized
> > to 0.
> 
> Actually, a static assignment to 0 has not caused the symbol to end up
> in .data for many gcc versions, it always goes into .bss now unless you
> assign it a value other than 0 or use explicit section attributes.

IIRC, gcc 3.2 is still supported and it didn't do that.  Old toolchains
still exist.

> Whether or not you write the "= 0" is purely stylistic sugar and does
> not have any impact the generated binary.

Only if you're using a newer gcc version...

josh
