Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-138.bluehost.com (outbound-mail-138.bluehost.com
	[67.222.39.28]) by ozlabs.org (Postfix) with SMTP id 5AD09DDEEC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 05:15:10 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.26-rc5-mm1: procfs whine
Date: Mon, 9 Jun 2008 12:08:17 -0700
References: <20080609014817.9bdc9ee4.akpm@linux-foundation.org>
In-Reply-To: <20080609014817.9bdc9ee4.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091208.18034.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, June 09, 2008 1:48 am Andrew Morton wrote:
> At boot, using http://userweb.kernel.org/~akpm/config-g5.txt on a mac g5:
>
> io scheduler cfq registered
> proc_dir_entry '00' already registered
> Call Trace:
> [c00000017a0fbb70] [c0000000000120fc] .show_stack+0x58/0x1dc (unreliable)
> [c00000017a0fbc20] [c0000000001415a8] .proc_register+0x218/0x260
> [c00000017a0fbcd0] [c0000000001419d4] .proc_mkdir_mode+0x40/0x74
> [c00000017a0fbd50] [c0000000001e6640] .pci_proc_attach_device+0x90/0x134
> [c00000017a0fbdf0] [c0000000005e5250] .pci_proc_init+0x68/0xa0
> [c00000017a0fbe70] [c0000000005c0cd4] .kernel_init+0x228/0x49c
> [c00000017a0fbf90] [c000000000026e0c] .kernel_thread+0x4c/0x68
> nvidiafb: Device ID: 10de0141

Maybe something in the powerpc PCI init code changed recently?  It looks like 
pci_bus_add_devices() is getting called more than once (or at least 
pci_bus_add_device() for this specific device).

Jesse
