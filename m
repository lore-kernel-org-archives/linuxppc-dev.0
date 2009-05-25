Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C4BADE3AD
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 14:36:42 +1000 (EST)
Subject: Wrong looking statement in cpm_common.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain
Date: Mon, 25 May 2009 14:00:33 +1000
Message-Id: <1243224033.24376.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott !

There's this pearl in cpm_common.c :

void __init udbg_init_cpm(void)
{
	if (cpm_udbg_txdesc) {
#ifdef CONFIG_CPM2
		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
#endif
		udbg_putc = udbg_putc_cpm;
	}
}

Now, last I looked, 0xf0000000 (virtual) lands about right in the middle
of the vmalloc space... so unless there's code somewhere that I missed
that reserves that region of virtual space for use by that crap above,
I think somebody is in trouble :-)

Additionally, that's the last user of setbat that I can find outside
of the linear mapping setup proper, so scott, once you've fixed that
I'll happily make setbat static once for all. We -can- still provide
a facility for using BATs for early ioremap's but that should be done
properly, not by whacking setbat with random hard wired virtual
addresses.

Cheers,
Ben.
