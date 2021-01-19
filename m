Return-Path: <SRS0=EbLt=GW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0BDC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 03:29:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC212184D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 03:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC212184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKYzJ47xxzDr1D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Jan 2021 14:29:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c;
 helo=mail-pg1-x52c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WzlPZUCP; dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DKYxX6g9wzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2021 14:27:27 +1100 (AEDT)
Received: by mail-pg1-x52c.google.com with SMTP id 15so12172157pgx.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2021 19:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=IvOBsG72TdtWfS2ELjW2ZROhGBBtphs2og0NRX6347g=;
 b=WzlPZUCPM1Cpmyg5zbkdCabBVvDTpgo8HeopahJpAXcJuBQctVehr4fdJ7m2jOoTt+
 vkFbB+v/gPYeVUQo7bAffL3xndtPaPwPxhtT8hzJcxSYC5PU71DcbGJxuNbOM+XdHcLK
 L75NUaoLyUSyKV0k2c27k1iIhCjoSDuHgDsbDaIIP6BYY0pu/lPJnhutPEMwsBOMZvjm
 OvkLMroUT/L2C3UQJJIyRJjVCiA4iXPN4O6Gz5OVVYBrbSMIhdbgRxvyG4lehy2x7iEO
 llE/soVjr3po/L0NOpvUEKcKpsMDVUL/d/HQj5NmbyyOUlOYGKjduvccvEfuGATDBKVY
 JnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=IvOBsG72TdtWfS2ELjW2ZROhGBBtphs2og0NRX6347g=;
 b=IuDMF9bb9m67QI5JBqImoNe28GP/sbc4V5ZI6oME7o2ix1921M3T9KFKbNwyhOUlHG
 ejNtFD31Z4prxoreARcJf9l4r8PtBXtD5oJh3159RGPPVOy4LK1BjNCvI19T0DicQpFm
 8SzMLOyGVZzRvxc+5AY8zLND/tGxYqPCNJ93yWtrHihwgB1QgQjYIJ5oV9P9BbFKBM2/
 Hf3qqvd0Cusdda8ujQVtK7L+GQBPob4zqVUJha2c+SrIPXC2hnazbxS6sDH+xV7KcaRT
 kLD41GYBm54jz2p4ubj51PNUhSiHYqdguOyZsxrw+lsxcptYZwiqya9zbyHHHoI+ROw7
 ON8Q==
X-Gm-Message-State: AOAM533Bxk3YG78hS2U3WMVtP+cjLVih6kDZcPSv1AUgrmzoWiHFY0xn
 VU9Kj/smVoJucnejjx4UQSo=
X-Google-Smtp-Source: ABdhPJx3qm+cpo9wollUnAI7zsT1q9W49I+QP8XB1qmGNZRU8jW7AlePuZqpCb/i2a/qtXU0ANS1HA==
X-Received: by 2002:a63:4e44:: with SMTP id o4mr2666091pgl.46.1611026840999;
 Mon, 18 Jan 2021 19:27:20 -0800 (PST)
Received: from localhost ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id b72sm16882132pfb.129.2021.01.18.19.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 19:27:20 -0800 (PST)
Date: Tue, 19 Jan 2021 13:27:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/4] KVM: PPC: Book3S HV: Remove support for running HPT
 guest on RPT host without mixed mode support
To: Fabiano Rosas <farosas@linux.ibm.com>, kvm-ppc@vger.kernel.org
References: <20210118062809.1430920-1-npiggin@gmail.com>
 <20210118062809.1430920-2-npiggin@gmail.com> <87czy1bsvz.fsf@linux.ibm.com>
In-Reply-To: <87czy1bsvz.fsf@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1611025782.s66bkxjtqz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Fabiano Rosas's message of January 19, 2021 11:46 am:
> Resending because the previous got spam-filtered:
>=20
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> This reverts much of commit c01015091a770 ("KVM: PPC: Book3S HV: Run HPT
>> guests on POWER9 radix hosts"), which was required to run HPT guests on
>> RPT hosts on early POWER9 CPUs without support for "mixed mode", which
>> meant the host could not run with MMU on while guests were running.
>>
>> This code has some corner case bugs, e.g., when the guest hits a machine
>> check or HMI the primary locks up waiting for secondaries to switch LPCR
>> to host, which they never do. This could all be fixed in software, but
>> most CPUs in production have mixed mode support, and those that don't
>> are believed to be all in installations that don't use this capability.
>> So simplify things and remove support.
>=20
> With this patch in a DD2.1 machine + indep_threads_mode=3DN +
> disable_radix, QEMU aborts and dumps registers, is that intended?

Yes. That configuration is hanging handling MCEs in the guest with some=20
threads waiting forever to synchronize. Paul suggested it was never a
supported configuration so we might just remove it.

> Could we use the 'no_mixing_hpt_and_radix' logic in check_extension to
> advertise only KVM_CAP_PPC_MMU_RADIX to the guest via OV5 so it doesn't
> try to run hash?
>=20
> For instance, if I hack QEMU's 'spapr_dt_ov5_platform_support' from
> OV5_MMU_BOTH to OV5_MMU_RADIX_300 then it boots succesfuly, but the
> guest turns into radix, due to this code in prom_init:
>=20
> prom_parse_mmu_model:
>=20
> case OV5_FEAT(OV5_MMU_RADIX): /* Only Radix */
> 	prom_debug("MMU - radix only\n");
> 	if (prom_radix_disable) {
> 		/*
> 		 * If we __have__ to do radix, we're better off ignoring
> 		 * the command line rather than not booting.
> 		 */
> 		prom_printf("WARNING: Ignoring cmdline option disable_radix\n");
> 	}
> 	support->radix_mmu =3D true;
> 	break;
>=20
> It seems we could explicitly say that the host does not support hash and
> that would align with the above code.

I'm not sure, sounds like you could, on the other hand these aborts seem=20
like the prefered failure mode for these kinds of configuration issues,=20
I don't know what the policy is, is reverting back to radix acceptable?

Thanks,
Nick

