Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw2.br.ibm.com (igw2.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw2.br.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CDBBADDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:37:25 +1000 (EST)
Received: from mailhub3.br.ibm.com (mailhub3 [9.18.232.110])
	by igw2.br.ibm.com (Postfix) with ESMTP id 7DB8717F552
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:24:10 -0300 (BRT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m6LGb0t61192180
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:37:05 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LGashU004901
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:36:55 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080719093752.5aada45c@zod.rchland.ibm.com>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 13:36:33 -0300
Message-Id: <1216658194.5727.36.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This doesn't look right for how it's coded.  This would be the
> CONFIG_4xx || CONFIG_BOOKE case, but CONFIG_4xx includes PowerPC 405.
> That has a different bit layout among the DBCR registers.  Namely, on
> 405 you would be clearing the TDE and IAC1 events because the DAC
> events are in DBCR1, not DBCR0.

Maybe guarding the 405-specific parts in a separate "#if
defined(CONFIG_40x)" block will do?

Do you think it's worth to support this facility on 405's processors? If
so, i'll gladly work on a solution to it.

Regards,
Luis
