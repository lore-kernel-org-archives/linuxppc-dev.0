Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFA11DDE35
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 03:34:04 +1100 (EST)
Message-ID: <4741BB33.6060206@freescale.com>
Date: Mon, 19 Nov 2007 10:34:59 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Oops: of_platform_serial_probe
References: <474193B8.9060007@anagramm.de> <4741A617.1060207@freescale.com>
	<4741B934.90400@anagramm.de>
In-Reply-To: <4741B934.90400@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Clemens Koller wrote:
> Timur Tabi schrieb:
>  > Clemens Koller wrote:
>  >
>  >> I guess I didn't configure the OF serial right in the .dts but it still
>  >> shouldn't crash. My .config is attached.
>  >
>  > Try disabling CONFIG_SERIAL_OF_PLATFORM.  I don't think it means what
>  > you think it means.
> 
> Thanks, disabling CONFIG_SERIAL_OF_PLATFORM helps. but it still 
> shouldn't crash...

That's a bug in the OF serial driver.  It's expecting fields in the serial 
node that don't exist.  You are right, however.  The driver should at least 
check for NULL pointers.  If I had any hardware that used that driver, I would 
fix it myself.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
