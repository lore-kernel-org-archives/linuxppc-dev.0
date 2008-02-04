Return-Path: <j.borkhuis@dutchspace.nl>
Message-ID: <47A6D72D.4050100@dutchspace.nl>
Date: Mon, 04 Feb 2008 10:13:17 +0100
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org, Linuxppc-embedded@ozlabs.org
Subject: Moving from 2.6.14 (ppc) to 2.6.20 (powerpc): problems with PCI-PCI
	bridge
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I was using kernel version 2.6.14 (ppc) on a  MVME3100 board (MPC8540 
processor). We are planning to move to 2.6.20 (powerpc), but I have some 
problems with the initialization of a PCI-PCI bridge.
Connected to the MVME3100 board is a PCI-PCI bridge (HiNT, PCI6150, 
3388:0022). When using the 2.6.14 kernel this bridge is initialized 
correctly:  it is setup as bus-master, memory and IO are configured, and 
the memory allocation on the PCI-bus is correct.
When I use 2.6.20 (powerpc) the device is not configured correctly: 
bus-master, memory and IO are not set, and the memory space of the 
bridge on the PCI bus is set to the minimum value (0xfffff).
I can correct these settings by modifying the PCI_COMMAND register to 
set the bus-master, memory and IO. I change the size of the memory space 
in pci_32.c, by forcing the size to the required setting in 
pci_relocate_bridge_resource. But to be honest, I don't like this very 
much: modifying registers like this should not be needed, so I guess 
there is something wrong in my configuration or setup.

How can I fix this problem in a better way? What could be wrong with my 
configuration?

Below is some output from lspci:
bash-3.00# lspci -t
-[0000:00]-+-01.0
           +-02.0-[0000:01]--
           +-03.0-[0000:02-03]--+-00.0
           |                    +-00.1
           |                    +-00.2
           |                    \-04.0-[0000:03]--+-02.0
           |                                      \-03.0
           \-04.0

bash-3.00# lspci -vs  02:04.0
02:04.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04) 
(prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00011000-00011fff
        Memory behind bridge: 87f00000-87ffffff
        Prefetchable memory behind bridge: 0000000087e00000-0000000087e00000
        Capabilities: [dc] Power Management version 1
        Capabilities: [e4] #06 [0094]
        Capabilities: [e8] Vital Product Data

After the modifications to the PCI COMMAND register and memory map:
bash-3.00# lspci -vs  02:04.0
02:04.0 PCI bridge: Hint Corp HiNT HB4 PCI-PCI Bridge (PCI6150) (rev 04) 
(prog-if 00 [Normal decode])
        Flags: stepping, medium devsel
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00011000-00011fff
        Memory behind bridge: 82000000-87ffffff
        Prefetchable memory behind bridge: 0000000000000000-0000000000000000
        Capabilities: [dc] Power Management version 1
        Capabilities: [e4] #06 [0094]
        Capabilities: [e8] Vital Product Data

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@dutchspace.nl          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands
