Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0040.outbound.protection.outlook.com [104.47.34.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy5Sz2mJczDrWD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 02:54:59 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: irq 26: nobody cared, caused by mpc85xx_pci_isr on P2010 and T1042
Date: Wed, 20 Sep 2017 16:54:49 +0000
Message-ID: <1505926487.14509.15.camel@infinera.com>
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

Some PCIe errors, don't know which(possibly by PCIe 4 in
   http://pdf1.solecsy.com/61/5af9fd2d-652c-4331-b49c-807c7c47f4f7.pdf)
causes endless IRQ for EDAC's PCIe routine:

[   17.690716] irq 26: nobody cared (try booting with the "irqpoll" option)
[   17.697417] CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.43+ #24
[   17.703334] Call Trace:
[   17.705780] [df9edf10] [c0056990] __report_bad_irq.isra.7+0x34/0xdc (unr=
eliable)
[   17.713181] [df9edf30] [c0056d20] note_interrupt+0x274/0x2c0
[   17.718840] [df9edf60] [c00549e0] handle_irq_event_percpu+0x1a0/0x208
[   17.725281] [df9edfa0] [c0054a80] handle_irq_event+0x38/0x5c
[   17.730940] [df9edfb0] [c0057668] handle_fasteoi_irq+0xb0/0x1e0
[   17.736867] [df9edfc0] [c005404c] generic_handle_irq+0x3c/0x5c
[   17.742703] [df9edfd0] [c0004be0] __do_irq+0x48/0x10c
[   17.747752] [df9edff0] [c000c398] call_do_irq+0x24/0x3c
[   17.752977] [c0453e80] [c0004d08] do_IRQ+0x64/0xc4
[   17.757768] [c0453ea0] [c000da3c] ret_from_except+0x0/0x18
[   17.763257] --- interrupt: 501 at arch_cpu_idle+0x4c/0x5c
[   17.763257]     LR =3D cpu_startup_entry+0x17c/0x20c
[   17.773437] [c0453f60] [c004de1c] cpu_startup_entry+0x74/0x20c (unreliab=
le)
[   17.780405] [c0453fb0] [c03fc988] start_kernel+0x34c/0x360
[   17.785889] [c0453ff0] [c0000380] set_ivor+0x10c/0x148
[   17.791024] handlers:
[   17.793296] [<c0238e74>] mpc85xx_pci_isr
[   17.797213] Disabling IRQ #26

Most annoying and makes EDAC useless. Can it be fixed?

 Jocke=
