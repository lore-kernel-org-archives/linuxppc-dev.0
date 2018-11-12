Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C083C4161D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5077922443
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5077922443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tqlT0mFzzF3Rk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 23:27:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tqgZ4PVMzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 23:24:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42tqgY4l0Vz9s1x;
 Mon, 12 Nov 2018 23:24:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] powerpc: Add KVM guest defconfig
In-Reply-To: <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
References: <20181108050826.17796-1-sathnaga@linux.vnet.ibm.com>
 <1bfa6ffb-80a9-017e-241f-bafa05b600f7@debian.org>
 <20181109095926.GA15706@dhcp-9-193-110-205.in.ibm.com>
Date: Mon, 12 Nov 2018 23:24:08 +1100
Message-ID: <87efbqa3h3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: sathnaga@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:

> On Thu, Nov 08, 2018 at 04:23:07PM -0200, Breno Leitao wrote:
>> hi Satheesh,
>> 
>> On 11/08/2018 03:08 AM, sathnaga@linux.vnet.ibm.com wrote:
>> > --- /dev/null
>> > +++ b/arch/powerpc/configs/guest.config
>> > @@ -0,0 +1,14 @@
>> > +CONFIG_VIRTIO_BLK=y
>> > +CONFIG_VIRTIO_BLK_SCSI=y
>> > +CONFIG_SCSI_VIRTIO=y
>> > +CONFIG_VIRTIO_NET=y
>> > +CONFIG_NET_FAILOVER=y
>> > +CONFIG_VIRTIO_CONSOLE=y
>> > +CONFIG_VIRTIO=y
>> > +CONFIG_VIRTIO_PCI=y
>> > +CONFIG_KVM_GUEST=y
>> > +CONFIG_EPAPR_PARAVIRT=y
>> > +CONFIG_XFS_FS=y
>> 
>> Why a guest kernel needs to have XFS integrated in the core image? I am
>> wondering if it is a requirement from another CONFIG_ option.
>
> Idea is to have a working config which would boot guest without initramfs,
> other FS(like EXT4) is already integrated in the core image, 
> thought this would be helpful for distributions, which default XFS as root disk.

Maybe we should switch XFS_FS to Y in ppc64_defconfig ?

cheers
