Return-Path: <linuxppc-dev+bounces-22387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0372CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 06:00:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZw9N6GH4z3bp7;
	Wed, 10 Jun 2026 16:00:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781071208;
	cv=none; b=grXDyknr13msW0yFH+VBW/HREeeCI5nr8ivQxlGzXn4/CG70BxE8BKBrRJZ9mURnM6fjXKOlthaTO8hk3zzkYJ5+9TeKOqjWUT+0vOzGmghnexsFJSB0Nj4xu30p9ZBPzHUOglw3iGqg3lFDU+CCSazv863e4eEyyKxsQfUbE6Lfzoi1JXoUn80Xt193TEHhdFGBvEVFvL1+zOSlAKbJgpsfcd0cHYkW4zF+mDQi0MyVFkBa5DzR7T/LfiS+j3GYleMeWYjsb1DEIJIAD9qoO/sQoLMSRttxzWf0Utj9eI5CCHa+/xt1BsygE7OtUk5hjizYLD1d0oyXLcHpuTdr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781071208; c=relaxed/relaxed;
	bh=0eeq4qUemue69ATVH9Hc0G+s1EX6SM4VcPKiJpjYoUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bczk4gu0B0zvonmmDu+qOGQ8av8TB5gQUYVowa/Z3sSR93EDBFCmbHqPGTMBrHsUv9LJ3W3ZtjruaZPxpGG/MsXVzgnLBRc3AMgeAzl4vAo/Tr0/iM2fKzLQ4WcJ5uUDih2D8YB0aOALtuz8nCtY+NFpyd7e/TzT9DeFITfXF3TgJ7a99R/zDg6U/ksAw7nfnY/qrZ6bsmO0VDZaruovxdlPxUdT/Ex07Y/R03vFS8ZF3odc5IsoSo8jdjvFiPHZAQKqJ0hh+hOdlE0zgS2ADJ2AVyHOCu0daEhB18/0OuRUN73UP1LL1f+btAN1I/PoAc/+lDkOsQQwg+wBCIH5gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Qy3+WbJn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=hare@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Qy3+WbJn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=hare@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZw9L57xLz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 16:00:05 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso25545955e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781071201; x=1781676001; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eeq4qUemue69ATVH9Hc0G+s1EX6SM4VcPKiJpjYoUk=;
        b=Qy3+WbJnPRHz0619jf0QFRp6ZqNmfsPt+j9uKbYjc/7ak5GmTh6t2Dq7IA2iIGCjJy
         /n9lnB+bs+mmDclYE1rF6y5FD8u6FLMxMC/CFdoV+l4rDHFSr2pMkFWPoAkVZ8/KW2SP
         x3kIlVKvvcIVlIaavyW9Jv2So2MK0oIl2NZlUecWQwny6e6hPsEE8OHmnAFy7dTMGkk9
         xpgjujSGdmzExRrp7QYN8DbCtDmtAHYYKC6m3354UppvMJhvl2M7nQ4jk+N+Yn1RVnc5
         Xr5vrh2Pfu2NuHJupYy2QLoow4t89tL+597lB0Qbhk+oQLQyilLdD60I0N8b5OirMOJ/
         Vllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071201; x=1781676001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eeq4qUemue69ATVH9Hc0G+s1EX6SM4VcPKiJpjYoUk=;
        b=q7RwgWIVd/LzNFVu9keqLgcEtNJXHZY2GJLbL6ycbRJvjYCHdFc6ipx3zEmiqRinny
         Y5oL5kZg6wUrrYg/T5RXWTWzxGPV8LPawzIXuX1ivAihVx87bWjo+iUbW8kgsLm97Hzz
         uHTlTkUIKadjPGLII5MFMAliFuiUCyKwqyRUjJwPnqNaaIOYuOZgDMeUc3PQUPuUV3pK
         73urE7ZVLsUBpuAydeoQBeMZGu9D7xi+x3WWLiwC3UM76gmMXrvr6B8i4MKEGfGUdyKj
         dZrOpLkF4fEUGtAOMlLbfZmdjy3OwguaqlqfTraEBch3mCYbs2bYQGagKpexcetj+Qbl
         GXTw==
