Return-Path: <jdl@freescale.com>
Message-ID: <47A74CAC.2010006@freescale.com>
Date: Mon, 04 Feb 2008 11:34:36 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Johan Borkhuis <j.borkhuis@dutchspace.nl>
Subject: Re: Moving from 2.6.14 (ppc) to 2.6.20 (powerpc): problems with
	PCI-PCI bridge
References: <47A6D72D.4050100@dutchspace.nl>
In-Reply-To: <47A6D72D.4050100@dutchspace.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johan Borkhuis wrote:
> Hello,
> 
> I was using kernel version 2.6.14 (ppc) on a  MVME3100 board (MPC8540 
> processor). We are planning to move to 2.6.20 (powerpc), but I have some 
> problems with the initialization of a PCI-PCI bridge.
> Connected to the MVME3100 board is a PCI-PCI bridge (HiNT, PCI6150, 
> 3388:0022). When using the 2.6.14 kernel this bridge is initialized 
> correctly:  it is setup as bus-master, memory and IO are configured, and 
> the memory allocation on the PCI-bus is correct.
> When I use 2.6.20 (powerpc) the device is not configured correctly: 
> bus-master, memory and IO are not set, and the memory space of the 
> bridge on the PCI bus is set to the minimum value (0xfffff).
> I can correct these settings by modifying the PCI_COMMAND register to 
> set the bus-master, memory and IO. I change the size of the memory space 
> in pci_32.c, by forcing the size to the required setting in 
> pci_relocate_bridge_resource. But to be honest, I don't like this very 
> much: modifying registers like this should not be needed, so I guess 
> there is something wrong in my configuration or setup.
> 
> How can I fix this problem in a better way? What could be wrong with my 
> configuration?


There has been a fair amount of PCI setup reworking done
somewhat recently.  (.22 and .23, IIRC, and even .24).
It might be best if you can try 2.6.24.

jdl
