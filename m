Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67F606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLJ4B1QNmz2xKx;
	Fri, 06 Nov 2026 10:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1030" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793920346;
	cv=pass; b=ApzYhGhib1HjR4OG8ZwF5+3FmYHMSKwoRm92K/dLAo91cSHS8B5KHSQtGwOQbTilR6OMkS6T599VU06ZifVKXLBpKkeQWT4lr49WeufruMwuLOuLTq5jWw+FXkwzziw9EJSH2V0NkGi+HWEYdLDGSYKPcVBHeNOdnZVXK9hMbIeznbaqILWN9zbfcEgn4iequB0vHCxyVV6DBUnP3wlpTA8KNLpOtSAzDh5NGQ8Vs4iZ8naHoIgWK/usiYFw6fh5PzSOQ/QRep7Vn/lwMFXCCybebqXXytkaL0TY+GEsh1M4qdQRj80hoMREmRv2NVLDseDq29Odw0uc9oxGfeOnqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793920346; c=relaxed/relaxed;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/NspDpPD8sPyy1eC9w5GnNCAkpzlW9xAQxP6jPHRdqGs+igz9MfckcnT2VpOK9mRQyljqT7HvCh5km5yMiRXmIXfefKCfjIHTQ0zSUyR6RX8RXKN71RKOr2qmvbgrC0z1ZZFU4ZIH623H4JuMi3/3u5FmZCLagn7V9YjzEs84RdbNjWBl1ncSWuUaRWYR3vNx+7FNcqOW8Db9Dp/KCqy2iVnkXhW+8ddMMji4alA3bh7ep0pxsqKO8eWCTjNpILb89NYhNelAXvvcLKDPMtz40qBYbzxmQOMFW26MyTcUvV++TVNvyArmNuqTNXR826eD/LZkKE1BR9vq6yxYWI4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLJ483TPfz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 10:12:23 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso33114a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 15:12:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=OIx4bUsmbxO4hykggieqoULeJXOrbWiskEsi/HkfaCBZARqGVLk7mXaYTGNAF+hfuJ
         gZ8w3rpIjiNk8CesJM1yCiGEGJEWLD28aUp3ydGTfrRECKDZhRClFPdmkBjbzK+rVgzW
         CHdomN5xI+CO5sQfpdfks7N37BoKoGPOkfx7q2JzYoQhEBSbD6oWc0ZSW2zjtgXh7mPx
         Dr0cBlcb6FnoBNdr4A0tbItDYP7LD5udEk2jqwKzOI8GCyta6JAql9WduZBdVcFDCDjd
         gpBjtjePWSNblKn0ts723JtRJVCA4VVhMmlJhcmDJzfjds3pXo6AKTfBVK3Ap6cU15Jr
         JsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=SqcPzQGly4+20/ia0U7EGwET3BhxS3f5kzIBQmQtAJw=;
        b=qfk0/6UxrUO9qZjYYzSPCc9IK1PXivmuu1iCVXZ0puPEdNekldO2AF6UrMaWzqVDbs
         CgJBsuE5I8bjjVgfJu/x9sCbExe0SVCkIqjN3Frz6kQ3ywGgBRuu7Qb1T6mcxxL0OBqn
         NyuuIwmj+UKfeSrzFE1Yne/7oHX98Eu80Yx2IK8sJZkvS/y5l2LrG/J1OJEH2doyGDxw
         f2QpAfnme1lujsmkbO1RAkU3epcMoQT3yWPPpfbfXXcUoaiwAgofKJ3ZzFlOKuy0b1yD
         R5hOF9em0RaEJd/TFIsDEhTBHoiqWQgVY5C4PuF0G6m2hyA17AjohcM30DzcpkR//DlA
         bDyw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=V5SU1EJRaxnmF4es/Q10Y9jvYNFxMuRIrFalZAmWj1FxpPA5vRIGf7BoKAz+vBADwp
         hSGO4B+1in/pBtpht2PdVSVibG2s/ioMxSi1JihRz0hHuaVigjiFTNFk6+GXZOc1YzS0
         gojfL5cEB1x5qUh0tED4Yq3Dx7j0jiGZVo/x8ZD4Ei+ANH+rESwMbltgEyZzuaaGZT4/
         SVNMRcWBYWRpM2UNrrx2XWlqYksGm3dM17Oj8dHyefnS+hFM8mPqpciVZiatl+S3r/K/
         PzKVyNw5R00x9Rf948C29l0nQ6nOgdmU2usspO7xs2o+qu1M3w2X/qV9XKqmbSiX4qiS
         jmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=tcGy+NL7NIx6i2C6R+Hi+SF/WT+ei7JbCntsPSE0c82TYsl0STUrHVF1QwSJWtSDir
         YJcjnyeXSPgKMrjO9KxoBfPVyHkaIDhhjTt0yjXN56OTHylP7jSEL9qluJdYFr9wJpYB
         9iZUgCegFIQD9exvnpvkkQlVK/AO4c/M0tTrUtVQXCYcDXJ50/pBGkrF1pvkZo5LBmSK
         Cr7ys4NxTh9J48dlW40LFw6S2fmOBmBLS+2+tstOr2CBP83jpuGYBtB/H3Cql2WoV0GD
         t8x7y/TYxB8ee+2OxPdEgbaVLCyGq4dP9UG1O1STxIq9WuMiydaaAaHYEKo/sK6AfdtI
         HXYw==
X-Forwarded-Encrypted: i=1; AKwUvBxUqcPMjNZU4IA1Xtko5CW1xT5xVPJlbW78RqB05aWOObZPttbDJI2xpL8id08S5IhkLd+6f5LGD5NyfUQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/aAeABtZeHoVKG0d46Rt5YvZbhqS2Wuk2e9pWWjjNZQRYLuNst
	CDTDZ9pH6hNo2N+BDPd2AoNbU7qmS2GSmJWeWxBNbFiTgrG9VtVlKVRBlYM1fy4RrFJh1xVWIAb
	XncAmJzjn7gUEssSuMfEsQDaVwD1UBbTsFzXMhNbI
X-Gm-Gg: AYBFou0wPuqAc0j2SaL9VY4aUsftkfTd07y3sllAmXIe18vYKm6FnxVQNVonLl0vMqC
	g8lzGInQsLX7/5yoAmDOxJ4kryfyrKE6VhjuqoCqIZNErRUKziDHF2l6pETmoXo/RGC5vPYY044
	re2J2Zd1Ws3zyCoWZVdHeq2pZlpHdtEK0QB5kZ90sB/B4Fhbjvs1rxhWvM+HkqQhQxo1O2NKgR2
	PemWVUzxJIjp26MehVWF1jc4WFJ22LJUk2lOEwuPZXDYsiXn7EhBkfAZlGZmZBV5NRTu+qyPLtG
	JGngGvEE6e6sP4q3KJOY34V6sc80n8tqE6cAgjUY5y2OnwPiaqRL6N9k989DFNG7dCWoFnmHP5N
	MqpY6WQ7E/RxtpcUplztS4zma74r5E7bqEEhCfC/HaOrReOI4X/r6wd6h/dO6YIEYsY/b
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com

