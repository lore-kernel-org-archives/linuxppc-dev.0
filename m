Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] remove bogus ppc_select syscall
Date: Sun, 12 Oct 2008 10:58:15 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<18671.1955.407703.974646@cargo.ozlabs.ibm.com>
	<1223680673.8157.166.camel@pasglop>
In-Reply-To: <1223680673.8157.166.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810121058.16375.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 11 October 2008, Benjamin Herrenschmidt wrote:
> > 
> > -SYSX_SPU(sys_select,ppc32_select,ppc_select)
> > +SYSX_SPU(sys_select,ppc32_select,sys_select)
> 
> Ok, so you want to keep compat with the old stuff. Note that we still
> have this weird thing that on 64-bit kernels, we don't provide this.

This change makes the funny wrapper only active for the "old" select
number on native ppc32, which is not active on ppc64 or compat32,
while any programs using the "new" select number, i.e. any binay you
will ever encounter in practice, now gets the standard semantics.

	Arnd <><
