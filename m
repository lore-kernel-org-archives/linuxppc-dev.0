Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1626BB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 00:21:38 +1000 (EST)
Message-ID: <4A8C08E7.2060802@grandegger.com>
Date: Wed, 19 Aug 2009 16:15:03 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: OF modalias
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm confused by the modalias'es created by OF devices, e.g.:

  # cat /sys/devices/f0000000.soc5200/f0000f00.spi/modalias 
  of:NspiT<NULL>Cfsl,mpc5200b-spiCfsl,mpc5200-spi

First of all, the string "<NULL>" looks like an error. 

I could then dynamically load a driver module for the SPI using:

  # modprobe `cat sys/devices/f0000000.soc5200/f0000f00.spi/modalias`

This does make sense for the SPI device, but there are OF devices which
cannot really be used by a module driver, e.g.:

  # cat /sys/devices/f0000000.soc5200/f0000500.interrupt-controller/modalias
  of:Ninterrupt-controllerT<NULL>Cfsl,mpc5200b-picCfsl,mpc5200-pic

The same for localbus, cdm, etc. Does it make sense for these 
to create a modalias file?

Likely I have missed something. Thanks for clarification.

Wolfgang.
