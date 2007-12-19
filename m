Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C94F3DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Dec 2007 02:14:55 +1100 (EST)
Message-ID: <47693549.9030105@freescale.com>
Date: Wed, 19 Dec 2007 09:14:17 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: DTS files,  83xx, clock frequencies
References: <mailman.543.1198006353.17691.linuxppc-embedded@ozlabs.org>
	<000001c841ce$d11fcdd0$6405a8c0@absolut>
In-Reply-To: <000001c841ce$d11fcdd0$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:

> Isn't default behavior that these fields are kept from the <BIOS> U-boot
> during boot, if a zero is present? Is there any advantage to resetting them
> within the dts file during linux boot up?

Depending on which version of U-Boot, a given property may or may not be 
initialized by U-Boot.  The problem is that as new properties are defined, 
U-Boot is not always updated to initialize that property, and sometimes it's 
only updated on some CPU families.

The qe/brg-frequency property is a good example.  Prior to U-Boot 1.3, it was 
not being initialized at all.  With U-Boot 1.3, it's only initialized on 83xx, 
even though some 85xx boards have a QE.  I have a QE UART driver that looks at 
qe/brg-frequency, and if it's non-zero, I use it.  If it is zero, then I take 
the qe/bus-frequency property and divide it in half.


-- 
Timur Tabi
Linux kernel developer at Freescale
