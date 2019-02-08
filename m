Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE94C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:32:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7142147C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QbGVUgJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7142147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wljW2MxrzDqWX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 17:32:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wk434mylzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="QbGVUgJ8"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43wk431ydRz9sNt; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549603123;
 bh=2g8VeUAwhBa2PsJhPDGmFqtuQszAc8nUZGLah+xvbi4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QbGVUgJ8YuJHTnDI3BKK7T7aUikmHh5VVb1t5lr8uf2J4NuYzr75FhCxHwXvHVJYI
 movxd0IeO1x9sINMc92e+W4MFNSZVT5TDR2B2rt9jNl0LizsR+vf8nJ8jrEmnKRgxb
 Nm3c8rPjrqVP8KyNlGUxi5KRkYvU8+p20urCbL2w=
Date: Fri, 8 Feb 2019 16:15:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
Message-ID: <20190208051543.GE2688@umbus.fritz.box>
References: <20190107184331.8429-16-clg@kaod.org>
 <20190204052148.GH1927@umbus.fritz.box>
 <02ee0470-3c6a-5c5c-a903-44e172ce1ed5@kaod.org>
 <20190205053233.GG22661@umbus.fritz.box>
 <c0faf4dd-7af1-d97a-f8f1-838fcf412ab8@kaod.org>
 <20190206012329.GQ22661@umbus.fritz.box>
 <20190206012447.GR22661@umbus.fritz.box>
 <1d92005a-c12d-1a55-d01b-98eded13629c@kaod.org>
 <20190207024855.GZ22661@umbus.fritz.box>
 <9f03f232-1c47-6e27-6d79-3bcc900fe943@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <9f03f232-1c47-6e27-6d79-3bcc900fe943@kaod.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 10:13:48AM +0100, C=E9dric Le Goater wrote:
> On 2/7/19 3:48 AM, David Gibson wrote:
> > On Wed, Feb 06, 2019 at 08:07:36AM +0100, C=E9dric Le Goater wrote:
> >> On 2/6/19 2:24 AM, David Gibson wrote:
> >>> On Wed, Feb 06, 2019 at 12:23:29PM +1100, David Gibson wrote:
> >>>> On Tue, Feb 05, 2019 at 02:03:11PM +0100, C=E9dric Le Goater wrote:
> >>>>> On 2/5/19 6:32 AM, David Gibson wrote:
> >>>>>> On Mon, Feb 04, 2019 at 05:07:28PM +0100, C=E9dric Le Goater wrote:
> >>>>>>> On 2/4/19 6:21 AM, David Gibson wrote:
> >>>>>>>> On Mon, Jan 07, 2019 at 07:43:27PM +0100, C=E9dric Le Goater wro=
te:
> >>>>>>>>> Theses are use to capure the XIVE EAS table of the KVM device, =
the
> >>>>>>>>> configuration of the source targets.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>>>> ---
> >>>>>>>>>  arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
> >>>>>>>>>  arch/powerpc/kvm/book3s_xive_native.c | 87 +++++++++++++++++++=
++++++++
> >>>>>>>>>  2 files changed, 98 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc=
/include/uapi/asm/kvm.h
> >>>>>>>>> index 1a8740629acf..faf024f39858 100644
> >>>>>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>>>>> @@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
> >>>>>>>>>  #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
> >>>>>>>>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes=
 */
