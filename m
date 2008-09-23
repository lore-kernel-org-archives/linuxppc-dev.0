Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 9E664DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 00:53:03 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2377539wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 07:53:02 -0700 (PDT)
Date: Tue, 23 Sep 2008 08:53:00 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jani.Sarkijarvi@elektrobit.com
Subject: Re: TQM5200 I2C Second bus
Message-ID: <20080923145300.GB13593@secretlab.ca>
References: <3E32F84CD6CB95498A35B353CA3B930C01A179F3@fioues08.ebgroup.elektrobit.com>
	<200809191557.59072.jbe@pengutronix.de>
	<3E32F84CD6CB95498A35B353CA3B930C01C2C6B8@fioues08.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3E32F84CD6CB95498A35B353CA3B930C01C2C6B8@fioues08.ebgroup.elektrobit.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 05:39:05PM +0300, Jani.Sarkijarvi@elektrobit.com wrote:
>  
> It is very possible that, setting are not right. I found from mpc5200 manual this register: (MBAR + 0x0B00, GPS, GPIO Standard registers). Where should be right place to modify those register?

Ideally, your U-Boot port should set the correct value for port config.
If you are unable to modify U-Boot, then you can clone
arch/powerpc/platform/52xx/mpc5200_simple.c for the tqm5200 board and
put the port_config fixup in there.

arch/powerpc/platform/52xx/lite5200.c exists for the exact same reason.
Look at the lite5200_fix_port_config() function.

g.

> 
> BR,
> 
> Jani Särkijärvi
> 
> -----Original Message-----
> From: Juergen Beisert [mailto:jbe@pengutronix.de] 
> Sent: 19 September 2008 16:58
> To: linuxppc-embedded@ozlabs.org
> Cc: Särkijärvi, Jani
> Subject: Re: TQM5200 I2C Second bus
> 
> On Freitag, 19. September 2008, Jani.Sarkijarvi@elektrobit.com wrote:
> > Hi,
> >
> > I'm using TQM5200 (MPC5200) chip with linux-2.6-denx. Problem is to 
> > get second I2c bus to work (/dev/i2c-0) . /dev/i2c-1 seems to be 
> > internal bus and I can read ex. lm75 temperature sensor, also I can 
> > see traffic in oscilloscope (only error is "I2C: No RXAK", but it 
> > seems to be working). My .dts setup is:
> 
> Is your "GPS Port Configuration Register" setting correct?
> 
> jbe
> 
> --
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>    Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
> 
> 
> ----------------------------------------------------------------
> Please note: This e-mail may contain confidential information
> intended solely for the addressee. If you have received this
> e-mail in error, please do not disclose it to anyone, notify
> the sender promptly, and delete the message from your system.
> Thank you.
> 

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
