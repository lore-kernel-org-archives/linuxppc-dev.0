Return-Path: <cajus.hahn@de.abb.com>
Received: from nse1.abb.com (nse1.abb.com [129.35.204.68])
	by ozlabs.org (Postfix) with ESMTP id A61CC67EB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 15:59:19 +1000 (EST)
Received: from abb-despk-smtp.de.abb.com (deehn-s-cc1gw54.de.abb.com
	[10.51.20.40])
	by nse1.abb.com (8.11.6/8.11.6) with ESMTP id j7F5xFT31894
	for <linuxppc-embedded@ozlabs.org>; Mon, 15 Aug 2005 07:59:16 +0200
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF22BDEDEA.B9A60886-ONC125705E.001F8E2A-C125705E.0020E27E@de.abb.com>
From: cajus.hahn@de.abb.com
Date: Mon, 15 Aug 2005 07:59:11 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





Hi Jocke,

I changed the force_reinit() to

// Disable interrupts.
i2c->i2c_i2cmr = 0;
i2c->i2c_i2cer = 0xff;
// Clear enable
i2c->i2c_i2mod &= ~1;
// Reset internal state
iip->iic_rstate = 0;
iip->iic_tstate = 0;

This seems to work and is less code than my old force_reinit().
On the other hand: This kind of CPM timeout will only occur on heavy I2C
bus conflicts. They should not appear at all. The code will not be executed
if a slave device does not answer! The original driver is from the year
2001 and nobody has mentioned problems of this kind before. Without
detailed knowledge of the CPM internals I feel much safer using my old
force_reinit(), which does a complete re-init.

Cajus