X-Forwarded-Encrypted: i=1; AFNElJ9NLm4bJQw9crBLD8/ZIDPCmnUuMjR5E3bb1oYpHLdH16LGMStUYnJ2iPwIqrV7I2qwxgdpaHOlwPxdOgI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0GEhncbQMFLs88y363zfNSrfTOf9Mb3wqZncWwl2GzUMpoYk8
	JQOu4nfs54SCrXVO4vYskYrHiFwUP7hECdGt2YbPx21x18oS0L6eyGdKKPk/qsYB43s=
X-Gm-Gg: Acq92OEY8rTRm6dKtRb56fyQ1ewrqBMJPIyHVQkrCK53joZhIXylnITCBOY1sps+HCt
	65PwMeUfv9Qr9bXiuKqXEiLWXMqGHnFYmyO/bJmAaX/5pi8fBVYZeNNTSQgORCybXgAVaVYh8EM
	VuQ39sHlDce2qKpfM1Boh7xFDXSI7UzvBsutWIT0L5Kq3PiEZumCTGwQxv5/ISppFBllFVk3UR8
	MXtpJbLCX9wKrKp0wQyFw2h8pDe6OLFTaVOrzvy1iHll4PUkf3U/y4zt5miWNO8pkNWlhQrPPUA
	P6F9asZnUgzElj8eFWtkvbMz6+p1kiG5kxAj2BOQTe5UzhIzC55sSpS/AWo0UzDoAK8PElUY6m7
	ZOaf9OvEE5EP0LNtRv4YX5fOuCQe2l1ofsTP0uLF9Ic8HrGAhTITxfO5eJOGc20R9ZB57xdn2fa
	9d0tKGggUG86OT+B7DswYGpbjUe0itVINbo0Ob/20A7uJQd3YxOFpbOgE9F7u5e82B6p9e9Tk=
X-Received: by 2002:a05:600c:8285:b0:490:abef:dae6 with SMTP id 5b1f17b1804b1-490c25b09bcmr392960895e9.19.1781071200857;
        Tue, 09 Jun 2026 23:00:00 -0700 (PDT)
