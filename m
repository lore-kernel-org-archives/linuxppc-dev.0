Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 0F53DDE24A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jul 2007 23:30:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Mem-2-Mem DMA - Generalized API
Date: Sat, 7 Jul 2007 15:28:00 +0200
References: <20070624193932.GA11797@clifford.at>
	<200707071508.04143.arnd@arndb.de>
	<20070707132748.GB32740@clifford.at>
In-Reply-To: <20070707132748.GB32740@clifford.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071528.00449.arnd@arndb.de>
Cc: Clifford Wolf <clifford@clifford.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Clifford Wolf wrote:
> > > +=A0=A0=A0// make sure all pending requests have finished before retu=
rning
> > > +=A0=A0=A0down_write(&backend->unreg_sem);
> > > +=A0=A0=A0up_write(&backend->unreg_sem);
> > > +}
> >=20
> > This usage of rw semaphores looks fishy.=20
>=20
> yep. do you have a better idea how to implement this easily?
>=20

I'd guess what you really want is reference counting. Every request
that gets assigned to a backend should get a kref on that backend
and give that up once it gets released itself.

I guess you can then have one more reference that you get in
dmatransfer_register_backend and release in dmatransfer_unregister_backend.
When you release the last reference, you call complete(),
and dmatransfer_unregister_backend() ends with a wait_for_completion().

	Arnd <><
