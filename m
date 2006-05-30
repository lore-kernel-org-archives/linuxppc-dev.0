Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 191FF67A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 14:17:57 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306585F22@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306585F22@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:17:48 +1000
Message-Id: <1148962668.15722.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-30 at 11:28 +0800, Zang Roy-r61911 wrote:

> Tsi108 implementation of MPIC has many differences form the original one,  the following
> code implements it with mpic. Any comment? The following patch is just based on
> my previous send out patches.
> 
> Integrate Tundra Semiconductor tsi108 host bridge interrupt controller 
> to mpic arch.

As usual... #ifdef's are evil. Only use them to avoid building bits that
are not useful for a given platform, not to change the behaviour of a
driver. By changing the MPIC driver with #ifdef's, you once again
prevent building a generic kernel image that can boot both your board
and pSeries, powermac, etc...

Please add an MPIC flag instead (as there is already for specifying, for
example, big endian MPICs) and add the necessary abstractions (for
example, put some register stride in the mpic instance structure and
initialize them based on the flags etc...)

Cheers,
Ben.
