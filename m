Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64CDFDDEB8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 12:06:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6B26ceC002319
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:06:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6B26ch7485398
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:06:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6B26b6J024623
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:06:38 -0400
Date: Tue, 10 Jul 2007 21:17:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, akpm@linux-foundation.org
Subject: Missed serial patch breaks arch/powerpc 44x port
Message-ID: <20070711021756.GH3925@crusty.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

When support for the PPC44x arch/powerpc port was posted back in May, David
included two serial patches along with it.  The short story is that the
powerpc patches were merged in via Paul, but the two serial patches were never
merged.  This makes the 44x arch/powerpc port dead on arival in 2.6.22.

The two patches I speak of are:

http://patchwork.ozlabs.org/linuxppc/patch?person=11&id=10935

and

http://patchwork.ozlabs.org/linuxppc/patch?person=11&id=10934

Unfortunately, the fact that the second patch is missing breaks the Ebony
board, manifesting itself in a machine check during boot.  The lack of using
resource_size_t for the mapbase member of the uart_port structure means that
the physical address passed in is too large for the data type and the wrong
address gets ioremapped.

Could we get those patches, particularly the second one, merged during the
merge window?  We might also want to push them to -stable.

The alternative would be to re-introduce the fixup_big_phys_addr function in
the 44x ioremap path.  I'd rather avoid adding that back in temporarily if
these serial patches are eventually going to go in anyway.

josh
