Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 65453B7B92
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 00:57:30 +1100 (EST)
Received: by yxe8 with SMTP id 8so5568978yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Oct 2009 06:57:29 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091007094936.GE3177@pengutronix.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
	<fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
	<4AC9A463.1080903@denx.de> <20091005095340.GA3890@pengutronix.de>
	<4AC9C6AA.6060009@denx.de>
	<fa686aa40910050646p168c2bbfi4b432778827102c9@mail.gmail.com>
	<4ACC37E5.4040804@denx.de> <20091007094936.GE3177@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 7 Oct 2009 07:57:09 -0600
Message-ID: <fa686aa40910070657o2b68156dq25cb44d6d6509abc@mail.gmail.com>
Subject: Re: [PATCH v3] mpc5200: support for the MAN mpc5200 based board
	mucmc52
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 7, 2009 at 3:49 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Wed, Oct 07, 2009 at 08:40:37AM +0200, Heiko Schocher wrote:
>> - serial Console on PSC1
>> - 64MB SDRAM
>> - MTD CFI Flash
>> - Ethernet FEC
>> - IDE support
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>
> Sorry for finding things incrementally, but I think there is still one is=
sue
> left. Once this is sorted out, you could add my:
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
[...]
>> + =A0 =A0 soc5200@f0000000 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200-immr",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,mpc5200b-=
immr";
>
> You should decide on the latter one only here.

Besides, the order is wrong.  The exact version (mpc5200b) always
appears before the list of backward compatible values (the non-'b'
version).  But Wolfram is right.  The IMMR node of the mpc5200b is
*not* wholly backwards compatible with fsl,mpc5200-immr, so
'fsl,mpc5200-immr' should not be in the list.  fsl,mpc5200-<blah> only
appears in the child nodes when the specific device truly is backwards
compatible.  Compare your .dts file line-for-line with one of the
in-tree mpc5200b .dts files.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
