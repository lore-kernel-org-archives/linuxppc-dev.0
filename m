Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id DDAB5DDFA6
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 07:20:05 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 7213C150E38
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 21:20:04 +0100 (CET)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3YunoKvmqZQs for <linuxppc-dev@ozlabs.org>;
	Tue, 25 Mar 2008 21:20:02 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 2B9CB150E37
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 21:20:02 +0100 (CET)
Date: Tue, 25 Mar 2008 21:20:01 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Haiying Wang <Haiying.Wang@freescale.com>
Subject: Re: how to use head_fsl_booke.S:abort to restart
Message-ID: <20080325202001.GA31145@frolo.macqel>
References: <20080325161513.GB15991@frolo.macqel>
	<1206462895.2960.10.camel@r54964-12.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1206462895.2960.10.camel@r54964-12.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Haiying,

On Tue, Mar 25, 2008 at 12:34:55PM -0400, Haiying Wang wrote:
> 8540 doesn't have RSTCR register. You should not use fsl_rstcr_restart
> for reboot your 8540 board.
> 
That's what I was thinking also (see my Post-Scriptum below), but current
linux/powerpc sources use fsl_rstcr_restart for the mpc8540_ads board :( 

Philippe

> On Tue, 2008-03-25 at 17:15 +0100, Philippe De Muyter wrote:
> > Hi all,
> > 
> > I have a mpc8540 board that could reboot when driven by a ARCH=ppc linux,
> > but that hangs now in arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart when
> > asked to reboot with a ARCH=powerpc linux.
> > 
> > I have found that if I call arch/powerpc/kernel/head_fsl_booke.S:abort from
> > there, my board reboots correctly, but I feel that's not the right place
> > to put that call.  Where/how should I do that ?
> > 
> > Philippe
> > 
> > PS : Does arch/powerpc/sysdev/fsl_soc.c:fsl_rstcr_restart actually work
> > for mpc8540_ads boards ?
