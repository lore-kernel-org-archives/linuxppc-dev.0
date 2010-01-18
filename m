Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 00EDDB6EF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 02:28:57 +1100 (EST)
Received: by yxe9 with SMTP id 9so1621335yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 07:28:55 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 18 Jan 2010 23:28:54 +0800
Message-ID: <e997b7421001180728r19648afdr1256a290596ee613@mail.gmail.com>
Subject: got problem with timer interrupt
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A timer has been added into my system, and it  is used to generate
continuous interrupt every 1 ms.

This hw is register by request_irq(19, handler_1ms)

Howeve I found that , it is longer than 1 ms between two interrupts,
for I used get_cycles everytime we entered

do_irq :

  if(irq==19)
     {
        delta = get_cycle()-old;
     }

  but to find that delta is always larger than cpu cycles between 1ms.


Does anyone know why this happened?


regards,
