Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18705.34001.627279.298632@cargo.ozlabs.ibm.com>
Date: Wed, 5 Nov 2008 22:34:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 9/10] powerpc/pci: Fix various pseries PCI Hotplug issues
In-Reply-To: <20081028054953.3DD34DE124@ozlabs.org>
References: <1225172895.217185.958686212130.qpush@grosgo>
	<20081028054953.3DD34DE124@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> The pseries PCI Hotplug code has a number of issues, ranging from
> incorrect resource setup to crashes, depending on what is added,
> when, whether it contains a bridge, etc etc....
> 
> This patch fixes a whole bunch of these, while actually simplifying
> the code a bit, using more generic code in the process and factoring
> out common code between adding of a PHB, a slot or a device.

This causes a compile error on Cell:

arch/powerpc/kernel/of_platform.c: In function 'of_pci_phb_probe':
arch/powerpc/kernel/of_platform.c:287: error: implicit declaration of function 'pcibios_claim_one_bus'
make[2]: *** [arch/powerpc/kernel/of_platform.o] Error 1

Paul.
