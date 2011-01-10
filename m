Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1858B70D6
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 03:55:17 +1100 (EST)
In-Reply-To: <AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
	<OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
	<AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
To: Rafael Beims <rbeims@gmail.com>
Message-ID: <OFCA182CE3.B20BFA9C-ONC1257814.005C7CE1-C1257814.005CF1A7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 10 Jan 2011 17:55:11 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: michael@evidence.eu.com, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	scottwood <scottwood@freescale.com>, RFeany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rafael Beims <rbeims@gmail.com> wrote on 2011/01/10 17:35:38:
> >
> > Once you have tested it and it works, please send a patch to remove the 8xx workaround.
> > Make sure Scott is cc:ed
> >
> >
>
> I tested linux-2.6.33 on my ppc880 board today, and even without the
> slowdown.patch applied, the board runs processes with good
> performance.
> It really seems that the problem is solved from linux-2.6.33 on.
>
> I'm not sure what you mean by sending a patch to remove the
> workaround. The only thing that I did in the 2.6.32 version was to
> apply the slowdown.patch attached in the message from Michael.
>
> Could you clarify please?

Yes, this part in arch/powerpc/mm/pgtable.c:
#ifdef CONFIG_8xx
			/* On 8xx, cache control instructions (particularly
			 * "dcbst" from flush_dcache_icache) fault as write
			 * operation if there is an unpopulated TLB entry
			 * for the address in question. To workaround that,
			 * we invalidate the TLB here, thus avoiding dcbst
			 * misbehaviour.
			 */
			/* 8xx doesn't care about PID, size or ind args */
			_tlbil_va(addr, 0, 0, 0);
#endif /* CONFIG_8xx */

Should be removed in >= 2.6.33 kernels.
My 8xx TLB work fixes this problem more efficiently.

    Jocke
