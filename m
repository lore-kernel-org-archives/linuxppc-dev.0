Return-Path: <linuxppc-dev+bounces-22495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFEECD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:39:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbkK074jlz3br5;
	Thu, 11 Jun 2026 23:39:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781182689;
	cv=none; b=Xq/pUBa5++cYA8H6E3DThJeVC3WMsBVBEYA6TRsskgkMVjtOVxr5iVrcXy/exZhnJhAjhyPsnb3Ng2OXq9v9cuvlgJDhIPqfDxtb6KP41dKZczBcV4hB4svsEKe4Ljtu1n44WKCuw30BTEqlKOgqqeMaJVSn81vmJ/0wD9fueAuMBp62TuhbvlpfJ8t3oz4rYv0zoL1BfH6Kw4lr6UAjEbxhdM+01lFjD9PqgHk28Ma5ftFewxAVVROON3JklWLNJ7bV/eFCOTzz1/XcCEMSm5j+3A8FNYvHiPVTNNuW3mPORGb8V8NeZ09CoGpla3XT/7iuN34AIh2FWhPcj0WytA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781182689; c=relaxed/relaxed;
	bh=wutI1NEOrxe0Ga9sQ5pG620uXi0d0C5Aj7NTI3FNepo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkKHvKlSv0wknjMpG1JNmX0qBPxcFF2lX4p+i8tew2EH4mjV6S7oTty9vJ4SkkGxCqB/dPyV9vU+7FHiSmPxEps8JByoxFbKFK5io9M/0c5bcRBoXOd/64BpnxR+AXXUZ3cYdN7rFu1bBQSldST07YcY2o43J5fN+UDqgVoZTIqxdZmehEuO1NEiX0qw/aiyd+WHFF1mApvIvia7d5PC4GeknFfHKeli1bGx9KcCBH6tyx2O1j4gip6FtHKRnDPIiVVayLTNmNsRCXyGUQ8npO3wAdG12//+nv60//YcJ1orpdlNzY/LY1MpsHcEjzZO1HXGYZDOO0+4ZNni+S4ZLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7EfXrH8; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7EfXrH8; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7EfXrH8;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7EfXrH8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbjPD3Gkfz3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 22:58:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781182681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wutI1NEOrxe0Ga9sQ5pG620uXi0d0C5Aj7NTI3FNepo=;
	b=I7EfXrH8kohE14HB0nZNWq1/JiZfahM+QDz7GcGZsiSFQsf82GNGFHNgPZ0wgONIS+0qln
	4IK10V4m5HXi1IDleMDi9GAie+6oCvy4JqhZ15LiwlPPPP/Cu6TyMKJEq0KnQIqQ+/op51
	aPHWp+f9+JcjUxKvjejYU19YOkKB4Wo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781182681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wutI1NEOrxe0Ga9sQ5pG620uXi0d0C5Aj7NTI3FNepo=;
	b=I7EfXrH8kohE14HB0nZNWq1/JiZfahM+QDz7GcGZsiSFQsf82GNGFHNgPZ0wgONIS+0qln
	4IK10V4m5HXi1IDleMDi9GAie+6oCvy4JqhZ15LiwlPPPP/Cu6TyMKJEq0KnQIqQ+/op51
	aPHWp+f9+JcjUxKvjejYU19YOkKB4Wo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-ljIudu3YMUiI3vj_euAS4A-1; Thu,
 11 Jun 2026 08:57:57 -0400
X-MC-Unique: ljIudu3YMUiI3vj_euAS4A-1
X-Mimecast-MFC-AGG-ID: ljIudu3YMUiI3vj_euAS4A_1781182671
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 193FA18D65C3;
	Thu, 11 Jun 2026 12:57:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 179B1180057F;
	Thu, 11 Jun 2026 12:57:43 +0000 (UTC)
Date: Wed, 10 Jun 2026 11:37:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sumit Saxena <sumit.saxena@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	"Juergen E . Fischer" <fischer@norbit.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	target-devel@vger.kernel.org,
	Bradley Grove <linuxdrivers@attotech.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Yihang Li <liyihang9@h-partners.com>,
	Don Brace <don.brace@microchip.com>, storagedev@microchip.com,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, Brian King <brking@us.ibm.com>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	open-iscsi@googlegroups.com, Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	megaraidlinux.pdl@broadcom.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com, Daniel Palmer <daniel@thingy.jp>,
	GOTO Masanori <gotom@debian.or.jp>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Geoff Levand <geoff@infradead.org>, Michael Reed <mdr@sgi.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Narsimhulu Musini <nmusini@cisco.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
	Vishal Bhakta <vishal.bhakta@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/4] scsi: host: allocate struct Scsi_Host on the NUMA
 node of the host adapter
Message-ID: <20260610153747.GA121666@fedora>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-3-sumit.saxena@broadcom.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57Se20/pMUpk+P8R"
Content-Disposition: inline
In-Reply-To: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--57Se20/pMUpk+P8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 05:48:01PM +0530, Sumit Saxena wrote:
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 5fdaa71f0652..88375574cb18 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -929,7 +929,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	num_targets =3D virtscsi_config_get(vdev, max_target) + 1;
> =20
>  	shost =3D scsi_host_alloc(&virtscsi_host_template,
> -				struct_size(vscsi, req_vqs, num_queues));
> +				struct_size(vscsi, req_vqs, num_queues), NULL);

A virtio_device has a parent (this is the virtio transport, like
virtio_pci) and that may have NUMA node.

drivers/virtio/virtio.c:register_virtio_device() could call
set_dev_node(dev, dev_to_node(dev->parent)) to propagate the NUMA node
to the virtio_device if it is not already automatically propagated.

Stefan

--57Se20/pMUpk+P8R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmophMsACgkQnKSrs4Gr
c8h+7Af/Yl5xc4DOlpzwRNKEPqqogmtmADQbRI91eNljCoArG1qdxcTTSKksIgWC
5g0jjNOCwbOatljS+FxPkDgpPYoZbsIv+K4p/D6UyHLP+Dff2FQhwPaAKkOvJi6k
9BoNOORgp8ZKrf0RrCTr2M5clKgG0GT+5WxgezSZtTh6wSoN0ksL5kwqx+8B4sWw
irnTFz4hZhKlUsYHWWYvNhiq0ChdmzYMdxw6GFwIWrRpNcElfSmOAMBE12bJeqIi
u2/3ah3cSSanhmuITCC+dXImHUlYtxtFRBowqsxCEtdiRFs5srPStR/WW8yyZoXe
mhXbMPjGmQXNdAT61yT9lw+ZVx2y1w==
=kfg0
-----END PGP SIGNATURE-----

--57Se20/pMUpk+P8R--


