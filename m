Return-Path: <johns.daniel@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id B2D8CDDF8E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 07:24:52 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1637904ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 13:24:50 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 24 Mar 2009 15:24:50 -0500
Message-ID: <ba5d9360903241324n57aa74caq2dd2bcdd2a885e19@mail.gmail.com>
Subject: PCIe interrupts in the device tree
From: Johns Daniel <johns.daniel@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Could somebody please explain the declaration of the PCIe interrupts
in the device tree?

I was under the impression that PCIe interrupts in the PowerPC Linux
kernel default to using INTx signaling (vs. external IRQ pin assertion
and MSI signaling). Am I right?

If so, then do the interrupt-map lines in the DTS refer to the
internal IRQ used by Freescale processors to implement INTx virtual
wire interrupts?

For example, in the mpc8536ds.dts file, under "pci1: pcie@ffe09000" we have:
		interrupt-map = <
			/* IDSEL 0x0 */
			0000 0 0 1 &mpic 4 1
			0000 0 0 2 &mpic 5 1
			0000 0 0 3 &mpic 6 1
			0000 0 0 4 &mpic 7 1
			>;
Are the 4, 5, 6, and 7 internal or external IRQs?

And the "msi@41600" section in the same mpc8536ds.dts file does NOT
affect PCIe interrupts unless a driver calls pci_enable_msi()?

TIA!

-- Johns
