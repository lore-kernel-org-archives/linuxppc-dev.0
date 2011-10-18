Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B7A0B71BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 22:43:29 +1100 (EST)
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
 (freescale p1010)
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111018094328.GC22814@sgi.com>
Date: Tue, 18 Oct 2011 06:43:13 -0500
Message-Id: <D79CB818-C14E-4C8D-9A8D-42B39ADE20B2@kernel.crashing.org>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
 <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
 <20111018094328.GC22814@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
 socketcan-core@lists.berlios.de, PPC list <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> Robin,
>>=20
>> Do you remember why we went with just 'fsl,p1010-flexcan' as the =
device tree compatible?  Do we feel the flex can on P1010 isn't the same =
as on MPC5xxx? or the ARM SoCs?
>=20
> The decision was due to the fact there is no true "generic" =
fsl.flexcan
> chip free of any SOC implementation and therefore not something which
> could be separately defined.  That decision was made by Grant Likely.
> I will inline that email below.
>=20
> Robin


Thanks, I'll look into this internally at FSL.  I think its confusing as =
hell to have "fsl,p1010-flexcan" in an ARM .dts and don't think any =
reasonable ARM customer of FSL would know to put a PPC SOC name in their =
.dts.  I'll ask the HW guys what's going on so we can come up with a bit =
more generic name so we don't have to constantly change this.  Even if =
its just:

fsl,ppc-flexcan & fsl,arm-flexcan.

> On Mon, Aug 15, 2011 at 09:13:50AM -0600, Grant Likely wrote:
>> On Mon, Aug 15, 2011 at 9:03 AM, Robin Holt <holt@sgi.com> wrote:
>>> Grant,
>>>=20
>>> Earlier, you had asked for a more specific name for the compatible
>>> property of the Freescale flexcan device.  I still have not gotten a
>>> more specific answer.  Hopefully Marc can give you more details =
about
>>> the flexcan implementations.
>>=20
>> If there is no ip core version, then just stick with the
>> fsl,<soc>-flexcan name and drop "fsl,flexcan".  Marketing may say
>> flexcan is flexcan, but hardware engineers like to change things.
>> Trying to be too generic in compatible values will just lead to
>> problems in the future.
>=20
> Thanks,
> Robin

- k=
