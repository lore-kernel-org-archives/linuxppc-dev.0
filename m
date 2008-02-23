Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 32CDCDDF52
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 08:24:41 +1100 (EST)
Date: Sat, 23 Feb 2008 15:28:23 -0600
From: Olof Johansson <olof@lixom.net>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Message-ID: <20080223212823.GA22131@lixom.net>
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
	<47BEAF00.50106@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47BEAF00.50106@scram.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scottwood@freescale.com>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 12:16:16PM +0100, Jochen Friedrich wrote:

> Fortunately, I2c no longer uses numeric device IDs but names. So what are the alternatives?
> 
> 1. modify the I2c subsystem to accept OF names additionally to I2c names (proposed by Jon smirl).

Sounds like Jean isn't very excited about this idea..

> 2. record the I2c name in the dts tree, either as seperate tag (like linux,i2c-name="<i2c-name>")
>    or as additional compatible entry (like compatible="...", "linux,<i2c-name>").

I have to say no on this one. The device tree is not supposed to know
about how linux uses devices, there are firmwares out there that don't
use DTS for thier device trees, etc.

> 3. use a glue layer with a translation map.

In my opinion this is an OK solution since the same information has to
be added somewhere already anyway -- eiither to the drivers or to this
translation table. It should of course be an abstacted shared table,
preferrably contained under the i2c source directories since several
platforms and architectures might share them.


-Olof
