Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 0FB85DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:31:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Date: Tue, 8 Apr 2008 04:17:36 +0200
References: <7226bef216680748a503.1207262582@thinkpadL>
	<1207289558.6971.15.camel@thinkpadL>
	<20080404064741.69f8669b@zod.rchland.ibm.com>
In-Reply-To: <20080404064741.69f8669b@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080417.37272.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 April 2008, Josh Boyer wrote:
> On Fri, 04 Apr 2008 01:12:38 -0500
> Jerone Young <jyoung5@us.ibm.com> wrote: 
> > > 
> > > > +static int current_mode = 0;
> > > 
> > > Leave this as: static int current_mode;, so it'll end up in the bss
> > 
> > The problem here is that this defines the default case. Is there really
> > a benefit having this in bss ?
> 
> It's still defined to 0 if it's in the BSS, as that is all initialized
> to 0.

Actually, a static assignment to 0 has not caused the symbol to end up
in .data for many gcc versions, it always goes into .bss now unless you
assign it a value other than 0 or use explicit section attributes.

Whether or not you write the "= 0" is purely stylistic sugar and does
not have any impact the generated binary.

	Arnd <><
