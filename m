Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139]) by ozlabs.org (Postfix) with ESMTP id 453B4B6EEE
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 06:04:43 +1000 (EST)
Received: from mail17-db3 (localhost.localdomain [127.0.0.1])	by
	mail17-db3-R.bigfish.com (Postfix) with ESMTP id 4FDE2105056A	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 20:14:17 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.251])	by
	mail17-db3.bigfish.com (Postfix) with ESMTP id 03E1580004B	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 20:14:16 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8DK4Ycu015055	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 13:04:35 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8DKH6SS006259	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 15:17:07 -0500 (CDT)
Date: Mon, 13 Sep 2010 15:04:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
Message-ID: <20100913150432.1e1625c7@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTimUR5-hWRkDAwWTXJYCOcse7LTR0r-vSsZec1g1@mail.gmail.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
	<20100909114153.GB6622@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC158@zch01exm23.fsl.freescale.net>
	<AANLkTimfKwdw+nLAjDjxf52dbZKLF-3aES+bT7CHskAS@mail.gmail.com>
	<1284388075.10955.51.camel@localhost>
	<AANLkTinyELs7KNDQxWsaR8Ea13SewWYwgtnie_P7cAzC@mail.gmail.com>
	<1284396320.1783.30.camel@brekeke>
	<AANLkTimUR5-hWRkDAwWTXJYCOcse7LTR0r-vSsZec1g1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Sep 2010 13:36:45 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Mon, Sep 13, 2010 at 11:45 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > Unsigned int is reliably >= 4 in Linux.
> 
> Not exactly.  sizeof(unsigned int) is effectively never greater than 4
> in Linux (I think it's still 32 bits even on a 64-bit kernel), so it
> makes no sense to say >=.  

I think the point is that if a machine/ABI comes along with
sizeof(int) > 4 (e.g. if there's a significant penalty for working
with anything < 64-bit), Linux might consider supporting that.  Whereas
if someone points to their microcontroller or ancient 286 with
sizeof(int) == 2, the answer would be, "Here's a nickel, kid -- get a
real computer".

-Scott
