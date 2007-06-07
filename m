Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 156BEDDF07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:04:39 +1000 (EST)
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200706070039.51541.arnd@arndb.de>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:04:36 -0700
Message-Id: <1181232276.5674.146.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 00:39 +0200, Arnd Bergmann wrote:
> On Wednesday 06 June 2007, Wade Farnsworth wrote:
> > +       /* LPC47M192 Super I/O configuration */
> > +       outb(0x55, 0x4e);       /* enter superio config mode */
> > +
> > +       /* Enable keyboard and mouse */
> > +       outb(0x07, 0x4e);       /* device selector register */
> > +       outb(0x07, 0x4f);       /* select keyboard registers (device 7) */
> > +       outb(0x30, 0x4e);       /* keyboard activation register */
> > +       outb(0x01, 0x4f);       /* activate keyboard */
> 
> Hardcoded I/O port numbers always worry me a little. I know that this is
> supposed to work in general, but can't you read the I/O port range from
> a device tree property?

I suppose I could create a device node for the Super I/O config
registers and use those instead of hardcoding it here.

Something to the effect of:

superio_cfg@4e {
	reg = <1 4e 2>;
	compatible = "smsc-lpc47m192-cfg";
};

I'm not sure if the name and compatible properties are appropriate
though.  Any recommendations?

--Wade
