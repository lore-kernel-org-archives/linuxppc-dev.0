Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: physmap_of and partitions (mtd concat support)
Date: Tue, 24 Mar 2009 16:39:56 +0100
References: <200903231151.10373.sr@denx.de> <200903241007.51321.sr@denx.de>
	<fa686aa40903240757n569f2b04t1309e817fd30728d@mail.gmail.com>
In-Reply-To: <fa686aa40903240757n569f2b04t1309e817fd30728d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903241639.56637.sr@denx.de>
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

On Tuesday 24 March 2009, Grant Likely wrote:
> >> Sounds to me like a physmap_of driver bug. =A0I don't think there is a=
ny
> >> advantage in changing the partition syntax since concatenated flash
> >> will always be used as a single device. =A0It doesn't make any sense to
> >> try and span partitions over two nodes.
> >
> > Yes, I would really love to make this possible with only one flash node.
> > But just think about the following system configuration:
> >
> > One Intel Strataflash (compatible =3D "cfi-flash") and one non-cfi
> > compatible flash (e.g. compatible =3D "jedec-flash"). And the user want=
s to
> > define a partition that spans over both flash chips. How could this be
> > described in one flash node?
> >
> >> Do additional properties need to be added to describe the concat layou=
t?
> >
> > Not sure. If we have multiple identical devices they can currently be
> > described in one flash node. So with some changes to the physmap_of
> > driver this configuration will work with concat as well. But more compl=
ex
> > is a system configuration as described above. Meaning two or more
> > non-identical chips. I don't see how this could be described in a sane
> > way in one flash node.
>
> Are there any such platforms?

Yes, I know some. Even though they are currently not used with a partition=
=20
spanning over those multiple chips (jedec and cfi).

> Is there much likelihood that such a=20
> platform will be created?  Would it even be a good idea to span
> partitions across such an arrangement given that different devices
> will behave differently?

OK, in the example above such a spanning partition is not so likely. But th=
ink=20
about my original example, the Intel P30 with two different cfi compatible=
=20
chips on one die. Here a partition spanning over both devices is very likel=
y.

As a sidenote: All this (concat over different chips) is possible with the=
=20
physmap.c mapping driver which was used on most of my platforms in the "old=
"=20
arch/ppc days.

> I think just leave that arrangement as hypothetical until the
> situation actually occurs.  If it does occur, then strongly recommend
> to not span a partition across the boundary.  If someone really
> insists on doing this then we can create a new binding for the
> purpose; but leave the old binding as is.  Maybe something like:
>
> mtd {
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>         compatibly =3D "weird-mtd-concat";
>         devices =3D <&mtd1 &mtd2 &mtd3>;
>         partition1@0 {
>                 reg =3D <0 0x100000>;
>         };
>         partition2@100000 {
>                 reg =3D <0x100000 0x100000>;
>         };
> }
>
> Where mtd1, 2 & 3 point to real flash nodes.  That way the
> concatenated MTD devices could be anything NAND, NOR, SRAM, whatever
> and it doesn't have to try and overload the existing device bindings.

I think I like this idea. If nobody objects or has a better idea then I cou=
ld=20
start implementing it this way in a while.

Thanks.

Best regards,
Stefan
