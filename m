Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5413FDDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 03:58:49 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1GGwh9r016029
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 10:58:43 -0600
Message-Id: <59D5800B-309D-4A4E-AD1F-CEC8E2D1BE5B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: open-pic device tree node and subnodes for additional functionality?
Date: Mon, 16 Feb 2009 10:58:42 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freescale open-pic controllers we have a number of additional  
features not spec'd per openpic.  (additional timers, perf mon, PCIe  
msi, message interrupts, ...).  The problem is how to identify these  
features in the device tree.

For example we have:

                 msi@41600 {
                         compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
                         reg = <0x41600 0x80>;
                         msi-available-ranges = <0 0x100>;
                         interrupts = <
                                 0xe0 0
                                 0xe1 0
                                 0xe2 0
                                 0xe3 0
                                 0xe4 0
                                 0xe5 0
                                 0xe6 0
                                 0xe7 0>;
                         interrupt-parent = <&mpic>;
                 };

                 mpic: pic@40000 {
                         interrupt-controller;
                         #address-cells = <0>;
                         #interrupt-cells = <2>;
                         reg = <0x40000 0x40000>;
                         compatible = "chrp,open-pic";
                         device_type = "open-pic";
                 };

---

should we put msi under the pic node as a child and add ranges, etc.   
The question that raises in my mind is what does the reg property end  
up meaning.  I assume it shouldn't stay as is.

- k
