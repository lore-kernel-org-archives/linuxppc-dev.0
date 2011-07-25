Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD1A0B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 01:41:10 +1000 (EST)
Date: Mon, 25 Jul 2011 10:40:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 13/14] 85xx: consolidate of_platform_bus_probe calls
Message-ID: <20110725104056.6f338eec@schlenkerla.am.freescale.net>
In-Reply-To: <CALT56yOZkLW=AmkyX77g5agxfBb0h7Fz8Q_enth-CJycJ3SkFA@mail.gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-14-git-send-email-dbaryshkov@gmail.com>
	<20110719125447.19c964d1@schlenkerla.am.freescale.net>
	<CALT56yMxttzC+WZMhja3-PqneMMba5rs9j25RiSAUrwEA_jyaw@mail.gmail.com>
	<20110722152911.364d75dd@schlenkerla.am.freescale.net>
	<CALT56yOZkLW=AmkyX77g5agxfBb0h7Fz8Q_enth-CJycJ3SkFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 23 Jul 2011 01:45:53 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> I see your point. I just wasn't thinking too much about ot-of-tree trees.
> My thought was that if someone updates the kernel, he can also update the dtb.

Sometimes there are firmware dependencies that make that difficult.  And
even if it's just user laziness/forgetfulness, that still translates to
extra support requests.

> Could you please update the lbc.txt suggesting the compatibility
> with simple-bus for lbc? Or you thing that it would be wrong?
>
> I think we should define compatibility list as "fsl,mpcXXXX-localbus",
> "fsl,pqXXXXX-localbus", "simple-bus", noting that by default new
> platforms/boards should only use "simple-bus" internally. Does this
> look reasonable for you? I can then try to provide a patch.

I'm OK with saying that localbus nodes should have simple-bus in new trees,
and defining canonical compatible values (chips with eLBC should be
"fsl,XXXX-elbc", "fsl,elbc", "simple-bus").  I'm not sure what you mean by
"should only use simple-bus internally", especially in the context of the
binding.

> What do you suggest/prefer? To add .name="localbus" to generic code
> or to have board-specific hooks (like one for mpc834xemitx)?

Just add localbus to the generic table.

-Scott
