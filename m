Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E8C1DDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 07:09:37 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lASK9YAY023692
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:09:34 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lASK9XK3431342
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:09:33 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lASK9WRE027058
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:09:33 -0500
Date: Wed, 28 Nov 2007 14:09:32 -0600
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-ID: <20071128200932.GG19584@austin.ibm.com>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
	<20071128110037.GB31217@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071128110037.GB31217@aepfle.de>
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

On Wed, Nov 28, 2007 at 12:00:37PM +0100, Olaf Hering wrote:
> On Tue, Nov 27, Will Schmidt wrote:
> 
> > > -void rtas_os_term(char *str)
> > > +void rtas_panic_msg(char *str)
> 
> > > -	if (panic_timeout)
> > > -		return;
> 
> This change is wrong. Booting with panic=123 really means the system
> has to reboot in 123 seconds after a panic.

And it does.

> But, maybe this panic_timeout check was moved elsewhere.

It was *always* somewhere else; the check here was always wrong.

This change makes the os-term call happen after the the panic
timeout amount of time has elapsed.

--linas
