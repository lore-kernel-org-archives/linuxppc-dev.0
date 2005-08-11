Return-Path: <tjernlund@tjernlund.se>
Received: from csmtp.b-one.net (csmtp.b-one.net [195.47.247.21])
	by ozlabs.org (Postfix) with ESMTP id 51427680AB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 04:22:31 +1000 (EST)
Received: from Jocke (unknown [84.217.84.230])
	by csmtp.b-one.net (Postfix) with ESMTP id 083EE1A0078A9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 19:50:47 +0200 (CEST)
From: "Tjernlund" <tjernlund@tjernlund.se>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 11 Aug 2005 19:50:45 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHOEHJCMAA.tjernlund@tjernlund.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Try changing all
  i2c->i2c_i2com |= 0x80;	/* Begin transmission */
to
  i2c->i2c_i2com |= 0x80 | 0x01;	/* Begin transmission */

That should remove the need to do force_reinit(cpm) I hope.
See http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019600.html for a litte more info.

Also, I think you should remove the busy wait code. Its not needed IMHO.

 Jocke
