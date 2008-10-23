Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6374FDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 21:29:57 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9NAS772214836
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 10:28:07 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9NAS7QO4575440
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 11:28:07 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9NAS6DB029096
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 11:28:06 +0100
Date: Thu, 23 Oct 2008 12:28:05 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: ttydev tree build failure
Message-ID: <20081023102805.GA4197@cetus.boeblingen.de.ibm.com>
References: <20081023172938.0460b191.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081023172938.0460b191.sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 05:29:38PM +1100, Stephen Rothwell wrote:
> drivers/char/hvc_console.c: In function 'hvc_set_winsz':
> drivers/char/hvc_console.c:532: warning: passing argument 2 of 'tty_do_resize' from incompatible pointer type
> drivers/char/hvc_console.c:532: error: too many arguments to function 'tty_do_resize'
> 
> Caused by commit eb6ab2d361a49470ca9785c70482772c19e49bec
> ("pty-simplify-resize") from the ttydev tree interacting with commit
> febde3711992a64ea83a47a719f68a90c4b0927a ("hvc_console: Add support for
> tty window resizing").
> 
> The former added another call to the function that the latter changed.
In linux-next, the pty-simplify-resize patch has changed the
tty_do_resize() signature; and therefore the hvc patch did not compile.

> I applied the following patch.
The patch is correct.
Thanks.

Acked-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

-- 
Regards
Hendrik

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
