Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A9EDDDE098
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 02:44:37 +1100 (EST)
Date: Thu, 10 Jan 2008 18:53:37 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY
	layerfunctionality
Message-ID: <20080110155336.GA28899@localhost.localdomain>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
	<003c01c84a3e$15d3a9c0$02ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <003c01c84a3e$15d3a9c0$02ac10ac@Jocke>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 29, 2007 at 06:13:08PM +0100, Joakim Tjernlund wrote:
> > -----Original Message-----
> > From: 
> > linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> > [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> > abs.org] On Behalf Of Vitaly Bordug
> > Sent: den 6 december 2007 23:51
> > To: Paul Mackerras
> > Cc: netdev@vger.kernel.org; linuxppc-dev
> > Subject: [PATCH 1/3] [NET] phy/fixed.c: rework to not 
> > duplicate PHY layerfunctionality
> > 
> > 
> > With that patch fixed.c now fully emulates MDIO bus, thus no need
> > to duplicate PHY layer functionality. That, in turn, drastically
> > simplifies the code, and drops down line count.
> > 
> > As an additional bonus, now there is no need to register MDIO bus
> > for each PHY, all emulated PHYs placed on the platform fixed MDIO bus.
> > There is also no more need to pre-allocate PHYs via .config option,
> > this is all now handled dynamically.
> > 
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Acked-by: Jeff Garzik <jeff@garzik.org>
> 
> What happened to this patch set? Is it sitting in a tree somewhere waiting
> for 2.4.25 or does it need more work?
        ^ we're too late then. ;-)

Patches already began to fuzz at the fsl_soc.c, yet more time and
they'll reject to apply. So.. Paul, Kumar can we get this in for
2.6.25?

I believe afterward this one will need some attention too:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048473.html

Thanks in advance,


p.s. I just noticed that "fsl_soc: add support for gianfar for
fixed-link .." patch could be cosmetically improved (removing
casts, adding checks for size after the of_get_property), but I
hope we can do this on top of already applied patches.

Thanks again,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
