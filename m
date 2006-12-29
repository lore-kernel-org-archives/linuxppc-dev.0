Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EB7FFDDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 11:31:29 +1100 (EST)
Date: Fri, 29 Dec 2006 01:31:38 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mark Glines <mark@glines.org>
Subject: Re: kurobox kernel
In-Reply-To: <45945324.20805@glines.org>
Message-ID: <Pine.LNX.4.60.0612290127180.3942@poirot.grange>
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>
	<45942EBF.5060201@glines.org>
	<Pine.LNX.4.60.0612282206430.3942@poirot.grange>
	<45945324.20805@glines.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Dec 2006, Mark Glines wrote:

> Guennadi Liakhovetski wrote:
> >> So, uh... is the *.dts file in 2.6.20-rc2 bad, or am I compiling it wrongly?
> >> (And is this normally done by hand, or as part of the kernel build process?)
> > 
> > That's ok. You DO have the "-f" which does produce an output. The error is 
> > because the "chosen" is not there, but this is how we need it for U-boot. 
> > 
> > It's done by hand.
> > 
> > So, you've done everything right! Congrats:-)
> 
> Great.  Any chance you can send me your kernel config?  My IDE support 
> isn't working, and I'd like to figure out why.

My config is in the kernel - arch/powerpc/configs/linkstation_defconfig.
And I don't use IDE, I use PATA, and it works good, I also had problems 
with IDE, although, not as bad as you describe. Also, you, certainly, need 
root=/dev/sda1, not hda1, change it in your U-boot environment. As for 
interrupt numbers - they are correct, and they are (pretty) arbitrary, 
allocated dynamically. I have:

lyakh@KURO-BOX:~$ cat /proc/interrupts
           CPU0
 16:          0   EPIC      Level     serial
 17:        230   EPIC      Edge      serial
 18:       1747   EPIC      Level     i2c-mpc
 19:     142193   EPIC      Level     eth0
 20:       1764   EPIC      Level     libata
 21:    1309856   EPIC      Level     ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
BAD:         15

Thanks
Guennadi
---
Guennadi Liakhovetski
