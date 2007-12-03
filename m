Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 60C2DDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 06:32:18 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB3JWEJi027361
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 14:32:14 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB3JWCbn1319032
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 14:32:13 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB3JWCXQ015091
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 12:32:12 -0700
Date: Mon, 3 Dec 2007 13:32:11 -0600
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-ID: <20071203193211.GA5125@austin.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
	<20071128110037.GB31217@aepfle.de>
	<20071128200932.GG19584@austin.ibm.com>
	<20071129104147.GA3694@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129104147.GA3694@aepfle.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 11:41:47AM +0100, Olaf Hering wrote:
> On Wed, Nov 28, Linas Vepstas wrote:
> 
> > On Wed, Nov 28, 2007 at 12:00:37PM +0100, Olaf Hering wrote:
> > > On Tue, Nov 27, Will Schmidt wrote:
> 
> > > > > -	if (panic_timeout)
> > > > > -		return;
> > > 
> > > This change is wrong. Booting with panic=123 really means the system
> > > has to reboot in 123 seconds after a panic.
> > 
> > And it does.
> 
> Have you ever tried it? Current state is that the JS20 hangs after
> panic, 

It should printout the "Rebooting in timeout_wait seconds ..."
Then it should wait timeout_wait number of seconds, as usual,
and *then* call the hypervisor.

> simply because it calls into the hypervisor (or whatever).

The hypervisor is not supposed to return at this point. Its supposed
to reboot. Appearently, its not rebooting. Either we are using it 
wrong, or the hypervisor is buggy on some systems. It did work on 
the machines I was on; but I did not try power5's or blades.

> So, please restore the panic_timeout check.

The problem with this check was that was that the value was never 
ever set, and so the branch was never ever taken. 

--linas
