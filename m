Return-Path: <tjernlund@tjernlund.se>
Received: from csmtp1.b-one.net (csmtp.b-one.net [195.47.247.21])
	by ozlabs.org (Postfix) with ESMTP id BECA0DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 12:07:22 +1100 (EST)
Received: from Jocke (84-217-7-200.tn.glocalnet.net [84.217.7.200])
	by csmtp1.b-one.net (Postfix) with ESMTP id 0ADD51911ED99
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 01:45:26 +0100 (CET)
From: "Tjernlund" <tjernlund@tjernlund.se>
To: "'linuxppc-dev'" <linuxppc-dev@ozlabs.org>
Subject: mpc83xx_restart() buggy
Date: Thu, 28 Dec 2006 01:45:24 +0100
Message-ID: <006401c72a19$7680a5c0$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc83xx_restart() uses ioremap(), which doesn't like
beeing called while in IRQ context. 

Calling mpc83xx_restart() in IRQ context yields OOPS
which calls mpc83xx_restart() again and the loop never
termintes.

 Jocke 