Received: from ?IPV6:2001:a62:1439:d001:a0af:1164:c6fd:8c51? ([2001:a62:1439:d001:a0af:1164:c6fd:8c51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm69552212f8f.33.2026.06.09.22.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:00:00 -0700 (PDT)
Message-ID: <e2a61373-0c27-41c3-b0ca-836a4727a3b5@suse.com>
Date: Wed, 10 Jun 2026 07:59:57 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] scsi: host: allocate struct Scsi_Host on the NUMA
 node of the host adapter
To: Sumit Saxena <sumit.saxena@broadcom.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Adam Radford <aradford@gmail.com>, Khalid Aziz <khalid@gonehiking.org>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
 Matthew Wilcox <willy@infradead.org>, "Juergen E . Fischer"
 <fischer@norbit.de>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Finn Thain <fthain@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
 Jamie Lenehan <lenehan@twibble.org>, Ram Vegesna <ram.vegesna@broadcom.com>,
 target-devel@vger.kernel.org, Bradley Grove <linuxdrivers@attotech.com>,
 Satish Kharat <satishkh@cisco.com>, Sesidhar Baddela <sebaddel@cisco.com>,
 Karan Tilak Kumar <kartilak@cisco.com>, Yihang Li
 <liyihang9@h-partners.com>, Don Brace <don.brace@microchip.com>,
 storagedev@microchip.com, HighPoint Linux Team <linux@highpoint-tech.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Brian King <brking@us.ibm.com>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>, open-iscsi@googlegroups.com,
 Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
 megaraidlinux.pdl@broadcom.com,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 Ranjan Kumar <ranjan.kumar@broadcom.com>, MPT-FusionLinux.pdl@broadcom.com,
 Daniel Palmer <daniel@thingy.jp>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Geoff Levand <geoff@infradead.org>,
 Michael Reed <mdr@sgi.com>, Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, Narsimhulu Musini
 <nmusini@cisco.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 linux-hyperv@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
 virtualization@lists.linux.dev, Vishal Bhakta <vishal.bhakta@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, John Garry <john.g.garry@oracle.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260609121806.2121755-3-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/26 14:18, Sumit Saxena wrote:
> scsi_host_alloc() used kzalloc(), which always picks an arbitrary node.
> Extend the function to accept a 'struct device *dev' parameter and use
> kzalloc_node() with dev_to_node(dev) so the Scsi_Host struct lands on
> the same NUMA node as the HBA, mirroring the treatment already applied
> to struct scsi_device, struct scsi_target, and shost_data.
> 
> When dev is NULL (legacy ISA/platform drivers without a dma_dev) the
> allocation falls back to NUMA_NO_NODE, preserving existing behaviour.
> 
> Update all in-tree callers:
>    - PCI-based HBA drivers pass &pdev->dev (or the equivalent struct
>      member such as &phba->pcidev->dev, &h->pdev->dev, &ha->pdev->dev)
>      so their host struct is placed on the adapter's node.
>    - Non-PCI drivers (ISA, Amiga, ARM PCMCIA, virtio, Hyper-V, PS3, …)
>      pass NULL.
>    - libfc's libfc_host_alloc() inline helper passes NULL; FC drivers
>      that want NUMA awareness can open-code the call with their pdev.
> 
> Suggested-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   drivers/scsi/3w-9xxx.c                    | 2 +-
>   drivers/scsi/3w-sas.c                     | 2 +-
>   drivers/scsi/3w-xxxx.c                    | 2 +-
>   drivers/scsi/53c700.c                     | 2 +-
>   drivers/scsi/BusLogic.c                   | 2 +-
>   drivers/scsi/a100u2w.c                    | 2 +-
>   drivers/scsi/a2091.c                      | 2 +-
>   drivers/scsi/a3000.c                      | 2 +-
>   drivers/scsi/aacraid/linit.c              | 2 +-
>   drivers/scsi/advansys.c                   | 6 +++---
>   drivers/scsi/aha152x.c                    | 2 +-
>   drivers/scsi/aha1542.c                    | 2 +-
>   drivers/scsi/aha1740.c                    | 2 +-
>   drivers/scsi/aic7xxx/aic79xx_osm.c        | 2 +-
>   drivers/scsi/aic7xxx/aic7xxx_osm.c        | 2 +-
>   drivers/scsi/aic94xx/aic94xx_init.c       | 2 +-
>   drivers/scsi/am53c974.c                   | 2 +-
>   drivers/scsi/arcmsr/arcmsr_hba.c          | 3 ++-
>   drivers/scsi/arm/acornscsi.c              | 2 +-
>   drivers/scsi/arm/arxescsi.c               | 2 +-
>   drivers/scsi/arm/cumana_1.c               | 2 +-
>   drivers/scsi/arm/cumana_2.c               | 2 +-
>   drivers/scsi/arm/eesox.c                  | 2 +-
>   drivers/scsi/arm/oak.c                    | 2 +-
>   drivers/scsi/arm/powertec.c               | 2 +-
>   drivers/scsi/atari_scsi.c                 | 2 +-
>   drivers/scsi/atp870u.c                    | 2 +-
>   drivers/scsi/bfa/bfad_im.c                | 2 +-
>   drivers/scsi/csiostor/csio_init.c         | 4 ++--
>   drivers/scsi/dc395x.c                     | 2 +-
>   drivers/scsi/dmx3191d.c                   | 2 +-
>   drivers/scsi/elx/efct/efct_xport.c        | 4 ++--
>   drivers/scsi/esas2r/esas2r_main.c         | 2 +-
>   drivers/scsi/fdomain.c                    | 2 +-
>   drivers/scsi/fnic/fnic_main.c             | 2 +-
>   drivers/scsi/g_NCR5380.c                  | 2 +-
>   drivers/scsi/gvp11.c                      | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_main.c     | 2 +-
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 2 +-
>   drivers/scsi/hosts.c                      | 6 ++++--
>   drivers/scsi/hpsa.c                       | 2 +-
>   drivers/scsi/hptiop.c                     | 2 +-
>   drivers/scsi/ibmvscsi/ibmvfc.c            | 2 +-
>   drivers/scsi/ibmvscsi/ibmvscsi.c          | 2 +-
>   drivers/scsi/imm.c                        | 2 +-
>   drivers/scsi/initio.c                     | 2 +-
>   drivers/scsi/ipr.c                        | 2 +-
>   drivers/scsi/ips.c                        | 2 +-
>   drivers/scsi/isci/init.c                  | 2 +-
>   drivers/scsi/jazz_esp.c                   | 2 +-
>   drivers/scsi/libiscsi.c                   | 2 +-
>   drivers/scsi/lpfc/lpfc_init.c             | 2 +-
>   drivers/scsi/mac53c94.c                   | 2 +-
>   drivers/scsi/mac_esp.c                    | 2 +-
>   drivers/scsi/mac_scsi.c                   | 2 +-
>   drivers/scsi/megaraid.c                   | 2 +-
>   drivers/scsi/megaraid/megaraid_mbox.c     | 2 +-
>   drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>   drivers/scsi/mesh.c                       | 2 +-
>   drivers/scsi/mpi3mr/mpi3mr_os.c           | 2 +-
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 4 ++--
>   drivers/scsi/mvme147.c                    | 2 +-
>   drivers/scsi/mvsas/mv_init.c              | 2 +-
>   drivers/scsi/mvumi.c                      | 2 +-
>   drivers/scsi/myrb.c                       | 2 +-
>   drivers/scsi/myrs.c                       | 2 +-
>   drivers/scsi/ncr53c8xx.c                  | 2 +-
>   drivers/scsi/nsp32.c                      | 2 +-
>   drivers/scsi/pcmcia/nsp_cs.c              | 2 +-
>   drivers/scsi/pcmcia/qlogic_stub.c         | 2 +-
>   drivers/scsi/pcmcia/sym53c500_cs.c        | 2 +-
>   drivers/scsi/pm8001/pm8001_init.c         | 2 +-
>   drivers/scsi/pmcraid.c                    | 2 +-
>   drivers/scsi/ppa.c                        | 2 +-
>   drivers/scsi/ps3rom.c                     | 2 +-
>   drivers/scsi/qla1280.c                    | 2 +-
>   drivers/scsi/qla2xxx/qla_mid.c            | 2 +-
>   drivers/scsi/qla2xxx/qla_os.c             | 2 +-
>   drivers/scsi/qlogicfas.c                  | 2 +-
>   drivers/scsi/qlogicpti.c                  | 2 +-
>   drivers/scsi/scsi_debug.c                 | 2 +-
>   drivers/scsi/sgiwd93.c                    | 2 +-
>   drivers/scsi/smartpqi/smartpqi_init.c     | 2 +-
>   drivers/scsi/snic/snic_main.c             | 2 +-
>   drivers/scsi/stex.c                       | 2 +-
>   drivers/scsi/storvsc_drv.c                | 2 +-
>   drivers/scsi/sun3_scsi.c                  | 2 +-
>   drivers/scsi/sun3x_esp.c                  | 2 +-
>   drivers/scsi/sun_esp.c                    | 2 +-
>   drivers/scsi/sym53c8xx_2/sym_glue.c       | 2 +-
>   drivers/scsi/virtio_scsi.c                | 2 +-
>   drivers/scsi/vmw_pvscsi.c                 | 2 +-
>   drivers/scsi/wd719x.c                     | 2 +-
>   drivers/scsi/xen-scsifront.c              | 2 +-
>   drivers/scsi/zorro_esp.c                  | 2 +-
>   include/scsi/libfc.h                      | 2 +-
>   include/scsi/scsi_host.h                  | 3 ++-
>   97 files changed, 107 insertions(+), 103 deletions(-)
> 
Quite a lot of churn for such a (relatively) simple change.

I think it might be better to introduce a new function
(scsi_host_alloc_node() ?) with the additional parameter,
and make scsi_host_alloc() a wrapper around that.

That will reduce the size of this patch immensely.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

