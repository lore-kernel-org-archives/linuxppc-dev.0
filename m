Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00DCEDDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:06:09 +1000 (EST)
Message-ID: <464DCD0E.9000706@freescale.com>
Date: Fri, 18 May 2007 10:58:06 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<8183195dad79296e3986f561bf929067@kernel.crashing.org>	<464CADBB.9050500@freescale.com>
	<20070518172711.2db7fc92@hyperion.delvare>
In-Reply-To: <20070518172711.2db7fc92@hyperion.delvare>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare wrote:
> Hi Scott,
> 
> On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
> 
>>(and the 
>>i2c code in Linux should be fixed to allow drivers to specify multiple 
>>match names).
> 
> 
> Back when David proposed his new-style i2c code, I had the same
> objection. But we addressed the need differently. If you look at struct
> i2c_board_info, you'll see two string fields, driver_name and type. The
> former specifies the driver name, the second specifies the exact device
> variant. For drivers which support several device variants, the
> platform code should fill both fields.

But that still requires the platform to know the driver name, rather 
than matching any driver which knows about the type.  This prevents the 
use of OS-independent device trees (such as in Open Firmware), which 
cannot know specific Linux driver names, without something hacky like a 
type-to-driver table in the device tree code.

-Scott
