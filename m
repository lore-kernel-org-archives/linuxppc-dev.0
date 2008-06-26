Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] 2.6.26-rc6 kernel bug on PS3?
Date: Thu, 26 Jun 2008 10:11:47 +0200
References: <OFD9B4725E.630B28FC-ONC1257473.00470E7C-C1257473.00479305@de.ibm.com>
	<200806261046.16763.jk@ozlabs.org>
In-Reply-To: <200806261046.16763.jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806261011.47500.arnd@arndb.de>
Cc: Stefan Wald <WALD@de.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Jeremy Kerr wrote:
> > Application hangs after a while defunct and dmesg output looks like
> > d.txt. (See attached file: d.txt)
>=20
> Looks like this is caused by doing the mmput() while the state mutex is=20
> held in spu_forget.
>=20
> In your case, the mm is the final reference to the context, so this is=20
> resulting in a destroy_spu_context, which requires the state mutex :)
>=20
> I'm going to take a look at the sequencing of spu_forget, but would like=
=20
> to write a test case. Could you tell us about the exit path of your=20
> program?

=46rom my looking at the log, I first had the same impression, but=20
I concluded that it's got to be more complicated than that:

mmput() in spu_forget should not result in destroying the context
that we're forgetting, because we still hold a reference on the
inode that will be released later in the final fput.
What this means is that doing the close in this context will
result in destroying another (already forgotten) context that
is still referenced by our mm.

Lockdep warns about this because it can't guarantee that you
don't have two instances of contexts that do this to each other.
I'm fairly sure it can't happen here, and the lockdep warning
is a red herring, probably another thread is holding the mutex
already.

	Arnd <><
