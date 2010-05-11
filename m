Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CD30B7DB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 05:10:04 +1000 (EST)
Message-ID: <4BE9AB8D.7010409@embedded-sol.com>
Date: Tue, 11 May 2010 22:10:05 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 85xx: Fix PCI-E interrupt mapping for slot 0 of P2020DS
References: <> <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
	<1CA6B1BA-FBD1-4ECF-87DC-D3E50835E781@kernel.crashing.org>
In-Reply-To: <1CA6B1BA-FBD1-4ECF-87DC-D3E50835E781@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On 5/11/2010 3:36 PM, Kumar Gala wrote:
> On May 10, 2010, at 2:15 PM, Felix Radensky wrote:
>
>   
>> Fix legacy PCI-E interrupt mapping for PCI-E slot 0 of
>> P2020DS evaluation board. The patch is based on P2020DS
>> device tree from Freescale BSP for this board.
>>
>> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
>> ---
>> arch/powerpc/boot/dts/p2020ds.dts |    8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)
>>     
> I don't understand why this is needed?
>
> -k
>
>   

With 2.6.34-rc7 I get this nice dump when loading ath9k for PCI-E card
in slot 0:

irq 17: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[ef0d59d0] [c00070b0] show_stack+0x3c/0x17c (unreliable)
[ef0d5a10] [c00740f8] __report_bad_irq+0x38/0xcc
[ef0d5a30] [c0074344] note_interrupt+0x1b8/0x228
[ef0d5a60] [c007539c] handle_fasteoi_irq+0xac/0x138
[ef0d5a80] [c0004a68] do_IRQ+0xd8/0x104
[ef0d5aa0] [c00102b0] ret_from_except+0x0/0x18
[ef0d5b60] [00029000] 0x29000
[ef0d5bb0] [c000498c] do_softirq+0x6c/0x70
[ef0d5bc0] [c0043bb4] irq_exit+0xb0/0xb4
[ef0d5bd0] [c0004a6c] do_IRQ+0xdc/0x104
[ef0d5bf0] [c00102b0] ret_from_except+0x0/0x18
[ef0d5cb0] [c00735c4] __setup_irq+0x374/0x3ac
[ef0d5ce0] [c00736d4] request_threaded_irq+0xd8/0x150
[ef0d5d10] [f11e8c34] ath_pci_probe+0x28c/0x3f8 [ath9k]
[ef0d5d90] [c0186334] local_pci_probe+0x24/0x34
[ef0d5da0] [c0186688] pci_device_probe+0x84/0xc4
[ef0d5dd0] [c01b7f84] driver_probe_device+0xa4/0x198
[ef0d5df0] [c01b8328] __driver_attach+0xa4/0xa8
[ef0d5e10] [c01b71b8] bus_for_each_dev+0x60/0x9c
[ef0d5e40] [c01b7d98] driver_attach+0x24/0x34
[ef0d5e50] [c01b7b20] bus_add_driver+0x1bc/0x280
[ef0d5e80] [c01b85b4] driver_register+0x70/0x168
[ef0d5ea0] [c01869a0] __pci_register_driver+0x5c/0xe4
[ef0d5ed0] [f11e88cc] ath_pci_init+0x28/0x38 [ath9k]
[ef0d5ee0] [f11f104c] ath9k_init+0x4c/0xb0 [ath9k]
[ef0d5ef0] [c0001cfc] do_one_initcall+0x40/0x1dc
[ef0d5f20] [c0070a7c] sys_init_module+0xf4/0x21c
[ef0d5f40] [c000fc58] ret_from_syscall+0x0/0x3c
handlers:
[<f11e16ac>] (ath_isr+0x0/0x1b4 [ath9k])
Disabling IRQ #17

The ath9k driver does not support MSI interrupts, so it has to use 
legacy ones.
If MSI interrupts are disabled in the kernel configuration I get similar 
dump
with e1000e driver.

The patch I've sent fixes the problem with legacy interrupts.

Felix.
