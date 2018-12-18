Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450FC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:05:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DB4214C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 01:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Gv1cTfC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DB4214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JfwH3Tt1zDqgB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 12:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Gv1cTfC+";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Jfs15qkdzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Gv1cTfC+"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43Jfs10ncvz9s6w; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1545094981; bh=V5QBfqcHsgPvLXXgQQlL55oQmkg5S0QsEq17pNxrBd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gv1cTfC+NZaIvnvhAUQuwVeMHsvw8GLgTOrpGhL0yQsJZoBdZ1MHDtBohvgRCSbBn
 88Sc7NtUtiifRckkbF+8epXu2PxISLxu2lJzC/ndj9EfNNIJ+GctuC0HqybVS/JuOZ
 tElCFAF3e+oOiI2xZe/2pC3InAGY9Ws0ZSUa2dszDJW63NJKwGDJwVlEvfFVNYb4cb
 qF8TEaVjnMl/sb3cjzTKpezbBAOdT41lCRKB5ch6WpDlah5XypY/+qsWqbFlsYo2IX
 YmxSOs4n7fEloQ9vqKqWR/mgglqQakLawNcgpJLEpXuwHFy80qs8B/klc+jDry1JS0
 LZ5QuRNmjLa/g==
Date: Tue, 18 Dec 2018 12:02:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH V4 0/8] KVM: PPC: Implement passthrough of emulated
 devices for nested guests
Message-ID: <20181218010253.GE25748@blackberry>
References: <20181214052910.23639-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214052910.23639-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 14, 2018 at 04:29:02PM +1100, Suraj Jitindar Singh wrote:
> This patch series allows for emulated devices to be passed through to nested
> guests, irrespective of at which level the device is being emulated.
> 
> Note that the emulated device must be using dma, not virtio.
> 
> For example, passing through an emulated e1000:
> 
> 1. Emulate the device at L(n) for L(n+1)
> 
> qemu-system-ppc64 -netdev type=user,id=net0 -device e1000,netdev=net0
> 
> 2. Assign the VFIO-PCI driver at L(n+1)
> 
> echo vfio-pci > /sys/bus/pci/devices/0000:00:00.0/driver_override
> echo 0000:00:00.0 > /sys/bus/pci/drivers/e1000/unbind
> echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
> chmod 666 /dev/vfio/0
> 
> 3. Pass the device through from L(n+1) to L(n+2)
> 
> qemu-system-ppc64 -device vfio-pci,host=0000:00:00.0
> 
> 4. L(n+2) can now access the device which will be emulated at L(n)
> 
> V2 -> V3:
> 1/8: None
> 2/8: None
> 3/8: None
> 4/8: None
> 5/8: None
> 6/8: Add if def to fix compilation for some platforms
> 7/8: None
> 8/8: None
> 
> Suraj Jitindar Singh (8):
>   KVM: PPC: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machines
>   KVM: PPC: Book3S HV: Add function kvmhv_vcpu_is_radix()
>   KVM: PPC: Book3S HV: Implement functions to access quadrants 1 & 2
>   KVM: PPC: Add load_from_eaddr and store_to_eaddr to the kvmppc_ops
>     struct
>   KVM: PPC: Update kvmppc_st and kvmppc_ld to use quadrants
>   KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an L2
>     guest
>   KVM: PPC: Introduce new hcall H_COPY_TOFROM_GUEST to access quadrants
>     1 & 2
>   KVM: PPC: Book3S HV: Allow passthrough of an emulated device to an L3
>     guest

Thanks, series applied to my kvm-ppc-next branch.

Paul.
