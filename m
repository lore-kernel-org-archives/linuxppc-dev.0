Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id D2BA4DDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 06:49:44 +1000 (EST)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>) id 1K8hlY-0003eM-L2
	for linuxppc-dev@ozlabs.org; Tue, 17 Jun 2008 21:26:56 +0100
Date: Tue, 17 Jun 2008 21:26:56 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: linuxppc-dev@ozlabs.org
Subject: Loading drivers based on board identification
Message-ID: <20080617202656.GA10957@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recently there's been quite a bit of discussion surrounding how to set
up machine specific hardware that can't readily be represented in the
device tree.  I was wondering if one way of solving these problems might
be to provide a mechanism for drivers to load based on board type rather
than by binding to nodes in the device tree, similar to DMI on x86
systems?

The particular case that this has been cropping up for is ASoC machine
drivers - these are drivers which specify how the components of an
embedded audio subsystem (each of which has its own driver) should be
used together to make a functional ALSA device.  Broadly, it will say
something along the lines of "The audio codec at this I2C address is
connected to one or more SSI ports on the SoC and these are clocked in
the following way", though it can get much more complex.  

This isn't a property of any of the component devices - it's all about
the relationships between these devices - and it gets sufficiently
complex in many systems that it's not realistic to try to encode it in
the device tree.  There is normally no specific hardware associated with
this that isn't controlled by one of the component drivers which makes
it difficult to fit into the device tree - in hardware terms this
roughly corresponds to the physical board the system is on.

Since this is difficult to represent in an idiomatic way in the device
tree probing based on the board type seems like reasonable solution.
