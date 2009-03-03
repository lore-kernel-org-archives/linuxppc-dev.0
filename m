Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 06E9FDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 05:34:10 +1100 (EST)
Date: Tue, 3 Mar 2009 21:34:07 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/83xx: Add power management support for
	MPC837x boards
Message-ID: <20090303183407.GA27678@oksana.dev.rtsoft.ru>
References: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
	<20090303175746.GC8692@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090303175746.GC8692@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2009 at 11:57:46AM -0600, Scott Wood wrote:
> On Tue, Mar 03, 2009 at 07:02:01PM +0300, Anton Vorontsov wrote:
> >  		mdio@24520 {
> > @@ -226,6 +244,8 @@
> >  			interrupt-parent = <&ipic>;
> >  			tbi-handle = <&tbi0>;
> >  			phy-handle = <&phy2>;
> > +			sleep = <&pmc 0xc0000000>;
> > +			fsl,magic-packet;
> >  		};
> 
> Note that this makes it look to the kernel like enet0 can be put to sleep
> without putting the mdio (which is shared with enet1) to sleep.  This is
> why I moved mdio under the ethernet node on 8313erdb.

And that isn't absolutely correct either, since enet1 depends on
net0... If enet0's mdio goes into sleep mode before enet1, then
enet1 will fail to send power-down command to its PHY...

So the better solution would be

sleep-nexus {
	sleep = <enet0-sccr>;

	enet0 {
		mdio {
		};
	};

	enet1 {
		sleep = <enet1-sccr>;
	};
};

..which isn't 100% correct either, but will work (because we use
a separate driver for the Gianfar MDIO).

What do you think?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
