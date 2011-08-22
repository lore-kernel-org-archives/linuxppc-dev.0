Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B23EB6F64
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 02:04:41 +1000 (EST)
Message-ID: <4E527E0F.1010500@freescale.com>
Date: Mon, 22 Aug 2011 11:04:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
In-Reply-To: <20110822152530.GA16794@parrot.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem Bityutskiy <dedekind1@gmail.com>, LiuShuo <b35362@freescale.com>,
	Matthieu Castet <matthieu.castet@parrot.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2011 10:25 AM, Ivan Djelic wrote:
> Did you take into account the fact that because MTD thinks this a 2K chip,
> you will have to wait twice for the nand busy read time (typically 25 us) per
> each 4K read. In other words, to read 4 kBytes you will do:
> 
> 1. send read0 (00), send address, send read1 (30)
> 2. wait tRB
> 3. transfer 2 kBytes
> 4. send read0 (00), send address, send read1 (30)
> 5. wait tRB
> 6. transfer 2 kBytes
> 
> Same problem for writes (but rather 100 us instead of 25 us).
> 
> How does that compare with hw ecc gain in terms of performance ?

We'd have the double-delay with the sw ecc plus buffering approach as well.

To eliminate it we'd need to do an extra data transfer without reissuing
the command, which Shuo was unable to get to work.

And it's not worse than having an actual 2K chip. :-)

-Scott
