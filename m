Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65DAA67E88
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Aug 2005 01:13:30 +1000 (EST)
Received: from Jocke (84-217-84-230.tn.glocalnet.net [84.217.84.230] (may be
	forged)) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id j7DFDOVJ007976
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sat, 13 Aug 2005 17:13:25 +0200
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@ozlabs.org>
Date: Sat, 13 Aug 2005 17:13:23 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHAEHNCMAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> My description seems to be a little misleading.
> WITHOUT the force_reinit() my SPI driver reports transmission errors if the
> I2C bus has longer disturbances.
> WITH the force_reinit() my SPI driver works fine.
> This sounds like the I2C allocates a new buffer for every timed-out
> transmision. If all I2C buffers are full, the SPI buffers get overwritten
> !?
> I did not really trace back the problem, this is only my suspicion.
> Because the  force_reinit() resets all the buffer pointer to their init
> values the problem with the SPI does not occur.
> 
> Cajus

I think the problem is that the CPM is still waiting on the SCL long after the timeout has happen.
A complete reinit will reset the I2C part of the CPM.

I think you should be able to get away with less, maybe it will enough to disable
I2C (i2c->i2c_i2mod &= ~1) and/or clear internal state (iip->iic_rstate   = 0; iip->iic_tstate   = 0;)
after a timeout?

 Jocke
