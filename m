Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B64E2DE061
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 06:00:47 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: u-boot ppc440epx bootstrap configuration without eval board
Date: Wed, 2 Apr 2008 21:00:33 +0200
References: <000901c894eb$e0707170$2001a8c0@DCOGLEYNEW>
In-Reply-To: <000901c894eb$e0707170$2001a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804022100.33364.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 02 April 2008, Dave Cogley wrote:
> Disregard the boot strapping problem.  It appears we are hardwired strapped
> to use option "C" however my CPU is not being recognized as a 667MHz. 
> Which option should I be using for the 667MHz processor?

First, this is the wrong mailing list for this discussion. Please post to the 
U-Boot list instead.

But here some general comments:

The bootstrap controller has multiple configuration options. Some of them 
result in hardwired frequencies (CPU, PLB, OPB...), and some of them load the 
PLL setup from an I2C EEPROM. Using this bootstrap EEPROM is the most 
flexible solution. If you have only option "C", then you hardwired to 533MHz. 
There is no way to "detect" which frequency this CPU is labeled.

But it *is* possible to reconfigure the PLL from within U-Boot an reset the 
PPC to run with this different PLL setup. I just recently added some code the 
u-boot-ppc4xx custodian repository.

Let's continue this thread on the U-Boot list.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
