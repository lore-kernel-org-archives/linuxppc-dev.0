Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.101.113.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AB67067A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 23:42:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 17 Mar 2005 18:17:24 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA97B@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <hans.schillstrom@pwav.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: FW: LED driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks a lot for your help. But in my sources I could not find=0D
immap_cpm2.h file. There is immap_8260.h file, I don't know it is
similar to that of immap_cpum2.h.=0D

Can you send the immap_cpum2.h file please?

I am working on kernel 2.4.20=0D

-Thanks once again..
SS

-----Original Message-----
From: Hans Schillstrom [mailto:hans.schillstrom@pwav.com]=0D
Sent: Thursday, March 17, 2005 3:17 PM
To: Srinivas Surabhi (WT01 - TELECOM SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FW: LED driver

Hi,
I have made a driver for our mpc8270 board=0D
It is based upon Denx led_driver and made for 2.6 kernel
(See atached file)

To control the leds you have to perfom some ioctl's
first create your devices=0D
mknod led0 c 151 0 ...

Example howto use it:

void led_off( int file )
{
  if (ioctl(file,STATUSLED_SET,0) < 0)
    perror("led off: ");
}
void led_blink( int file )
{
  if (ioctl(file,STATUSLED_SET,1) < 0)
    perror("led blink: ");
}
void led_on( int file )
{
  if (ioctl(file,STATUSLED_SET,2) < 0)
    perror("led on: ");
}
void led_per( int file, int period )
{
  if (ioctl(file,STATUSLED_PERIOD,period) < 0)
    perror("led on: ");
}

...

int led0 =3D open("/dev/led0",O_RDWR)
...
  led_blink(led0);	/* turn on green LED */
..
/Hans


On Thu, 2005-03-17 at 06:15, srinivas.surabhi@wipro.com wrote:
>=0D
> -----Original Message-----
> From: Srinivas Surabhi (WT01 - TELECOM SOLUTIONS)
> Sent: Thursday, March 17, 2005 7:53 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: LED driver
>=0D
> Hi,
>=0D
> I am working on the MPC8270 board having connected GPIO 3 lines
> connected to 3 LEDs. So can any one help me in finding out the best
> solution of controlling the LEDs from MVlinux (kernel and user space)
or
> any pointers who has done it before.
>=0D
> Thanks & Rgds
> SS
>=0D
>=0D
>=0D
>=0D
> Confidentiality Notice
>=0D
> The information contained in this electronic message and any
attachments to this message are intended
> for the exclusive use of the addressee(s) and may contain confidential
or privileged information. If
> you are not the intended recipient, please notify the sender at Wipro
or Mailadmin@wipro.com immediately
> and destroy all copies of this message and any attachments.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=0D



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
