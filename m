Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9265367C0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 00:54:06 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: "Sachin Rane" <SRane@alphion.com>
Subject: Re: Need help to write I2C EEPROM device driver
Date: Wed, 27 Sep 2006 16:51:21 +0200
References: <8584FDC94AFF7640B17B8A89B23B19B34F658F@sbsserver.AlphionCorp.local>
	<200609271221.54878.matthias.fuchs@esd-electronics.com>
	<8584FDC94AFF7640B17B8A89B23B19B34F6593@sbsserver.AlphionCorp.local>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F6593@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609271651.22106.matthias.fuchs@esd-electronics.com>
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

On Wednesday 27 September 2006 16:11, Sachin Rane wrote:
> To access EEPROM using /dev/i2c-<x>, which drivers I need to load?
>  
> Please confirm that I need to load following drivers:
> 1. i2c-core.ko (Core Driver)
> 2. i2c-ibm-iic.ko (Bus Driver)
> 3. i2c-dev.ko (Dev Interface driver)
That looks good.

> Do I need to load 'eeprom.ko'?
No.

> Because in one of the mail from the mailing list, it was mentioned that I 
should not load  ''eeprom.ko" to access the chip using 'dev' interface.
Either use access via /dev/i2c-x or via eeprom driver. I haven't used the 
later one so far. Using both at the same time is probably not possible.

Matthias

>  
> Thanks and Regards,
> Sachin Rane
> 
> ________________________________
> 
> From: Matthias Fuchs [mailto:matthias.fuchs@esd-electronics.com]
> Sent: Wed 9/27/2006 6:21 AM
> To: linuxppc-embedded@ozlabs.org
> Cc: Sachin Rane
> Subject: Re: Need help to write I2C EEPROM device driver
> 
> 
> 
> Hi Sachin,
> 
> there is already a driver for this part in the kernel
> (drivers/i2c/chips/eeprom.c).
> 
> BTW: to do some simple reads and writes to an I2C EEPROM it is very simple 
to
> access the EEPROM via read/write/ioctl through /dev/i2c-<x>. No driver - 
only
> userland code.
> 
> Matthias
> 
> 
> On Tuesday 26 September 2006 16:34, Sachin Rane wrote:
> > Hi,
> > 
> > I am looking for an information to write a device driver to access EEPROM 
IC
> M24C02-WBN6.
> > The EEPROM IC M24C02-WBN is present on the 'ppc440' evaluation board for
> boot strap purpose.
> 
> 
> 
