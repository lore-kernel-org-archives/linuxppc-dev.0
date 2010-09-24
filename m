Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209]) by ozlabs.org (Postfix) with ESMTP id DBAECB70E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 01:12:37 +1000 (EST)
Received: from mail28-am1 (localhost.localdomain [127.0.0.1])	by
	mail28-am1-R.bigfish.com (Postfix) with ESMTP id 11278A90081	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:12:30 +0000 (UTC)
Received: from am1ehsmhs001.bigfish.com (unknown [10.3.201.253])	by
	mail28-am1.bigfish.com (Postfix) with ESMTP id 1849D19A8055	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:12:13 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8OFCAVg001033	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:12:10 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8OFCGYc009306	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 10:12:16 -0500 (CDT)
Date: Fri, 24 Sep 2010 10:12:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
	Device Tree
Message-ID: <20100924101208.7916cfa9@udp111988uds.am.freescale.net>
In-Reply-To: <20100924075740.GA20599@oksana.dev.rtsoft.ru>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
	<20100924071006.GA21318@angua.secretlab.ca> <4C9C513B.40501@c-s.fr>
	<20100924075740.GA20599@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
	spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Sep 2010 11:57:40 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> Doesn't explain why that worked on MPC8272 (CPM2) and MPC8560
> (also CPM2) machines though. But here's my guess (I no longer
> have these boards to test it):
> 
> On 8272 I used this node:
> 
> +                       spi@4c0 {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                               compatible = "fsl,cpm2-spi", "fsl,spi";
> +                               reg = <0x11a80 0x40 0x89fc 0x2>;
> 
> On that SOC there are two muram data regions 0x0..0x2000 and
> 0x9000..0x9100. Note that we actually don't want "data" regions,
> and the only reason why that worked is that sysdev/cpm_common.c
> maps muram(0)..muram(max).

Wouldn't it still fail the rh_alloc_fixed call?

-Scott
