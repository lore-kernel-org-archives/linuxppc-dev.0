Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 50A25DDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:37:39 +1000 (EST)
Received: by gxk20 with SMTP id 20so1080112gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 06:37:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090428.021203.74435054.davem@davemloft.net>
References: <20090427153612.5108.10877.stgit@localhost.localdomain>
	<20090427173606.GA10292@ld0162-tx32.am.freescale.net>
	<fa686aa40904271050kb3159cbw52c0c1dba3076f3e@mail.gmail.com>
	<20090428.021203.74435054.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 28 Apr 2009 07:37:16 -0600
Message-ID: <fa686aa40904280637l22da819fw386034bdd93055cf@mail.gmail.com>
Subject: Re: [PATCH] net: Fix ucc_geth.c handling of phy 'interface' property.
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joakim.Tjernlund@transmode.se, linuxppc-dev@ozlabs.org,
	afleming@freescale.com, netdev@vger.kernel.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 3:12 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Mon, 27 Apr 2009 11:50:20 -0600
>
>> On Mon, Apr 27, 2009 at 11:36 AM, Scott Wood <scottwood@freescale.com> w=
rote:
>>> On Mon, Apr 27, 2009 at 09:36:13AM -0600, Grant Likely wrote:
>>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>>
>>>> Previous rework to ucc_geth.c to add of_mdio support (net: Rework
>>>> ucc_geth driver to use of_mdio infrastructure) added a block of
>>>> code which broke older openfirmware device trees which use an
>>>> 'interface' property in the phy node to describe the connection
>>>> between the MAC and the PHY. =A0This patch removes the offending blurb=
.
>>> [snip]
>>>> =A0 =A0 =A0 prop =3D of_get_property(np, "phy-connection-type", NULL);
>>>> =A0 =A0 =A0 if (!prop) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* handle interface property present in ol=
d trees */
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!phy)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>>> -
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(phy, "interface",=
 NULL);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop !=3D NULL) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_interface =3D enet_to_=
phy_interface[*prop];
>>>
>>> The above test only makes a difference when there is no phy node -- so =
I
>>> don't see how it was breaking device trees that had a phy node (with or
>>> without an "interface" property). =A0I can see it breaking fixed link
>>> device trees, though.
>>
>> Sorry, you're right. =A0I got myself confused when I was writing the
>> description. =A0This patch fixes breakage when using a fixed-link and
>> there is no phy-connection-type property.
>
> Patch applied with commit message fixed up.

Thanks David

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
