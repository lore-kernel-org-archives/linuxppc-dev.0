Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8DDC067C0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 19:18:09 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: I2C: Getting Compiation Error for application program
Date: Thu, 21 Sep 2006 11:13:15 +0200
References: <8584FDC94AFF7640B17B8A89B23B19B34F6571@sbsserver.AlphionCorp.local>
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B34F6571@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609211113.15457.matthias.fuchs@esd-electronics.com>
Cc: Sachin Rane <SRane@alphion.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 20 September 2006 14:51, Sachin Rane wrote:
> Hi,
>  
> I am trying to compile simple program (appended), but getting lots of 
compilation error.
It's always helpful to see the compiler output. Could you post it?

> I am using Timesys Linux 2.6.13 for ppc440 evaluation board. 
>  
> Command used for compilation:
> $> gcc eeprom-client.c -o eeprom-client.o
Are you crosscompiling? Doesn't look like that...
>  
> Could you help me to find out the reason behind getting the errors?
>  
> Regards,
> Sachin Rane
>  
>  
> 
8< ------------------------eeprom-client.c -------------------------------------------------------------------------------------
>  
> #include <linux/i2c.h>
> #include <linux/i2c-dev.h>
> 
> int main()
> {
>      int file;
>      int adapter_nr = 0; /* probably dynamically determined */
>      char filename[20];
>      int addr = 0xA1; /* The I2C address */
You propably have to use 0x50 here. 
> 
>     sprintf(filename,"/dev/i2c-%d",adapter_nr);
>     if ((file = open(filename,O_RDWR)) < 0)
>    {
>        exit(1);
>     }
>    
>     if (ioctl(file,I2C_SLAVE,addr) < 0)
>    {
>       exit(1);
>    }
>    else
>   {
>       printf("\n Able to bind the adapter");
>    }
>    return 0;
> }

Matthias
