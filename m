Return-Path: <johns.daniel@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 0BBDFDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 00:45:48 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so23049qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 06:45:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <FC69A78E-BDFC-4E89-AF28-42CBA49234FE@kernel.crashing.org>
References: <ba5d9360903241324n57aa74caq2dd2bcdd2a885e19@mail.gmail.com>
	<651BE815-4BF6-4AA3-AA43-C0B7C98A0FCC@kernel.crashing.org>
	<ba5d9360903241413u47a199d4kbde3ed9af238a916@mail.gmail.com>
	<FC69A78E-BDFC-4E89-AF28-42CBA49234FE@kernel.crashing.org>
Date: Wed, 25 Mar 2009 08:45:46 -0500
Message-ID: <ba5d9360903250645i15c16a89ye9bb1998e6c4bedb@mail.gmail.com>
Subject: Re: PCIe interrupts in the device tree
From: Johns Daniel <johns.daniel@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 8:12 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Mar 24, 2009, at 4:13 PM, Johns Daniel wrote:
>
>>
>> On Tue, Mar 24, 2009 at 3:54 PM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>>
>> On Mar 24, 2009, at 3:24 PM, Johns Daniel wrote:
>>
>> Could somebody please explain the declaration of the PCIe interrupts
>> in the device tree?
>>
>> I was under the impression that PCIe interrupts in the PowerPC Linux
>> kernel default to using INTx signaling (vs. external IRQ pin assertion
>> and MSI signaling). Am I right?
>>
>> If so, then do the interrupt-map lines in the DTS refer to the
>> internal IRQ used by Freescale processors to implement INTx virtual
>> wire interrupts?
>>
>> For example, in the mpc8536ds.dts file, under "pci1: pcie@ffe09000" we h=
ave:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IDSEL 0x0 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 1 &mpic 4 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 2 &mpic 5 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 3 &mpic 6 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000 0 0 4 &mpic 7 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >;
>> Are the 4, 5, 6, and 7 internal or external IRQs?
>>
>> The .dts and linux make no distinction between internal & external IRQs.=
 =A0This is a silly artifact of Freescale UMs. =A0IRQ 0 starts at offset 0x=
50000 and each 0x20 offset is another IRQ. =A0So typically External 0 =3D=
=3D IRQ0, Internal 0 =3D=3D IRQ16.
>>
>> So this says that Ext 4, 5, 6, 7 and wired to INTA, INTB, INTC, INTD for=
 this particular PCIe controller.
>>
>> When you say "wired", do you mean hard-wired?
>
> Yes. =A0The INTx emulation interrupts are hard-wired by the SoC on top of=
 the external IRQs.
>
>> If so, how would you specify and use INTx message interrupts?
>
> Do you mean MSI or INTx emulation?

INTx emulation.

I think I finally understand! From what you are saying, IRQ pin
assertion and INTx emulation are indistinct from the point of view of
the processor core, Linux, and the device tree. (The PCIe controller
translates the INTx message to an IRQ assertion.) We can switch to MSI
by having the driver call pci_enable_msi().

Thank you very much, Kumar!
