Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9458C4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Oct 2022 14:35:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MnZtY0M5nz3c5q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Oct 2022 01:35:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ex1DBVWx;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MnZsT6T6Vz2xHL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2022 01:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ex1DBVWx;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnZsM3YYXz4xGQ;
	Thu, 13 Oct 2022 01:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1665585241;
	bh=ZwzUyoEZ0QyY2/E7GFhwabiJeQLIx//6F4mXwQYP97E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ex1DBVWxo4dVZXYC/c3s2BRZC+uHoJKi2xOwQm6ownsPzATmCcA6UI2Ot2eQnW/fT
	 QYzmIK1I5c0faUhON0YJpUrPWfWg9KE6Yka/0wA9GAsW9Vp8MNIQQNeRhYs+CAWk24
	 vgQfX5nvT2+/clEQ4y9+GKLtgGQCbpuh96nqjlZTr2jTMp7Ya2xSyN/L7t5RgeeiOX
	 U8I6bb4WUzWNag8WpglJJ29hxVssdCZdpfCnabrVUcGHx0kL+uWeF1fBgc/5OKvfGs
	 hyRHG2d7m5iRmnSfAvH0sXgFQKp9JsUV5g+WgYyjTMvZ+EY6NObWrmtwJFVUEVKpTE
	 4XZY0iUdjZztw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
In-Reply-To: <87mta1marq.fsf@mpe.ellerman.id.au>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au>
Date: Thu, 13 Oct 2022 01:33:59 +1100
Message-ID: <87edvdm7qg.fsf@mpe.ellerman.id.au>
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
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, alvaro.karsz@solid-run.com, netdev@vger.kernel.org, jasowang@redhat.com, wangdeming@inspur.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, angus.chen@jaguarmicro.com, Bjorn Helgaas <bhelgaas@google.com>, lingshan.zhu@intel.com, linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> [ Cc += Bjorn & linux-pci ]
>
> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> On Wed, Oct 12, 2022 at 05:21:24PM +1100, Michael Ellerman wrote:
>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
> ...
>>> > ----------------------------------------------------------------
>>> > virtio: fixes, features
>>> >
>>> > 9k mtu perf improvements
>>> > vdpa feature provisioning
>>> > virtio blk SECURE ERASE support
>>> >
>>> > Fixes, cleanups all over the place.
>>> >
>>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> >
>>> > ----------------------------------------------------------------
>>> > Alvaro Karsz (1):
>>> >       virtio_blk: add SECURE ERASE command support
>>> >
>>> > Angus Chen (1):
>>> >       virtio_pci: don't try to use intxif pin is zero
>>> 
>>> This commit breaks virtio_pci for me on powerpc, when running as a qemu
>>> guest.
>>> 
>>> vp_find_vqs() bails out because pci_dev->pin == 0.
>>> 
>>> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
>>> succeed if we called it - which is what the code used to do.
>>> 
>>> I think this happens because pci_dev->pin is not populated in
>>> pci_assign_irq().
>>> 
>>> I would absolutely believe this is bug in our PCI code, but I think it
>>> may also affect other platforms that use of_irq_parse_and_map_pci().
>>
>> How about fixing this in of_irq_parse_and_map_pci then?
>> Something like the below maybe?
>> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 196834ed44fe..504c4d75c83f 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -446,6 +446,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>>  	if (pin == 0)
>>  		return -ENODEV;
>>  
>> +	pdev->pin = pin;
>> +
>>  	/* Local interrupt-map in the device node? Use it! */
>>  	if (of_get_property(dn, "interrupt-map", NULL)) {
>>  		pin = pci_swizzle_interrupt_pin(pdev, pin);

Backing up a bit. Should the virtio code be looking at pci_dev->pin in
the first place?

Shouldn't it be checking pci_dev->irq instead?

The original commit talks about irq being 0 and colliding with the timer
interrupt.

But all (most?) platforms have converged on 0 meaning NO_IRQ since quite
a fews ago AFAIK.

And the timer irq == 0 is a special case AIUI:
  https://lore.kernel.org/all/CA+55aFwiLp1z+2mzkrFsid1WZQ0TQkcn8F2E6NL_AVR+m1fZ2w@mail.gmail.com/

cheers
