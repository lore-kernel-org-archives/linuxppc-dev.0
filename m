Return-Path: <linuxppc-dev+bounces-22388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF1CD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 06:00:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZwB30MHbz3brL;
	Wed, 10 Jun 2026 16:00:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::231"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781071242;
	cv=none; b=OMGktbfaR3gapgs0A6ZslPEv17RdXhqhpewMaTT1iXJVFjXv95h3ksv/YFisoZQn6tJ8itbkuCa1UhqrkUDIV+P2YIhFihDWFT4rkFqaTaxa/MTmU3NMuHnNe9y5sesfEC7kklek1rCRpRD0oFc6bfRZvlKrnTDAPNf7t1PJaQxnn86ye/FKntfeEnjMxSw6qBe7e43DhFJ5MXDb+eMPFgzND5ZlqMdm+osuR4gUmHR+sSwoZ4qILlDZvqgdTomghsvYGyBXhei9kd5mHvmiuZfdz60H3gFopuf5z6atXVAj52FuvK40lhcvBMKn/LLAP8Zj6pmqtoDd999UBIy4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781071242; c=relaxed/relaxed;
	bh=gj0YYK+8W8BmuuGLUjKiEFrVEApz47d5/8fZSNVUxGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSf1u3qf7iGbvpvhA7hFWyQMx7G6ZTVlYXjl/VAlJCoYSIJwN+wxHjICHH4RhdCd2fWoLzkh4FLLeaswlYedXzpDPSR05grdlAUjgWU4FYqIfHhxdrkHp1hBPuJTE9AgVa+lrt5mhwW2xxSbNzjm7s4T8buYo+fodq84XDbeHIKqVrEjNgdmvQgiuRND02b9/GtqdbUPzkMwd9GN8Z6hRr9x9j7NofNKDW2V3IwWn2cr5f7krNH7N5Ll4F1kVhbK3xvRhQu2xhaVxH95lV6xPsVTQw6rCKq39P0W78kwqrfGcp5Buj+NgFzt0m3KaQ+pzGWlKPVhGv3UnP0ovza2Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HLcedWbl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=hare@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=HLcedWbl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=hare@suse.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZwB148JCz3btt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 16:00:41 +1000 (AEST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-39661f81eacso68365101fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781071238; x=1781676038; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gj0YYK+8W8BmuuGLUjKiEFrVEApz47d5/8fZSNVUxGs=;
        b=HLcedWblZXNzcKo6uuFDGPt3N/9rzXWAZc4yuoCqpIQGxd1OMm2vWZpTKNporQuJFY
         i4vOI9b/6fh3MolLJmcpwfshgtaeL3UtlAWvII235L6bQEN4C9/q71+2WzGE1SyRrerB
         Ti9rKqsRg2ckh7VJPypT6bViU0Kh9PO7ar7E52f31xbKpyFMFN9dJlEHoQmPHyGiDcBm
         57nqiQUiAFSKf5n6llgVukczLIvGEzvmmgeGy+yQzg1qPAmPWwXcxc3S9m118vVd0IWe
         ZaO9zO7HuYQkG308Lb1PzP6rYUhRwer4RuCGUTqff7M+M7rstawESuBJ9WW29oQuxY4U
         6Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071238; x=1781676038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gj0YYK+8W8BmuuGLUjKiEFrVEApz47d5/8fZSNVUxGs=;
        b=rkfnh8VkNayPKrL8r3mfeH1Ft1vNTI17TJRQrRly+rG25tUKNzs+tNJjjJGKNvMAjZ
         5VbuZvifM182R9yMhM5eA45r/gom64AMjMsB9leHGH2srkBlo9UoxYrvBHk+J5pRaBOZ
         C5UGnsycmGiXcVv/TxTUUUBA4y9GW4gCcU00X+eqGj8ynNOmhybg2xzNR7r8EefBjGUR
         6hflv8hVmdHInIF6FgKr8g3LklQ8s7KDEp8NPqo3nrF5FQoH/vg0BV/OoQgDVo2fBUsr
         f5Olrs+w9LgES9UtHZY/t7EZU59kcO2uaMIMGlhqfG6SfEAvSDeuDlWbbowxQzeBkW6y
         h4xw==
X-Forwarded-Encrypted: i=1; AFNElJ/l5nq+hlQkw07CfvAyZ6zTasxps8iqBsYrBH+fmVvM0oOoDGWadkwfzw164qoY/8p7xPp0LPxXJD0cJA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpeZvhfmzD8TiGo7rLFyQNJuEL7XB+/Qmvw/f9w2G57QXyd+py
	P1dKniBfa9UjAUJWKM0xYLy6Lox/f6iWpPb7GHpR8cQQ+zXX8TIurC86jhYq+qhMFP8=
X-Gm-Gg: Acq92OGG1HPjfIT4OywcmlxGlfaeY2yPZSRvU7u/4sjFIg4HgsfxFViR/vTVJUsVHTv
	gC2VdiTo837GK7LoobZe/9W0OUlwoVx0cIpU2ypEfJ9oOosbPiyEcldLIVz9dsj2JO+bagcT5P+
	8YcHlfJQMgAGj+e6bYScmtVSreDoc6Qvi3bpDVaPjfxx0CSXO6gsYR9Up4waL7GhU4EqW34mhHd
	xdPf266VqLDb+OX5uGF3a3HqD8H+XVYItGSDEQWJHuHYjaZ1DRTj2KdZbRVCnwzVjbOGC0SuHp6
	+JUUL9WpqHfF4jD6BPi1HNn0nOYs4TJa2Ziq5e8Lzy6ITx3VdGrj5+TsM56531uPihJnbQO5k8q
	x3Ohk78QmU82PI7WSjMasQIrcUzNCFlgnyU758cgFJFEA8D83pA72PFFm2vVMVGF0GKQtHKT5pV
	3PQblPn//5VMz71160EE87XIIcxK0ThTbVTv1/L7pbxbhvjZkOjk1M147/mnMtp7ZgUVrRuXs=
X-Received: by 2002:a2e:b8cd:0:b0:396:a647:76f5 with SMTP id 38308e7fff4ca-396d285f55dmr58137321fa.5.1781071237888;
        Tue, 09 Jun 2026 23:00:37 -0700 (PDT)
Received: from ?IPV6:2001:a62:1439:d001:a0af:1164:c6fd:8c51? ([2001:a62:1439:d001:a0af:1164:c6fd:8c51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abd6cbe6sm59530741fa.0.2026.06.09.23.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:00:36 -0700 (PDT)
Message-ID: <21746ee7-cff3-4db8-959d-dd693389492d@suse.com>
Date: Wed, 10 Jun 2026 08:00:30 +0200
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
Subject: Re: [PATCH v3 1/4] scsi: scan: allocate sdev and starget on the NUMA
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
 xen-devel@lists.xenproject.org, James Rizzo <james.rizzo@broadcom.com>
References: <20260609121806.2121755-1-sumit.saxena@broadcom.com>
 <20260609121806.2121755-2-sumit.saxena@broadcom.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260609121806.2121755-2-sumit.saxena@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/9/26 14:18, Sumit Saxena wrote:
> From: James Rizzo <james.rizzo@broadcom.com>
> 
> When a host adapter is attached to a specific NUMA node, allocating
> scsi_device and scsi_target via kzalloc() may place them on a remote
> node.  All hot-path I/O accesses to these structures then cross the NUMA
> interconnect, adding latency and consuming inter-node bandwidth.
> 
> Use kzalloc_node() with dev_to_node(shost->dma_dev) so allocations land
> on the same node as the HBA, reducing cross-node traffic and improving
> I/O performance on NUMA systems.
> 
> Signed-off-by: James Rizzo <james.rizzo@broadcom.com>
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>   drivers/scsi/scsi_scan.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

