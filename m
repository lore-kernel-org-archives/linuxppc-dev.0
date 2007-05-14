Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 15939DDF08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 00:49:40 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB support for Bamboo/440EP (Yosemite/440EPx)
Date: Mon, 14 May 2007 16:31:04 +0200
References: <OF5B339C18.B1F62CD6-ON85257371.003D3A0F-852572DB.004D9561@us.ibm.com>
In-Reply-To: <OF5B339C18.B1F62CD6-ON85257371.003D3A0F-852572DB.004D9561@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705141631.04546.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Montag, 14. Mai 2007, Stephen Winiecki wrote:
> Is there an intention to add the configuration for the USB host controller 
> for Bamboo/Yosemite to the mainline kernel?  drivers/usb/host contains 
> ohci-ppc-soc.c/h, but the Kconfig isn't updated to include it for 
> 440EP/EPx? 
> 
> I noticed it is configured in the Denx 4.1 2.6.19.2 kernel.  When I 
> updated the 2.6.21 drivers/usb/host/Kconfig to include the controller 
> support for 440EP for some reason I couldn't get the kernel to recognize 
> the controller or devices when it boots - not sure if there is something 
> else I am missing here?  One thing I noticed was that in the 2.6.19.2 
> kernel CONFIG_USB_OHCI_BIG_ENDIAN gets defined - in 2.6.21 there is both 
> CONFIG_USB_OHCI_BIG_ENDIAN_DESC and CONFIG_USB_OHCI_BIG_ENDIAN_MMIO - 
> assume I want both defined?
> 
> Wondering also if anyone has much experience using the USB interface on 
> Bamboo - and if any reliability issues have been observed?  I have a 
> Bamboo system where we've added graphics card init capability to PIBS and 
> are using the DENX 2.6.19.2 kernel and booting X (Xorg 7.1.1 - Debian 4.0 
> system on hard disk) with a USB keyboard and mouse - and sometimes the 
> mouse/keyboard are not detected properly by either the kernel on boot, or 
> by X during its initialization (sometimes even after the kernel seems to 
> detect everything fine).  I did play a bit with a memory stick on the 
> interface and that seemed reliable for the little I did with it.
> 
> I am using an Apple keyboard plugged into the USB port on the board, with 
> an IBM Scrollpoint USB mouse plugged into one of the ports on the 
> keyboard.

[SNIPSNAP]
Hi Stephen, 

I also played with Bamboo and Yosemite USB and found out, that the OHCI
ISR contains an assumption that makes the 440 OHCI implementation sometimes 
stop when having a timeout condition. Find the following sequence @ function
ohci_irq() (in file ohci-hcd.c) and disable the following code:

        if ((ohci->hcca->done_head != 0)
                        && ! (hc32_to_cpup (ohci, &ohci->hcca->done_head)
                                & 0x01)) {
                ints =  OHCI_INTR_WDH;
	}

This should make the USB host work reliably on the 440s.

HTH
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
