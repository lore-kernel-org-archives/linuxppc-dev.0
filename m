Message-ID: <024101c30a4d$9d609d20$3000a8c0@primag>
From: "Mark Powell" <medp@primagraphics.co.uk>
To: "LinuxPPC-Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <CF1EBE566046A64291A92D640A2368097AD6C2@postal.viasat.com>
Subject: Re: I2C having issues
Date: Thu, 24 Apr 2003 11:38:16 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, April 22, 2003 8:48 PM
Subject: I2C having issues

>
> I tried a couple of things to to get the i2c device up and working and I
> am stil having some problems. The I2C registers are mappped to internal
> memory at address 0xEF60500. I cannot write to this address and read back
> the same values. Here is the output from just the ep405 bootloader.
>

Chris,
there was a bug in 2.4.17 which we are using, where a typo in #if caused the
I2C to be in power-save mode. This gave the symptoms of the I2C module not
responding at all.
This is the diff:

Index: ppc4xx_setup.c
===================================================================
RCS file:
/P2/Hawkeye557/CVS_Repository/Hawkeye557/Linux-405GP/Talon-MVL/linux-2.4.17_
mvl21-talonbsp/arch/ppc/kernel/ppc4xx_setup.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.3
diff -c -r1.1.1.2 -r1.1.1.3
*** ppc4xx_setup.c 3 Jan 2003 17:42:34 -0000 1.1.1.2
--- ppc4xx_setup.c 4 Apr 2003 14:23:01 -0000 1.1.1.3
***************
*** 104,111 ****
   value |= CPM_GPIO0;
  #endif

! #if !defined(CONFIG_PPC405_I2C_ADAP)
!  value |= CPM_IIC0;
   value |= CPM_IIC1;
  #endif

--- 104,111 ----
   value |= CPM_GPIO0;
  #endif

! #if !defined(CONFIG_I2C_PPC405_ADAP)
!    value |= CPM_IIC0;
   value |= CPM_IIC1;
  #endif



--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
