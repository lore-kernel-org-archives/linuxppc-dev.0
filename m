Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <F9CD495E-12BF-467D-BE96-CC11486F70B8@kernel.crashing.org>
References: <1307501379-3160-1-git-send-email-prabhakar@freescale.com>
	<F9CD495E-12BF-467D-BE96-CC11486F70B8@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Jun 2011 10:34:34 -0600
Message-ID: <BANLkTi=zjnaFWbSAxj0Cr3_FpGxNcqvQ9Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx:DTS: Fix tbi node location for Px020RDB
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: meet2prabhu@gmail.com, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 5:34 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Jun 7, 2011, at 9:49 PM, Prabhakar Kushwaha wrote:
>
>> ten-bit interface (TBI) module is part of SoC not board.
>>
>> Move tbi entries from board related dts files to Si dts.
>>
>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
>> ---
>> Based upon http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.=
git (branch next)
>>
>> arch/powerpc/boot/dts/p1020rdb.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 ---=
------
>> arch/powerpc/boot/dts/p1020rdb_camp_core0.dts | =A0 =A08 --------
>> arch/powerpc/boot/dts/p1020si.dtsi =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++=
++-
>> arch/powerpc/boot/dts/p2020rdb.dts =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 ---=
-----
>> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts | =A0 =A08 --------
>> arch/powerpc/boot/dts/p2020si.dtsi =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++=
++-
>> 6 files changed, 10 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/=
p1020rdb.dts
>> index d6a8ae4..a4e5d6c 100644
>> --- a/arch/powerpc/boot/dts/p1020rdb.dts
>> +++ b/arch/powerpc/boot/dts/p1020rdb.dts
>> @@ -211,14 +211,6 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 mdio@25000 {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tbi0: tbi-phy@11 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11>=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =
=3D "tbi-phy";
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> - =A0 =A0 =A0 =A0 =A0 =A0 };
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enet0: ethernet@b0000 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fixed-link =3D <1 1 1000 0 0=
>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-connection-type =3D "rgm=
ii-id";
>> @@ -227,7 +219,6 @@
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enet1: ethernet@b1000 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-handle =3D <&phy0>;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tbi-handle =3D <&tbi0>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-connection-type =3D "sgm=
ii";
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> I'm not sure we should do this. =A0The phy address we pick is board speci=
fic so it should NOT be in .dtsi

Ah, okay.  I was under the impression that the tbi address was
internal to the SoC, and not configurable.

g.
