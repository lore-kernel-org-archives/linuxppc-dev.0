Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <200903241007.51321.sr@denx.de>
References: <200903231151.10373.sr@denx.de>
	<fa686aa40903230837w52a9f764n29b3f9cf4c95cc57@mail.gmail.com>
	<200903241007.51321.sr@denx.de>
Date: Tue, 24 Mar 2009 08:57:57 -0600
Message-ID: <fa686aa40903240757n569f2b04t1309e817fd30728d@mail.gmail.com>
Subject: Re: physmap_of and partitions (mtd concat support)
From: Grant Likely <grant.likely@secretlab.ca>
To: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2009 at 3:07 AM, Stefan Roese <sr@denx.de> wrote:
> On Monday 23 March 2009, Grant Likely wrote:
>> On Mon, Mar 23, 2009 at 4:51 AM, Stefan Roese <sr@denx.de> wrote:
>> > I just noticed that physmap_of can't handle multiple devices of differ=
ent
>> > type described in one device node. For example the Intel P30 48F4400
>> > (64MByte) consists internally of 2 non-identical NOR chips. So a "simp=
le"
>>
>> [...]
>>
>> > Now the real problem: How should I describe a partition in the device
>> > tree spanning over both devices (concat)?. The current physmap_of driv=
er
>> > doesn't handle concat at all (physmap.c does). I already have some ide=
as
>> > on how to implement this concat support in physmap_of. But ideas about=
 a
>> > device-tree syntax for such partitions are very welcome.
>>
>> Sounds to me like a physmap_of driver bug. =A0I don't think there is any
>> advantage in changing the partition syntax since concatenated flash
>> will always be used as a single device. =A0It doesn't make any sense to
>> try and span partitions over two nodes.
>
> Yes, I would really love to make this possible with only one flash node. =
But
> just think about the following system configuration:
>
> One Intel Strataflash (compatible =3D "cfi-flash") and one non-cfi compat=
ible
> flash (e.g. compatible =3D "jedec-flash"). And the user wants to define a
> partition that spans over both flash chips. How could this be described i=
n
> one flash node?
>
>> Do additional properties need to be added to describe the concat layout?
>
> Not sure. If we have multiple identical devices they can currently be
> described in one flash node. So with some changes to the physmap_of drive=
r
> this configuration will work with concat as well. But more complex is a
> system configuration as described above. Meaning two or more non-identica=
l
> chips. I don't see how this could be described in a sane way in one flash
> node.

Are there any such platforms?  Is there much likelihood that such a
platform will be created?  Would it even be a good idea to span
partitions across such an arrangement given that different devices
will behave differently?

I think just leave that arrangement as hypothetical until the
situation actually occurs.  If it does occur, then strongly recommend
to not span a partition across the boundary.  If someone really
insists on doing this then we can create a new binding for the
purpose; but leave the old binding as is.  Maybe something like:

mtd {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        compatibly =3D "weird-mtd-concat";
        devices =3D <&mtd1 &mtd2 &mtd3>;
        partition1@0 {
                reg =3D <0 0x100000>;
        };
        partition2@100000 {
                reg =3D <0x100000 0x100000>;
        };
}

Where mtd1, 2 & 3 point to real flash nodes.  That way the
concatenated MTD devices could be anything NAND, NOR, SRAM, whatever
and it doesn't have to try and overload the existing device bindings.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
