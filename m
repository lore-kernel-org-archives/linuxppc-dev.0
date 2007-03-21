Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 60EFDDDF09
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Mar 2007 13:41:24 +1100 (EST)
Message-ID: <46009B2A.2020706@ovro.caltech.edu>
Date: Tue, 20 Mar 2007 19:40:42 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Adrian Craine <adrian.craine@nec.com.au>
Subject: Re: MPC8347 PQ2 I2C driver
References: <46009113.6050501@nec.com.au>
In-Reply-To: <46009113.6050501@nec.com.au>
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

Adrian Craine wrote:
> Hi all,
> 
> Just a quick one, does any-one know if the i2c-mpc i2c driver will
> function on a Freescale MPC8347?
> 

Seems to work fine on the MPC8349E-MDS-PB.

I believe one of the engineers just installed the lm-sensors
i2c tools and they worked fine, i.e., the i2c driver that
is built by default in the Denx kernel and LTIB kernel
works.

I know I've used the i2c tools without trouble.

If its any use, here's what appears to be running on the
board now (ELDK 4.0 based I believe ...)

bash-3.00# uname -a
Linux cobralab1 2.6.18-rc2 #1 Tue Aug 8 13:04:42 PDT 2006 ppc ppc ppc 
GNU/Linux

Here's the output from an MPC8349E-MDS-PB bus #0

bash-3.00# i2cdetect -y 0
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- 31 -- -- -- -- -- -- -- -- -- -- -- -- -- 3f
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- 68 -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
bash-3.00#

and bus #1

bash-3.00# i2cdetect -y 1
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- 21 -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
bash-3.00#

I've hooked up an AD7998 I2C eval board to bus #1
at address 21h. Normally you'd only see the EEPROM
at 50h.

Cheers,
Dave
