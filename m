Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A37B0DE016
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 03:56:35 +1000 (EST)
Date: Tue, 26 May 2009 12:56:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Wrong looking statement in cpm_common.c
Message-ID: <20090526175613.GB9464@loki.buserror.net>
References: <1243224033.24376.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1243224033.24376.18.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 02:00:33PM +1000, Benjamin Herrenschmidt wrote:
> Hi Scott !
> 
> There's this pearl in cpm_common.c :
> 
> void __init udbg_init_cpm(void)
> {
> 	if (cpm_udbg_txdesc) {
> #ifdef CONFIG_CPM2
> 		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
> #endif
> 		udbg_putc = udbg_putc_cpm;
> 	}
> }
> 
> Now, last I looked, 0xf0000000 (virtual) lands about right in the middle
> of the vmalloc space... so unless there's code somewhere that I missed
> that reserves that region of virtual space for use by that crap above,
> I think somebody is in trouble :-)

:-(

> Additionally, that's the last user of setbat that I can find outside
> of the linear mapping setup proper, so scott, once you've fixed that
> I'll happily make setbat static once for all. We -can- still provide
> a facility for using BATs for early ioremap's but that should be done
> properly, not by whacking setbat with random hard wired virtual
> addresses.

Any suggestions for how to do it properly?

-Scott
