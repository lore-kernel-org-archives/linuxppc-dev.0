Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id D6467B6EF2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 03:43:51 +1000 (EST)
Received: by gwj15 with SMTP id 15so905303gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 10:43:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100727192856.63edc8e0@wker>
References: <1272882222-12253-1-git-send-email-agust@denx.de>
	<1279892973-24110-1-git-send-email-agust@denx.de>
	<AANLkTi=Ee6HR+Ux0g4V1+81DXUmsO=UDhi6jWsDgGchv@mail.gmail.com>
	<20100727123647.0a3b8832@wker>
	<AANLkTika=KeKcaY_FF8tN5Fy-H+cozjZsGObXoQhKiVh@mail.gmail.com>
	<20100727192856.63edc8e0@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Jul 2010 11:43:29 -0600
Message-ID: <AANLkTimY+Uq7GEF50Qqus4GrTH8g8w_in99G2raaFVV7@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 27, 2010 at 11:28 AM, Anatolij Gustschin <agust@denx.de> wrote:
> On Tue, 27 Jul 2010 10:58:33 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> ...
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@11900 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,m=
pc5121-psc-spi", "fsl,mpc5121-psc";
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <9>;
>> >>
>> >> Try to drop the cell-index properties. =A0They are almost always misu=
sed.
>> >
>> > Removing cell-index would require changing the spi driver's probe.
>> > Currently cell-index is used to set spi bus number. What could be used
>> > for bus enumeration instead? Is it okay to use part of the spi node
>> > address? e.g. obtaining the offset 0x11900, masking out the unrelated
>> > bits and shifting by 8 would deliver unique index 9 for PSC9 in SPI
>> > mode. This would work for all 12 PSC SPI controllers of mpc5121.
>>
>> Does the spi bus number really matter? =A0The device tree context gives
>> you a firm association between spi masters and devices which doesn't
>> require assigning a specific bus number. =A0The core spi code can
>> dynamically assign a bus number for the bus by setting bus_num to -1.
>
> The bus number is used in the mpc5121 psc spi driver to obtain correct
> clock for PSC in question (0 to 11) and to enable the PSC clock at probe
> time. Therefore using dynamically assigned bus number would require anoth=
er
> change to the spi driver.

That's unrelated to the bus number.  Use cell-index value directly for
obtaining the clock if you need to; but limit its exposure.  Once
Jeremy gets his common clock architecture merged, then we could
probably migrate to that for obtaining the correct clock without
cell-index.

g.
