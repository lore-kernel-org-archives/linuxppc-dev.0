Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id CFA9AB7D18
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 02:45:37 +1100 (EST)
Received: by iwn2 with SMTP id 2so4718226iwn.10
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 07:45:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <260b8801-53bd-44fe-a6b8-7d1d0f56fef5@SG2EHSMHS011.ehs.local>
References: <1265409646-11882-1-git-send-email-john.linn@xilinx.com>
	<260b8801-53bd-44fe-a6b8-7d1d0f56fef5@SG2EHSMHS011.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 08:45:15 -0700
Message-ID: <fa686aa41002090745x19d569acx3b50e8078ebb16f7@mail.gmail.com>
Subject: Re: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, jgarzik@pobox.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 8, 2010 at 7:09 AM, John Linn <John.Linn@xilinx.com> wrote:
>> -----Original Message-----
>> From: John Linn [mailto:john.linn@xilinx.com]
>> Sent: Friday, February 05, 2010 3:41 PM
>> To: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
> jgarzik@pobox.com; grant.likely@secretlab.ca;
>> jwboyer@linux.vnet.ibm.com
>> Cc: john.williams@petalogix.com; John Linn; Sadanand Mutyala
>> Subject: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
>>
>> These changes add MDIO and phy lib support to the driver as the
>> IP core now supports the MDIO bus.
>>
>> The MDIO bus and phy are added as a child to the emaclite in the
> device
>> tree as illustrated below.
>>
>> mdio {
>> =A0 =A0 =A0 #address-cells =3D <1>;
>> =A0 =A0 =A0 #size-cells =3D <0>;
>> =A0 =A0 =A0 compatible =3D "xlnx,emaclite-mdio";
>> =A0 =A0 =A0 phy0: phy@7 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <7>;
>> =A0 =A0 =A0 } ;
>> }

You misunderstood me about the compatible property.  You don't need a
compatible prop in the mdio node because it is *alwasy* a child of the
emaclite node, and the emaclite driver knows to go looking for it (ie.
it is a part of the device).

What I want to see is a compatible value in the phy@7 node for the
make & model of the phy.

Otherwise, looks good to me.  Fix the mutex timeout problem and then
you can add my acked-by line to the patch.

Cheers,
g.
