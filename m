Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <CA78D1B723D8D411AF0300508BDCF74FD5BC75@NTCORREO>
From: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Just a little compilation error if i2c like NO module
Date: Thu, 12 Sep 2002 13:56:56 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all:

	I have the kernel version 2.4.4 of 2001-7-23
	I try to compile i2c like no module and i find that it has problems.
	In drivers/i2c/i2c-simple.c (lines 48 to 59):
		/*
		* Deal with CONFIG_MODVERSIONS
		 */
		#if CONFIG_MODVERSIONS==1
		/* # define MODVERSIONS */
		# include <linux/modversions.h>
		#endif

		#ifdef MODULE
		MODULE_AUTHOR("Wolfgang Denk, wd@denx.de");
		MODULE_DESCRIPTION("Simple I2C Driver for LWMON Project");
		#endif	/* MODULE */

	And the new code order i put is:


		/*
		 * Deal with CONFIG_MODVERSIONS
		 */

		#ifdef MODULE
		#	if CONFIG_MODVERSIONS==1
				/* # define MODVERSIONS */
		# 		include <linux/modversions.h>
		#	endif
			MODULE_AUTHOR("Wolfgang Denk, wd@denx.de");
			MODULE_DESCRIPTION("Simple I2C Driver for LWMON
Project");
		#endif	/* MODULE */

	It now compiles fine.
	Bye.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
