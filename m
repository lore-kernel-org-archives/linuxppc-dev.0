Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E845BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:29:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC81214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 12:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC81214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b4zt48VKzDqg4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 23:28:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b4vd1t9rzDqXb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 23:25:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43b4vc5SSyz9sN8;
 Thu, 10 Jan 2019 23:25:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <groug@kaod.org>, Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/npu: Fix oops in
 pnv_try_setup_npu_table_group()
In-Reply-To: <20190109175622.75525ff8@bahia.lan>
References: <20190109151342.19953-1-fbarrat@linux.ibm.com>
 <20190109172529.10c45ce6@bahia.lan>
 <41fc8267-7a40-a3e0-df39-773771b661d2@linux.ibm.com>
 <20190109175622.75525ff8@bahia.lan>
Date: Thu, 10 Jan 2019 23:25:11 +1100
Message-ID: <87h8egsnrs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com,
 stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg Kurz <groug@kaod.org> writes:
> On Wed, 9 Jan 2019 17:45:53 +0100
> Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>
>> Le 09/01/2019 =C3=A0 17:25, Greg Kurz a =C3=A9crit=C2=A0:
>> > On Wed,  9 Jan 2019 16:13:42 +0100
>> > Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>> >=20=20=20
>> >> With a recent change around IOMMU group, a system with an opencapi
>> >> adapter is no longer booting and we get a kernel oops:
>> >>
>> >> BUG: Kernel NULL pointer dereference at 0x00000028
>> >> Faulting instruction address: 0xc0000000000aa38c
>> >> Oops: Kernel access of bad area, sig: 7 [#1]
>> >> LE SMP NR_CPUS=3D2048 NUMA PowerNV
>> >> Modules linked in:
>> >> CPU: 5 PID: 1 Comm: swapper/4 Not tainted 5.0.0-rc1-fxb-00001-g3bd6e9=
4bec12
>> >> NIP:  c0000000000aa38c LR: c0000000000a6608 CTR: c000000000097480
>> >> REGS: c000000005783700 TRAP: 0300   Not tainted  (5.0.0-rc1-fxb-00001=
-g3bd6
>> >> MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000228  X=
ER: 20
>> >> CFAR: c0000000000a6604 DAR: 0000000000000028 DSISR: 00080000 IRQMASK:=
 0
>> >> GPR00: c0000000000a6608 c000000005783990 c000000001036100 c0000007bf7=
61860
>> >> GPR04: 0000000000000000 c000000005783834 0000000000000000 00000000000=
00000
>> >> GPR08: 69626d2c6e707500 0000000000000000 0000000000000000 90000000020=
01003
>> >> GPR12: 0000000000000000 c0000007bfff8300 c000000000010450 00000000000=
00000
>> >> GPR16: c000000000ced938 0000000000000100 c000000000ced948 00000000000=
a0000
>> >> GPR20: 00000000000bfffe c000000000ced9a8 0000000000000200 c000000000c=
ed978
>> >> GPR24: 00000000006080c0 c000000716d09828 c00000002e6fd000 00000000000=
00000
>> >> GPR28: c0000007bf4aff68 c0000007bf8d0080 c000000000f23938 c0000007bf7=
61860
>> >> NIP [c0000000000aa38c] pnv_try_setup_npu_table_group+0x1c/0x1a0
>> >> LR [c0000000000a6608] pnv_pci_ioda_fixup+0x1f8/0x660
>> >> Call Trace:
>> >> [c000000005783990] [c0000000000aa3d0] pnv_try_setup_npu_table_group+0=
x60/0x
>> >> [c0000000057839d0] [c0000000000a661c] pnv_pci_ioda_fixup+0x20c/0x660
>> >> [c000000005783ab0] [c000000000e1d4c0] pcibios_resource_survey+0x2c8/0=
x31c
>> >> [c000000005783b90] [c000000000e1caf4] pcibios_init+0xb0/0xe4
>> >> [c000000005783c10] [c000000000010054] do_one_initcall+0x64/0x264
>> >> [c000000005783ce0] [c000000000e1132c] kernel_init_freeable+0x36c/0x468
>> >> [c000000005783db0] [c000000000010474] kernel_init+0x2c/0x148
>> >> [c000000005783e20] [c00000000000b794] ret_from_kernel_thread+0x5c/0x68
>> >>
>> >> An opencapi device is using a device PE, so the current code breaks
>> >> because pe->pbus is not defined.
>> >>
>> >> More generally, there's no need to define an IOMMU group for opencapi,
>> >> as the device sends real addresses directly (admittedly, the
>> >> virtualization story is yet to be written). So let's fix it by=20=20
>> >=20
>> > Current plan is to go for mediated VFIO. The real HW stays under the c=
ontrol
>> > of the host ocxl driver, and we still don't need an IOMMU group.
>> >=20=20=20
>> >> skipping the IOMMU group setup for opencapi PHBs.
>> >>
>> >> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
>> >> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> >> ---=20=20
>> >=20
>> > Reviewed-by: Greg Kurz <groug@kaod.org>
>> >=20
>> > and
>> >=20
>> > Cc: stable@vger.kernel.org      # v4.20=20=20
>>=20
>> Thanks for the review! But why did you add stable? that problem is only=
=20
>> seen on 5.0-rc1, isn't it?
>
> Based on the fact that 0bd971676e68 was committed in 4.20... but I haven't
> tested :)

It was committed to a branch based off 4.20-rc2, but it wasn't merged
into the 4.20 release.

  $ git describe --match "v[0-9]*" --contains 0bd971676e68
  v5.0-rc1~137^2~15

So it doesn't need to go to stable.

cheers
