Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49CB31CB.2010704@grandegger.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>
	<1237975701-23201-2-git-send-email-wg@grandegger.com>
	<1237975701-23201-3-git-send-email-wg@grandegger.com>
	<1237975701-23201-4-git-send-email-wg@grandegger.com>
	<fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>
	<49CA9899.30604@grandegger.com>
	<fa686aa40903252209r52a1bc1cn995a7da16bc3527f@mail.gmail.com>
	<49CB31CB.2010704@grandegger.com>
Date: Thu, 26 Mar 2009 08:27:55 -0600
Message-ID: <fa686aa40903260727y3266e394g5e574680fe70bbbf@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2009 at 1:42 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Grant Likely wrote:
>> On Wed, Mar 25, 2009 at 2:48 PM, Wolfgang Grandegger <wg@grandegger.com>=
 wrote:
>>> Grant Likely wrote:
>>>> For the chip offset, it's not clear what the meaning is. =A0First, doe=
s
>>>> the UPM controller support access of multiple chips simultaneously?
>>> The offset drives the corresponding address lines, which are used to
>>> select the chip. That's how it's done on the TQM8548 board. In
>>> principle, the chips could also be selected through dedicated GPIO pins=
.
>>> Well, I'm not a hardware guy.
>>
>> Heh. =A0I mean elaborate in the binding documentation. =A0:-)
>>
>>>> If so, then can you elaborate in the description on how board design
>>>> translates to a chip-offset value. =A0If it cannot, then it might be
>>>> better to have multiple tuples in the 'reg' property for each discrete
>>>> chip. =A0Multiple reg tuples would also remove the need for the
>>>> num-chips property.
>>> The node still describes one device mapping all relevant control
>>> registers. How about using fsl,upm-chip-offsets =3D <0x200 0x400>. It
>>> would be more generic and makes num-chips obsolete as well. And the
>>> property would be reserved for that way of implementing the chip select
>>> in hardware.
>>
>> It really sounds like this binding is describing multiple NAND chips
>> mapped to different base addresses (and looking at the fsm_upm.c
>> driver appears to confirm it). =A0So, does this work? =A0reg =3D <3 0x20=
0 4
>> =A03 0x400 4>;
>
> The chip-offset, and not the address, needs to be added to the MAR
> register as well before running the pattern:
>
> =A0 =A0 =A0 =A0mar =3D cmd << (32 - fun->upm.width);
>
> =A0 =A0 =A0 =A0if (fun->chip_offset && fun->chip_number > 0)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mar |=3D fun->chip_number * fun->chip_offs=
et;
>
> =A0 =A0 =A0 =A0fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
>
>
>> It is true that other methods could be used for implementing the chip
>> select, but that is *not* what the proposed binding describes. =A0This
>> proposed binding describes NAND chips selected by address lines
>> (particular addresses), and in this case I think using reg is the
>> natural description.
>
> OK, the chips are selected by accessing a defined address range. Will
> prepare a patch using the reg property.

Hold on a sec.  I'm debating from my experience with device tree
bindings, but I'm fairly ignorant about the implementation of NAND on
UPM.  It *looks* to me like reg is sufficient, but if I'm wrong then
tell me so and why.  Your comment above about fsl_upm_run_pattern()
makes me doubt my position.

Does using the reg property give the driver enough information to
reliably program the MAR for NAND connections that use the address
line chip select scheme?  Related to that, should the binding include
a property that explicitly states that an address line chip select
scheme is being used?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
