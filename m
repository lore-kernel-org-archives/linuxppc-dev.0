Return-Path: <THagen@oslo.westerngeco.slb.com>
Received: from mail.slb.com (eurmta01.london.eur.slb.com [134.32.26.55])
	by ozlabs.org (Postfix) with ESMTP id F34BE68263
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 18:24:38 +1000 (EST)
Received: from pmxchannel_int-daemon.eurmta01.london.eur.slb.com by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IMU0014IND145@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Thu, 15 Sep 2005 08:24:37 +0000 (GMT)
Date: Thu, 15 Sep 2005 10:24:31 +0200
From: Tore Martin Hagen <THagen@oslo.westerngeco.slb.com>
In-reply-to: <OF29F8842B.21C92BA3-ON6525707B.0016F392-6525707B.0017A365@tcs.com>
To: prabha.j@tcs.com
Message-id: <43292FBF.1040805@oslo.westerngeco.slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <OF29F8842B.21C92BA3-ON6525707B.0016F392-6525707B.0017A365@tcs.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help on 8260 board
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

To change u-boot for your needs you will need to do approximately the 
following:

copy include/configs/MPC8260ADS.h to include/configs/YOURBOARD8260.h

Print out the the file and sit down with the 8260 ref. manual. Adjust 
the YOURBOARD8260.h to fit your needs. (If you are not a HW designer 
this will definitely take you some time)

Added a new directory
      board/yourboard8260
copied the following files from board/mpc8266ads to board/fox8275:
      config.mk
      flash.c
      Makefile
      mpc8260ads.c -> yourboard8260.c
      u-boot.lds
Changed the files to fit the your board.

Changed the main Makefile to support a new target

 > YOURBOARD8260_config:    unconfig
 >     @./mkconfig $(@:_config=) ppc mpc8260 yourboard8260

good luck
