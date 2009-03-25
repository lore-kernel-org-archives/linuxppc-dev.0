Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <200903251035.28074.sr@denx.de>
References: <200903231151.10373.sr@denx.de> <200903241639.56637.sr@denx.de>
	<fa686aa40903240928t2a3fcccdrb4508e34c7079aef@mail.gmail.com>
	<200903251035.28074.sr@denx.de>
Date: Wed, 25 Mar 2009 07:28:58 -0600
Message-ID: <fa686aa40903250628t1e5e97c0q340746dd78e61c83@mail.gmail.com>
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

On Wed, Mar 25, 2009 at 3:35 AM, Stefan Roese <sr@denx.de> wrote:
> On Tuesday 24 March 2009, Grant Likely wrote:
>> > OK, in the example above such a spanning partition is not so likely. B=
ut
>> > think about my original example, the Intel P30 with two different cfi
>> > compatible chips on one die. Here a partition spanning over both devic=
es
>> > is very likely.
>>
>> I agree. =A0Same thing when two or more flash chips are put on a board
>> in consecutive addresses. =A0I've worked on plenty of these arrangements
>> myself.
>
> Yes, multiple identical devices are no problem at all. This is handled
> correctly with the current code and device tree syntax.
>
>> This case really does sound like a driver bug and that the existing
>> cfi-flash binding is sufficient to describe the hardware. =A0IIUC, when
>> all the flash chips are of the same type the physmap_of driver should
>> be smart enough to detect each of the flash chips within the reg
>> range.
>
> *When* all are identical then this works, yes. But in the Intel P30 case =
the 2
> chips are not identical. And from my understanding this is not a problem/=
bug
> in the physmap_of driver.

To satisfy my own curiosity, why is physmap_of unable to probe
multiple cfi chips that are non identical?  After detecting the first
chip it and calculated then end address of it can it not do another
full cfi probe for the rest of the reg range?

Regardless, even if it could the solution you have below is probably a
better idea anyway than relying on probing.

>> If I'm wrong and it cannot do this, then it would be a simple matter
>> of adding an additional tuple to reg for each discrete chip. =A0A
>> simple, backwards compatible extension which doesn't require a new
>> binding.
>
> So you are thinking of something like this?
>
> =A0 =A0 =A0 =A0flash@f0000000,0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "cfi-flash";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x00000000 0x02000000
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 0x02000000 0x02000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank-width =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device-width =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0partition@0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0label =3D "test-part1";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0x04000000>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0};

Yes, this looks good to me.  In fact, it is probably better to be
explicit about multiple chips anyway in terms of providing the driver
as much information as possible about where to probe for the chips.
It also elegantly supports sparsely mapped flash chips (ie. if the
board supports larger chips than is actually populated).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
