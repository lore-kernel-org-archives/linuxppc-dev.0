Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C681667B68
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:45:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7INjYgg008269
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 19:45:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7INjYkY264782
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 19:45:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7INjXJS019718
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 19:45:34 -0400
Date: Fri, 18 Aug 2006 18:45:32 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818234532.GA8644@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
	<20060818.155116.112621100.davem@davemloft.net>
	<20060818232942.GO26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060818232942.GO26889@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 06:29:42PM -0500, linas wrote:
> 
> I don't understand what you are saying. If I call the transmit 
> queue cleanup code from the poll() routine, nothing hapens, 
> because the kernel does not call the poll() routine often 
> enough. I've stated this several times.  

OK, Arnd gave me a clue stick. I need to call the (misnamed)
netif_rx_schedule() from the tx interrupt in order to get 
this to work. That makes sense, and its easy, I'll send the 
revised patch.. well, not tonight, but shortly.

--linas
