Return-Path: <linasvepstas@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 521EEB7D8A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 04:59:33 +1000 (EST)
Received: by gyf2 with SMTP id 2so2736664gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 11 May 2010 11:59:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100511013855.GD12203@kryten>
References: <20100511013855.GD12203@kryten>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Tue, 11 May 2010 13:59:09 -0500
Message-ID: <AANLkTinvdNU48u9RcNznXYQJQqTRlBuV4DmJVTwxSqaI@mail.gmail.com>
Subject: Re: [PATCH] powerpc: eeh: Fix oops when probing in early boot
To: Anton Blanchard <anton@samba.org>, Brian King <bjking1@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, leitao@linux.vnet.ibm.com,
	mmlnx@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10 May 2010 20:38, Anton Blanchard <anton@samba.org> wrote:
>
> If we take an EEH early enough, we oops:
>
>
> Call Trace:
> [c000000010483770] [c000000000013ee4] .show_stack+0xd8/0x218 (unreliable)
> [c000000010483850] [c000000000658940] .dump_stack+0x28/0x3c
> [c0000000104838d0] [c000000000057a68] .eeh_dn_check_failure+0x2b8/0x304
> [c000000010483990] [c0000000000259c8] .rtas_read_config+0x120/0x168
> [c000000010483a40] [c000000000025af4] .rtas_pci_read_config+0xe4/0x124
> [c000000010483af0] [c00000000037af18] .pci_bus_read_config_word+0xac/0x10=
4
> [c000000010483bc0] [c0000000008fec98] .pcibios_allocate_resources+0x7c/0x=
220
> [c000000010483c90] [c0000000008feed8] .pcibios_resource_survey+0x9c/0x418
> [c000000010483d80] [c0000000008fea10] .pcibios_init+0xbc/0xf4
> [c000000010483e20] [c000000000009844] .do_one_initcall+0x98/0x1d8
> [c000000010483ed0] [c0000000008f0560] .kernel_init+0x228/0x2e8
> [c000000010483f90] [c000000000031a08] .kernel_thread+0x54/0x70
> EEH: Detected PCI bus error on device <null>
> EEH: This PCI device has failed 1 times in the last hour:
> EEH: location=3DU78A5.001.WIH8464-P1 driver=3D pci addr=3D0001:00:01.0
> EEH: of node=3D/pci@800000020000209/usb@1
> EEH: PCI device/vendor: 00351033
> EEH: PCI cmd/status register: 12100146
>
> Unable to handle kernel paging request for data at address 0x00000468
> Oops: Kernel access of bad area, sig: 11 [#1]
> ....
> NIP [c000000000057610] .rtas_set_slot_reset+0x38/0x10c
> LR [c000000000058724] .eeh_reset_device+0x5c/0x124
> Call Trace:
> [c00000000bc6bd00] [c00000000005a0e0] .pcibios_remove_pci_devices+0x7c/0x=
b0 (unreliable)
> [c00000000bc6bd90] [c000000000058724] .eeh_reset_device+0x5c/0x124
> [c00000000bc6be40] [c0000000000589c0] .handle_eeh_events+0x1d4/0x39c
> [c00000000bc6bf00] [c000000000059124] .eeh_event_handler+0xf0/0x188
> [c00000000bc6bf90] [c000000000031a08] .kernel_thread+0x54/0x70
>
>
> We called rtas_set_slot_reset while scanning the bus and before the pci_d=
n
> to pcidev mapping has been created. Since we only need the pcidev to work
> out the type of reset and that only gets set after the module for the
> device loads, lets just do a hot reset if the pcidev is NULL.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---


Acked-by: Linas Vepstas <linasvepstas@gmail.com>

I'm cc'ing Brian King, he's the one who figured out the proper fix
for a hot-reset/fundamental-reset hardware "feature" that added
this line of code.

The question is -- when the system finishes booting, and the
module finally loads, will the device be found in a usable state
and/or will it automatically reset to a usable state?

--linas

>
> Index: linux-2.6/arch/powerpc/platforms/pseries/eeh.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/eeh.c 2010-05-10 17:25:=
10.703453565 +1000
> +++ linux-2.6/arch/powerpc/platforms/pseries/eeh.c =C2=A0 =C2=A0 =C2=A020=
10-05-10 17:25:24.034323030 +1000
> @@ -749,7 +749,7 @@ static void __rtas_set_slot_reset(struct
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Determine type of EEH reset required by dev=
ice,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * default hot reset or fundamental reset
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 if (dev->needs_freset)
> + =C2=A0 =C2=A0 =C2=A0 if (dev && dev->needs_freset)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtas_pci_slot_rese=
t(pdn, 3);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtas_pci_slot_rese=
t(pdn, 1);
>
>
