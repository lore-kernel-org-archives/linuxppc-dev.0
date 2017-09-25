Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0060.outbound.protection.outlook.com [104.47.38.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y19FK6ncKzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 02:55:33 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: FSL serial 166550 errata broken?
Date: Mon, 25 Sep 2017 16:55:26 +0000
Message-ID: <1506358524.29657.31.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We got some "broken" boards(mpx8321) where UART RX is held low(BREAK)
There we get a few:
  serial8250: too much work for irq18
and the board freezes.

Looking inte to driver/CPU there is an errtum(A-004737) w.r.t BREAK handlin=
g
and I can see we are hitting the irq function fsl8250_handle_irq() added
in commit: 9deaa53ac7fa373623123aa4f18828dd62292b1a
 "serial: add irq handler for Freescale 16550 errata."
For all I can tell this workaround is broken and I cannot figure out why.
Any pointers?

 Jocke=