> >>>>>>>>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
> >>>>>>>>> +#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
> >>>>>>>>> =20
> >>>>>>>>>  /* Layout of 64-bit XIVE source attribute values */
> >>>>>>>>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> >>>>>>>>>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> >>>>>>>>> =20
> >>>>>>>>> +/* Layout of 64-bit eas attribute values */
> >>>>>>>>> +#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
> >>>>>>>>> +#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
> >>>>>>>>> +#define KVM_XIVE_EAS_SERVER_SHIFT	3
> >>>>>>>>> +#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
> >>>>>>>>> +#define KVM_XIVE_EAS_MASK_SHIFT		32
> >>>>>>>>> +#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
> >>>>>>>>> +#define KVM_XIVE_EAS_EISN_SHIFT		33
> >>>>>>>>> +#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
> >>>>>>>>> +
> >>>>>>>>>  #endif /* __LINUX_KVM_POWERPC_H */
> >>>>>>>>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/power=
pc/kvm/book3s_xive_native.c
> >>>>>>>>> index f2de1bcf3b35..0468b605baa7 100644
> >>>>>>>>> --- a/arch/powerpc/kvm/book3s_xive_native.c
> >>>>>>>>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> >>>>>>>>> @@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct =
kvmppc_xive *xive, long irq, u64 addr)
> >>>>>>>>>  	return 0;
> >>>>>>>>>  }
> >>>>>>>>> =20
> >>>>>>>>> +static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive=
, long irq,
> >>>>>>>>> +				      u64 addr)
> >>>>>>>>
> >>>>>>>> I'd prefer to avoid the name "EAS" here.  IIUC these aren't "raw=
" EAS
> >>>>>>>> values, but rather essentially the "source config" in the termin=
ology
> >>>>>>>> of the PAPR hcalls.  Which, yes, is basically implemented by set=
ting
> >>>>>>>> the EAS, but since it's the PAPR architected state that we need =
to
> >>>>>>>> preserve across migration, I'd prefer to stick as close as we ca=
n to
> >>>>>>>> the PAPR terminology.
> >>>>>>>
> >>>>>>> But we don't have an equivalent name in the PAPR specs for the tu=
ple=20
> >>>>>>> (prio, server). We could use the generic 'target' name may be ? e=
ven=20
> >>>>>>> if this is usually referring to a CPU number.
> >>>>>>
> >>>>>> Um.. what?  That's about terminology for one of the fields in this
> >>>>>> thing, not about the name for the thing itself.
> >>>>>>
> >>>>>>> Or, IVE (Interrupt Vector Entry) ? which makes some sense.=20
> >>>>>>> This is was the former name in HW. I think we recycle it for KVM.
> >>>>>>
> >>>>>> That's a terrible idea, which will make a confusing situation even
> >>>>>> more confusing.
> >>>>>
> >>>>> Let's use SOURCE_CONFIG and QUEUE_CONFIG. The KVM ioctls are very=
=20
> >>>>> similar to the hcalls anyhow.
> >>>>
> >>>> Yes, I think that's a good idea.
> >>>
> >>> Actually... AIUI the SET_CONFIG hcalls shouldn't be a fast path. =20
> >>
> >> No indeed. I have move them to standard hcalls in the current version.
> >>
> >>> Can
> >>> we simplify things further by removing the hcall implementation from
> >>> the kernel entirely, and have qemu implement them by basically just
> >>> forwarding them to the appropriate SET_CONFIG ioctl()?
> >>
> >> Yes. I think we could.=20
> >=20
> > Great!
> >=20
> >> The hcalls H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG and=20
> >> the KVM ioctls to set the EQ and the SOURCE configuration have a=20
> >> lot in common. I need to look at how we can plug the KVM ioctl in=20
> >> the hcalls under QEMU.
> >>
> >> We will have to convert the returned error to respect the PAPR=20
> >> specs or have the ioctls return H_* errors.
> >=20
> > I don't think returning H_* values from a kernel call is a good idea.
> > Converting errors is kinda ugly, but I still think it's the better
> > option.  Note that we already have something like this for the HPT
> > resizing hcalls.
>=20
> ok.
> =20
> >> Let's dig that idea. If we choose that path, QEMU will have an=20
> >> up-to-date EAT and so we won't need to synchronize its state anymore=
=20
> >> for migration.
> >=20
> > I guess so, though I don't see that as essential.
> >=20
> >> H_INT_GET_SOURCE_CONFIG can be implemented in QEMU without any KVM=20
> >> ioctl.
> >>
> >> H_INT_GET_QUEUE_INFO could be implemented in QEMU. I need to check=20
> >> how we return the address of the END ESB in sPAPR. We haven't paid=20
> >> much attention to these pages because they are not used under Linux
> >> and today the address is returned by OPAL.=20
> >>
> >> H_INT_GET_QUEUE_CONFIG is a little more problematic because we need
> >> to query into the XIVE HW the EQ index and toggle bit. OPAL support
> >> is required for that. But we could reduce the KVM support to the=20
> >> ioctl querying these EQ information.
> >=20
> > Right, and we'd need an ioctl() like that for migration anyway, yes?
>=20
> Yes. it is the same need.
>=20
> >> H_INT_ESB could be entirely done under QEMU.
> >=20
> > This one can actually happen on fairly hot paths, so I think doing
> > that in qemu probably isn't a good idea.
>=20
> I agree It would nice to have some performance.
>=20
> This hcall is used when LSIs are involved, which is not really a common=
=20
> configuration. There are no OPAL calls involved. And we are duplicating=
=20
> code at the KVM level to retrigger the interrupt when the level is still
> asserted.
>=20
> I will benchmark the two options before making a choice.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdEH8ACgkQbDjKyiDZ
s5JKqhAAo89t3ucpN6FeXT1ReGW5kW+HnOIlN4OHOCKmjpf/aMWjcfNHZKrcx4+t
Ess7XqbJ5593yrWVekmCivoNKRLNhyscf96kbtFhsTK+T23XtNCcIt0m6YeMRmfj
5z47lPRYvVdAL4PHmWmTCcZA/WuSTSkDPdWROoilub9aB1bOV856yfYO7+L7z280
KbB4uzq2ZWXHMROtC2AN2ejHu2sScmFuFwm/MMTgkXI4rotd1TiuxUHhjn4721gT
nh8e2b0lD+IERX+2PWiR3m8K4r+5HRr3QZVua3HRF4R95d1mogZWYjh3y4Bct8gx
HbGlHsSLKn61OX7hZ8s29wNJEb6qMwZUJ2sEu7QbFL5t80hQNaE3sZLhr63USyl8
Jsx5uVqO2jRnhHsS0dGbIdT7MjIypJVQmeylFfwRwxXx6NcgQg1fHYZud0jUFM5I
Rc4EWQ46UIa0y1IaR9gTJDHXVcghKis5b/HsAgAQqqryP030FjagcAXyZpSxJSAu
9cCCHSh+qU5eFw768ZNHF3JtdnehSLRKU8VlTPd9qkwawN8rxBCDQyOZGuB1ao/h
lj+chyWNxF18ozoK+1TXGw0J84CiXrYu3xiPss1NZJ+GUd/j8abNiCtoVpvhGQaC
vHlQZR7yyvGuTQz84Lr4Q8w0HnmTog4U2WrVyRutkW5KB/OcDdU=
=KY8F
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
