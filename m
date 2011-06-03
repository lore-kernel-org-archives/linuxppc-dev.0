Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B579AB6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 15:56:51 +1000 (EST)
Date: Fri, 3 Jun 2011 14:53:26 +0900
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [stable] PROBLEM: 2.6.39 =?utf-8?Q?doe?= =?utf-8?B?c27igJl0?=
	boot on POWER MAC
Message-ID: <20110603055326.GA21323@kroah.com>
References: <4DE0AA62.4070909@list.ru> <20110603000012.4ce5c45f@Jay>
	<1307068891.23876.2.camel@pasglop>
	<1307070645.23876.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307070645.23876.9.camel@pasglop>
Cc: paulus@samba.org, Andrey Gusev <ronne@list.ru>,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2011 at 01:10:45PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2011-06-03 at 12:41 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2011-06-03 at 00:00 +0200, Giuliano Pochini wrote:
> > > On Sat, 28 May 2011 11:55:14 +0400
> > > Andrey Gusev <ronne@list.ru> wrote:
> > > 
> > > > Hi!
> > > > A kernel 2.6.39 doesn't boot on my POWER MAC G4.
> > > 
> > > Same problem with my dual-G4 MDD. A few more infos:
> > > The machine hangs just after the message "Returning from prom_init" (still
> > > in the OF screen).
> > > The kernel works fine with the option maxcpus=1, but it locks up as soon as
> > > I try to enable the second CPU with echo 1 > /sys.../online.
> > 
> > I just verified that current upstream 3.0-rc1+ does boot fine.
> 
> The fix is:
> 
>   c560bbceaf6b06e52f1ef20131b76a3fdc0a2c19
>   powerpc/4xx: Fix regression in SMP on 476
> 
> It looks like the regression wasn't specific to 476 but to all ppc
> 32-bit SMP setups. The bugs is specific to 2.6.39.
> 
> Greg, it should cherry-pick as-is but here's a copy in case you need it.

Now applied, thanks.

greg k-h
