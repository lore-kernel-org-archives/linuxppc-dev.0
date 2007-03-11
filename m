Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D2CF1DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Mar 2007 11:55:48 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2B0ta0c077375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Mar 2007 01:55:41 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HQCLX-000Aa9-TI
	for linuxppc-embedded@ozlabs.org; Sun, 11 Mar 2007 01:55:35 +0100
Date: Sun, 11 Mar 2007 01:55:35 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070311005535.GA39488@server.idefix.lan>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
	<20070309234251.GA68997@server.idefix.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20070309234251.GA68997@server.idefix.lan>
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


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Matthias Fechner <idefix@fechner.net> [10-03-07 00:42]:
> It seems now that everything works fine. I will check it for the next
> days. And will give some feedback.

ok, I checked now the driver some time at it failed. So it seems that
that the patch had not solved the problem.

I have attached the programm to check it.

I changed the time to 2 seconds but that didn't help.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook

--3V7upXqbjpZ4EhLz
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="readMax6633.c"

/* read the data from max6633 */

#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include "i2c-dev.h"
#include "version.h"

static __inline__ unsigned short swap_bytes(unsigned short val)
{
   return(val >> 8) | (val << 8);
}

int main(void)
{
   int res,address,file;
   char filename[20];
   unsigned short temp;
   long funcs;
   int i2cbus;
   int errorCount,successfullCount;
   errorCount=successfullCount=0;
   i2cbus=1;
   address=0x40;
   
   sprintf(filename,"/dev/i2c-%d",i2cbus);
   if((file=open(filename,O_RDWR))<0)
   {
      fprintf(stderr,"Error: could not open file %s: %s\n",filename,strerror(errno));
      exit(1);
   }
   
   /* check adapter functionality */
   if(ioctl(file,I2C_FUNCS,&funcs) < 0)
   {
      fprintf(stderr, "Error: could not get the adapter functionality matrix: %s\n",strerror(errno));
      goto ERROR0;
   }
   if(!(funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA))
   {
      fprintf(stderr,"Error: Adapter for i2cbus %d",i2cbus);
      fprintf(stderr," does not have byte read capability\n");
      goto ERROR0;
   }
   if(!(funcs & I2C_FUNC_SMBUS_READ_WORD_DATA))
   {
      fprintf(stderr,"Error: Adapter for i2cbus %d",i2cbus);
      fprintf(stderr," does not have word read capability\n");
      goto ERROR0;
   }
      
   
   /* use FORCE so that we can look at registers even when a driver
      is also running */
   if(ioctl(file,I2C_SLAVE,address) <0)
   {
      fprintf(stderr,"Error: Could not set address to %d: %s\n",address, strerror(errno));
      goto ERROR0;
   }
   
   fprintf(stderr,"Read with word_data\n");
   while(1)
   {
      
      temp=res=i2c_smbus_read_word_data(file,0);
      if(res<0)
      {
	 fprintf(stderr,"Error: Could not read the value from the i2c device\n");
	 errorCount++;
      }else
      {
	 successfullCount++;
      }
      
      temp=swap_bytes(temp);
      temp=temp >> 3;
      
      printf("Succes: %i, Errorcount: %i, Temp: %f\n",successfullCount,errorCount,(float)(temp*0.0625));
      sleep(1);
   }
   
   printf("\nCalculate temp\n");
  
   close(file);
   exit(0);

  ERROR0:
   close(file);
   exit(1);
}


--3V7upXqbjpZ4EhLz--
