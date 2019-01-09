Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7348C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA635206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 19:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA635206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZfLp2RRBzDqR0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 06:28:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.60.248; helo=9.mo7.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 6598 seconds by postgrey-1.36 at bilbo;
 Thu, 10 Jan 2019 06:21:46 AEDT
Received: from 9.mo7.mail-out.ovh.net (9.mo7.mail-out.ovh.net [46.105.60.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZfBf4JDDzDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 06:21:44 +1100 (AEDT)
Received: from player687.ha.ovh.net (unknown [10.109.159.159])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 28BDAF3252
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 17:56:32 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 4DB35175C662;
 Wed,  9 Jan 2019 16:56:27 +0000 (UTC)
Date: Wed, 9 Jan 2019 17:56:22 +0100
From: Greg Kurz <groug@kaod.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
Message-ID: <20190109175622.75525ff8@bahia.lan>
In-Reply-To: <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
 <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2864289366970374501
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrfedugdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 9 Jan 2019 17:45:53 +0100
Frederic Barrat <fbarrat@linux.ibm.com> wrote:

> Le 09/01/2019 =C3=A0 17:25, Greg Kurz a =C3=A9crit=C2=A0:
> > On Wed,  9 Jan 2019 16:13:42 +0100
> > Frederic Barrat <fbarrat@linux.ibm.com> wrote:
> >  =20
> >> With a recent change around IOMMU group, a system with an opencapi
> >> adapter is no longer booting and we get a kernel oops:
> >>
> >> BUG: Kernel NULL pointer dereference at 0x00000028
> >> Faulting instruction address: 0xc0000000000aa38c
> >> Oops: Kernel access of bad area, sig: 7 [#1]
> >> LE SMP NR_CPUS=3D2048 NUMA PowerNV
> >> Modules linked in:
> >> CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e94=
bec12
> >> NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
> >> REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001-=
g3bd6
> >> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  XE=
R: 20
> >> CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK: 0
> >> GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf76=
1860
> >> GPR04: 0000000000000000 c000000005783834 0000000000000000 000000000000=
0000
> >> GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 900000000200=
1003
> >> GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 000000000000=
0000
> >> GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000a=
0000
> >> GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000ce=
d978
> >> GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 000000000000=
0000
> >> GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf76=
1860
> >> NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
> >> LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
> >> Call Trace:
> >> [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0x=
60/0x
> >> [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
> >> [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0x=
31c
> >> [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
> >> [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
> >> [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
> >> [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
> >> [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
> >>
> >> An opencapi device is using a device PE, so the current code breaks
> >> because pe->pbus is not defined.
> >>
> >> More generally, there's no need to define an IOMMU group for opencapi,
> >> as the device sends real addresses directly (admittedly, the
> >> virtualization story is yet to be written). So let's fix it by =20
> >=20
> > Current plan is to go for mediated VFIO. The real HW stays under the co=
ntrol
> > of the host ocxl driver, and we still don't need an IOMMU group.
> >  =20
> >> skipping the IOMMU group setup for opencapi PHBs.
> >>
> >> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> >> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> >> --- =20
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > and
> >=20
> > Cc: stable@vger.kernel.org      # v4.20 =20
>=20
> Thanks for the review! But why did you add stable? that problem is only=20
> seen on 5.0-rc1, isn't it?
>=20

Based on the fact that 0bd971676e68 was committed in 4.20... but I haven't
tested :)

>    Fred
>=20
>=20
> >>   arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/=
platforms/powernv/pci-ioda.c
> >> index 1d6406a051f1..7db3119f8a5b 100644
> >> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> @@ -2681,7 +2681,8 @@ static void pnv_pci_ioda_setup_iommu_api(void)
> >>   	list_for_each_entry(hose, &hose_list, list_node) {
> >>   		phb =3D hose->private_data;
> >>  =20
> >> -		if (phb->type =3D=3D PNV_PHB_NPU_NVLINK)
> >> +		if (phb->type =3D=3D PNV_PHB_NPU_NVLINK ||
> >> +		    phb->type =3D=3D PNV_PHB_NPU_OCAPI)
> >>   			continue;
> >>  =20
> >>   		list_for_each_entry(pe, &phb->ioda.pe_list, list) { =20
> >  =20
>=20

