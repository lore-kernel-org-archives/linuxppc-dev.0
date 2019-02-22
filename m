Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F510C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:50:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9732F2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LnHnc0eC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9732F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RQk3NmVzDqVL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:50:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RGt5mhPzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:43:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="LnHnc0eC"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 445RGt1tG1z9s71; Fri, 22 Feb 2019 20:43:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550828598; bh=oqMrEFefPIt80hsYY45x/tC3cMKTE/xFGBZ7n5iMw5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LnHnc0eC277+GqQlVoDa70sF7XcqznhFHzRbaCpuuugDtz1/YPboR/om4UTaR3mpb
 14sI6ApIFSL5PvjKBlYn1jKeX256ciMBE0gUvJGeW5DrqFHjAtwH+cRJTWevm+Srq/
 sOV+8seuHXtGyn2U/8DznSUoKxnPMI0ERry+AM4C+UjPYvSb60+Pyn4IeB8jrETZne
 5r61tekDyLAADwtjWi7NVoDScPcJA9AcKEbGlHTV7efJ70mZG3tlTk5OwLn0QLT1kB
 Ha1XMEyoMfzJ7d4pRkF89UxnXkHaCWN5E2jSHdRrTdczdymiKS9d2zy7XYWj51AaNQ
 Jtgp3RVheFoTA==
Date: Fri, 22 Feb 2019 20:39:38 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] KVM: PPC: Release all hardware TCE tables
 attached to a group
Message-ID: <20190222093938.GC6006@blackberry>
References: <20190212043745.18290-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212043745.18290-1-aik@ozlabs.ru>
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
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 12, 2019 at 03:37:45PM +1100, Alexey Kardashevskiy wrote:
> The SPAPR TCE KVM device references all hardware IOMMU tables assigned to
> some IOMMU group to ensure that in-kernel KVM acceleration of H_PUT_TCE
> can work. The tables are references when an IOMMU group gets registered
> with the VFIO KVM device by the KVM_DEV_VFIO_GROUP_ADD ioctl;
> KVM_DEV_VFIO_GROUP_DEL calls into the dereferencing code
> in kvm_spapr_tce_release_iommu_group() which walks through the list of
> LIOBNs, finds a matching IOMMU table and calls kref_put() when found.
> 
> However that code stops after the very first successful derefencing
> leaving other tables referenced till the SPAPR TCE KVM device is destroyed
> which normally happens on guest reboot or termination so if we do hotplug
> and unplug in a loop, we are leaking IOMMU tables here.
> 
> This removes a premature return to let kvm_spapr_tce_release_iommu_group()
> find and dereference all attached tables.
> 
> Fixes: 121f80ba68f "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-next tree.

Paul.
