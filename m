Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 87AB2B7CC2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 02:00:21 +1100 (EST)
Received: by gyf1 with SMTP id 1so2786527gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 08:00:20 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BA70E28.9080007@freemail.hu>
References: <4B934CCA.8030608@freemail.hu> <4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<4B9B7E0A.8090703@freemail.hu>
	<fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
	<4BA70E28.9080007@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 22 Mar 2010 08:59:43 -0600
Message-ID: <fa686aa41003220759m438472efra2b889e54c73aef1@mail.gmail.com>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/22 N=E9meth M=E1rton <nm127@freemail.hu>:
> Hi Grant,
>
> thanks for the comments, I solved some of the points you mentioned. I nee=
d some
> more time to work on the others. In the meantime I send the intermediate =
version.
>
> Grant Likely wrote:
>> 2010/3/13 N=E9meth M=E1rton <nm127@freemail.hu>:
> [...]
>>> + =A0 =A0 =A0 memory@40000000 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x10000>; =A0 =A0 // =
32KiB internal SRAM
>>> + =A0 =A0 =A0 };
>>
>> Oh.... this is the small SRAM. =A0yeah, you should move this under the
>> appropriate bridge node, remove the device_type property, and add a
>> compatible property. =A0Memory nodes at the root like this are used to
>> describe what is basically main memory (what Linux will execute out
>> of). =A0You'll want a new memory node for the external ram hooked up to
>> the 5554.
>
> Yes, it is the small one (actually 64KiB, I corrected the comment also).
> I added the external memory of the MPC5554DEMO evaluation board which has
> a size of 512KiB.

Yikes.  Half a meg is tiny for running Linux.

> Would it be possible to program the uncompressed kernel to the FLASH so
> it can run directly from there? I guess for the code and the constant sec=
tions
> the FLASH could be a good place. Then cstart has to initialize the initia=
lized
> variables by copying data from FLASH to RAM and fill the BSS area with ze=
ro.

Hmmm.  I don't know if anyone has kernel execute in place (XIP)
working on PowerPC.

>
> [...]
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 siu@3f89000 { =A0 =A0 =A0=
 =A0 =A0 // System Integration Unit
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "fsl,mpc5554-siu";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x03f90000 0x4000>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt=
s =3D <45 1 =A0 =A0 =A0// External Interrupt Overrun 0-15
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 46 1 =A0 =A0 =A0// External Interrupt 0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 47 1 =A0 =A0 =A0// External Interrupt 1
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 48 1 =A0 =A0 =A0// External Interrupt 2
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 49 1 =A0 =A0 =A0// External Interrupt 3
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 50 1>; =A0 =A0// External Interrupt 4-15
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> This doesn't look quite right.... /me goes to look at the 5554
>> reference manual....
>>
>> Okay, so all the external IRQs go through the SIU then, even though
>> the first 4 get passed straight through to the intc? =A0And I see that
>> all the level/edge sensing and masking/acknowledging is done at the
>> SIU level, not the intc level, correct? =A0So, what you effectively have
>> is the SIU is *another* interrupt controller that is cascaded to the
>> intc. =A0Therefore you need to add the following to this node:
>>
>> #interrupt-cells =3D <2>; =A0 // cell1:extirq#, cell2:level/edge flags
>> interrupt-controller;
>>
>> Also give the node a label so that nodes for external devices can
>> reference it for hooking up external irqs by overriding the top-level
>> interrupt-parent property.
>>
>> Also, it would appear that intc interrupts don't have any level/edge
>> configuration associated with them. =A0They are either asserted, or they
>> are not, correct? =A0At the moment you're specifying every intc
>> interrupt with 2 cells, and the 2nd cell is always '1'. =A0I think you
>> can change #interrupt-cells to <1> in the intc node and drop the '1'
>> everywhere.
>>
>> When you write your intc driver, you'll also need to write the
>> cascaded driver for the external IRQs.
>
> I tried to solve this point but I'm not quite sure whether the SIU interr=
upt
> numbers shall be kept on the siu@3f89000 node or not.

Yes, you'll want the irq numbers to remain in the siu node because
those are the 'cascade' irqs that the siu raises when the external
irqs are asserted.

>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 emios@3fa0000 { =A0 =A0 =
=A0 =A0 // Modular Timer System
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "fsl,mpc5554-emios";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x03fa0000 0x4000>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt=
s =3D <51 1 =A0 =A0 =A0// Channel 0
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 52 1 =A0 =A0 =A0// Channel 1
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 53 1 =A0 =A0 =A0// Channel 2
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 54 1 =A0 =A0 =A0// Channel 3
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 55 1 =A0 =A0 =A0// Channel 4
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 56 1 =A0 =A0 =A0// Channel 5
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 57 1 =A0 =A0 =A0// Channel 6
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 58 1 =A0 =A0 =A0// Channel 7
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 59 1 =A0 =A0 =A0// Channel 8
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 60 1 =A0 =A0 =A0// Channel 9
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 61 1 =A0 =A0 =A0// Channel 10
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 62 1 =A0 =A0 =A0// Channel 11
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 63 1 =A0 =A0 =A0// Channel 12
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 64 1 =A0 =A0 =A0// Channel 13
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 65 1 =A0 =A0 =A0// Channel 14
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 66 1 =A0 =A0 =A0// Channel 15
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 202 1 =A0 =A0 // Channel 16
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 203 1 =A0 =A0 // Channel 17
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 204 1 =A0 =A0 // Channel 18
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 205 1 =A0 =A0 // Channel 19
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 206 1 =A0 =A0 // Channel 20
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 207 1 =A0 =A0 // Channel 21
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 208 1 =A0 =A0 // Channel 22
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 209 1>; =A0 // Channel 23
>>
>> These long lists bother me, but looking at the manual they seem to
>> describe the actual hardware architecture, so I think they are
>> probably fine. =A0But you may want to compact your formatting somewhat.
>> You can probably list more than one channel per
>> source line in the file.
>>
>> Ditto through the rest of the file.
>
> I would keep the list like this because in this case it is easy to find
> which comment belongs to which interrupt number. Otherwise one would need
> to count the interrupt numbers and the comment to find out which number m=
atch
> which comment.

You could do it in this style to keep the verbosity down:

      interrupts =3D <51 52 53 54 55 56 57 58  // Channels 0-7
                    59 60 61 62 63 64 65 66  // Channels 8-15
                    202 203 204 205 206 207 208 209>;  // Channel 16-23

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
