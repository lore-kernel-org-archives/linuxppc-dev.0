Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9ED2A67A65
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 18:08:23 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <cajus.hahn@de.abb.com>, <linuxppc-embedded@ozlabs.org>
Date: Mon, 15 Aug 2005 10:08:17 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEECECDDFAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <OF22BDEDEA.B9A60886-ONC125705E.001F8E2A-C125705E.0020E27E@de.abb.com>
Subject: RE: 8xx: i2c-algo-8xx - fixed timeout detection and transmission
	errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> Hi Jocke,
> 
> I changed the force_reinit() to
> 
> // Disable interrupts.
> i2c->i2c_i2cmr = 0;
> i2c->i2c_i2cer = 0xff;
> // Clear enable
> i2c->i2c_i2mod &= ~1;
> // Reset internal state
> iip->iic_rstate = 0;
> iip->iic_tstate = 0;
> 
> This seems to work and is less code than my old force_reinit().
> On the other hand: This kind of CPM timeout will only occur on heavy I2C
> bus conflicts. They should not appear at all. The code will not be executed
> if a slave device does not answer! The original driver is from the year
> 2001 and nobody has mentioned problems of this kind before. Without
> detailed knowledge of the CPM internals I feel much safer using my old
> force_reinit(), which does a complete re-init.

Good, however I think we should try to it simple, the code that is, and avoid
unneded bloat. I would like to see the shorter version in the kernel.

 Jocke
