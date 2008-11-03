Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 712C1DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 05:57:06 +1100 (EST)
Subject: Re: [PATCH] gianfar: Omit TBI auto-negotiation based on device tree
From: Nate Case <ncase@xes-inc.com>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
References: <1225234382-23050-1-git-send-email-ncase@xes-inc.com>
	<Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 12:55:32 -0600
Message-Id: <1225738532.27415.237.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-30 at 18:07 -0700, Trent Piepho wrote:
> But more relevant to your serdes problem, I also have a patch that
> prevents
> restarting serdes auto-negotiation if the serdes link is already up.
> My SGMII
> PHY will auto-negotiate, but it takes about 3 seconds.  Avoiding an
> unnecessary 3 second auto-negotiation when the gianfar device is
> opened lets
> me cut my power-on to DHCP completion time in half.
> 
> I wonder if this would also fix your problem, without needing to add
> the extra
> workaround?

I just verified that your patch solves my problem without the need for
my workaround.  So at this point, it looks like we can drop this patch
("Omit TBI auto-negotiation based on device tree").

I tested when booting the kernel in U-Boot both via both TFTP and flash
(I was worried that your patch may only fix things for the TFTP boot
case, but that wasn't the case fortunately).

Thanks for the patch!

-- 
Nate Case <ncase@xes-inc.com>
