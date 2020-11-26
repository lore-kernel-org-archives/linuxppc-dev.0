Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38ECC56201
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:23:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D554320578
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="caJVE16k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D554320578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChNQJ1mpDzDr7Z
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 14:23:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChNNd3xR0zDr5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 14:22:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=caJVE16k; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ChNNd275Sz9sRK;
 Thu, 26 Nov 2020 14:22:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606360945;
 bh=yX9WEAmDETJStycvdfhm5xjpOuROvlTMfef+2IZNRzo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=caJVE16kPD5T5w1YfQUtCJ82yfv3OPIrIBflantGq+tUNWi4NV9lzL0hp86igcHKG
 mXPBYm3z7KHBmNWucFw+VsUhHCkMEqGu2N1EdLYgGS6NR3XCkYW4MgLPnau1sEugOe
 h2fgo+qYSD4ewJKcXYHIicyXCuFVCHwKdVbSXcclkwcOtrVtozBz0lSB8trFWngWrA
 G3t/eSVPnoZLQNKdAuVGXVvGIVEEEMau9zw0h8aghk5BF1O7ODUOW4kPAMBREPWVaC
 V9GH2Ksr94sZw80vcKoxstOyv43ZsrkdJw+jcPbV3Dk0PJMo/V28gCgnHKak8k8pgB
 OEFipznFGoqQg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marc Zyngier <maz@kernel.org>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
In-Reply-To: <5419d1790c9ea0d9d7791ae887794285@kernel.org>
References: <20201125150932.1150619-1-lvivier@redhat.com>
 <20201125150932.1150619-3-lvivier@redhat.com>
 <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
 <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com>
 <5419d1790c9ea0d9d7791ae887794285@kernel.org>
Date: Thu, 26 Nov 2020 14:22:24 +1100
Message-ID: <87360wztsf.fsf@mpe.ellerman.id.au>
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Denis Kirjanov <kda@linux-powerpc.org>, Greg Kurz <groug@kaod.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Marc Zyngier <maz@kernel.org> writes:
> On 2020-11-25 16:24, Laurent Vivier wrote:
>> On 25/11/2020 17:05, Denis Kirjanov wrote:
>>> On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
>>>> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>>>> 
>>>> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ 
>>>> affinity")
>>>> this is broken on pseries.
>>> 
>>> Please add "Fixes" tag.
>> 
>> In fact, the code in commit 0d9f0a52c8b9f is correct.
>> 
>> The problem is with MSI/X irq affinity and pseries. So this patch
>> fixes more than virtio_scsi. I put this information because this
>> commit allows to clearly show the problem. Perhaps I should remove
>> this line in fact?
>
> This patch does not fix virtio_scsi at all, which as you noticed, is
> correct. It really fixes the PPC MSI setup, which is starting to show
> its age. So getting rid of the reference seems like the right thing to 
> do.

It's still useful to refer to that commit if the code worked prior to
that commit. But you should make it clearer that 0d9f0a52c8b9f wasn't in
error, it just exposed an existing shortcoming of the arch code.

cheers
