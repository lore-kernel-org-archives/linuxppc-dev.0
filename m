Return-Path: <arnd@arndb.de>
Received: from mout-xforward.kundenserver.de (mout-xforward.kundenserver.de
	[212.227.17.5]) by ozlabs.org (Postfix) with ESMTP id 72907DDEFA
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 02:46:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Lock-up on PPC64
Date: Mon, 5 Jan 2009 16:46:02 +0100
References: <Pine.LNX.4.64.0812212058550.2164@linmac.oyster.ru>
	<1230165163.7292.32.camel@pasglop>
	<Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
In-Reply-To: <Pine.LNX.4.64.0812280335070.2526@linmac.oyster.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901051646.03654.arnd@arndb.de>
Cc: malc <av1474@comtv.ru>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 28 December 2008, malc wrote:
> Now to the Christmas cheer, i've tried v2.6.28 and couldn't help but
> notice that the problem is gone, bisecting v2.6.27 (which funnily i
> had to mark good) to v2.6.28 (which has to be marked bad) wasn't fun
> but eventually converged at ab598b6680f1e74c267d1547ee352f3e1e530f89
>=20
> commit ab598b6680f1e74c267d1547ee352f3e1e530f89
> Author: Paul Mackerras <paulus@samba.org>
> Date: =A0 Sun Nov 30 11:49:45 2008 +0000
>=20
> =A0 =A0 =A0powerpc: Fix system calls on Cell entered with XER.SO=3D1
>=20
> Now the lock-up is gone, however the code never exercises the path
> taken during the lock-up so i guess it, at least, deserves a better
> look by PPC64 care takers.


Yes, this change was suspected to help with Mono as well, not just
Java, because both of them use their own syscall path rather than
going through glibc. The reason why you see the lock-up in a different
place is because the bug manifested in getting incorrect syscall
return codes, which probably made mono go into a normally unused
error handling case.

	Arnd <><
