Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D2AF5DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Mar 2007 23:24:46 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l27COUaI020788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Mar 2007 13:24:36 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HOvC2-000JTT-L4
	for linuxppc-embedded@ozlabs.org; Wed, 07 Mar 2007 13:24:30 +0100
Date: Wed, 7 Mar 2007 13:24:30 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Howto read I2C on MPC5200 Lite
Message-ID: <20070307122430.GA73298@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I started playing with I2C on my MPC5200 Lite board now.
For this a attached a MAX6633 to the I2C bus.
With u-boot I can read the chip so I think in hardware is everything ok.

Now I booted my board and loaded the module i2c-mpc and i2c-dev.
Create the devices with major number 89 and minor number 0 and 1.

I checked now for the kernel docu the file dev-interface.
They suggested to use i2c_smbus_read_word_data, but with this I was
not successfully.

So i tried to open the device and read with read from the device, but
no success.

Here is the final code i tried:
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <linux/i2c.h>
#include <linux/i2c-dev.h>

int main(void)
{
   int file;
   int adapter_nr=0;
   char filename[20];
	    
   // open connection to device driver
   sprintf(filename,"/dev/i2c-%d",adapter_nr);
   if((file=open(filename,O_RDWR)) < 0)
   {
     printf("Cannot open i2c device\n");
     exit(1);
   }
	          
   // open connection to I2C device with address addr
   int addr=0x40;
   if(ioctl(file,I2C_SLAVE,addr) <0)
   {
     printf("Cannot access slave device\n");
     exit(1);
   }
	   
   // comunicate with the I2C device
   // device register to access
   __u8 memToRead = 0x0;
   __s32 res;
   char buf[10];
   if(read(file,buf,1) != 1)
   {
     printf("Cannot read from device\n");
   }else{
     printf("Got %s\n",buf[0]);
   }
   close(file);
   return 0;
}

But I always got Cannot read from device.

Can anyone help me here please?

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
