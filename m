Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 9D242B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 02:41:38 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl_soc: Search all global-utilities nodes for
	rstccr
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTimYz6v2tMJRYnki9Ph33HL9yGsOcpgJ78LTDCTG@mail.gmail.com>
Date: Tue, 31 Aug 2010 11:26:19 -0500
Message-ID: <09C49916-9A20-41CD-A7BA-2F467BFD24DA@freescale.com>
References: <1282946147-28164-1-git-send-email-msm@freescale.com>
	<AANLkTimYz6v2tMJRYnki9Ph33HL9yGsOcpgJ78LTDCTG@mail.gmail.com>
To: Timur Tabi <timur.tabi@gmail.com>
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 28, 2010, at 5:34 PM, Timur Tabi wrote:

>> <msm@freescale.com> wrote:
>=20
>> +
>> +       for_each_node_by_name(np, "global-utilities") {
>> +               if ((of_get_property(np, "fsl,has-rstcr", NULL))) {
>> +                       rstcr =3D of_iomap(np, 0) + 0xb0;
>> +                       if (!rstcr)
>> +                               printk (KERN_EMERG "Error: reset =
control "
>=20
> I'm not sure KERN_EMERG is warranted for this kind of error.

I'm not sure either - I left it as it was before.

>=20
>> +                                               "register not =
mapped!\n");
>> +               }
>=20
> So if a node has an fsl,rstcr property, but the of_iomap() fails, we
> jump to the next global-utilities node?  Perhaps you need a 'break'
> after the printk()?

Or potentially a continue to be more robust? Or would two (or more) =
"has-rstcr" nodes be wrong?

>=20
>> +       }
>> +
>> +       if (!rstcr && ppc_md.restart =3D=3D fsl_rstcr_restart)
>=20
> Wouldn't it make more sense to assign fsl_rstcr_restart to
> ppc_md.restart only if we find a valid fsl,has-rstcr property?

Again I'm not entirely sure, I left this as it was before. Is there =
another way to reset the board if the rstcr node was not found =
correctly?

-M

>=20
> --=20
> Timur Tabi
> Linux kernel developer at Freescale
>=20
