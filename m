Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC159C282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:18:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3279020700
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 02:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3279020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yTwY07b1zDqNy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 13:18:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yTty5ljhzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 13:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43yTty3qX7z9sBZ;
 Mon, 11 Feb 2019 13:16:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver <oohall@gmail.com>
Subject: Re: [PATCH 3/7] powerpc/eeh_cache: Add a way to dump the EEH address
 cache
In-Reply-To: <CAOSf1CE4GES__w+Ps77Rg=uVV42F5uAetNQ3VC8GRZ0K6xZ-YA@mail.gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-3-oohall@gmail.com>
 <875ztuk3x0.fsf@concordia.ellerman.id.au>
 <CAOSf1CE4GES__w+Ps77Rg=uVV42F5uAetNQ3VC8GRZ0K6xZ-YA@mail.gmail.com>
Date: Mon, 11 Feb 2019 13:16:55 +1100
Message-ID: <87k1i7hxwo.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver <oohall@gmail.com> writes:
> On Fri, Feb 8, 2019 at 8:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>> > diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
>> > index b2c320e0fcef..dba421a577e7 100644
>> > --- a/arch/powerpc/kernel/eeh_cache.c
>> > +++ b/arch/powerpc/kernel/eeh_cache.c
>> > @@ -298,9 +299,34 @@ void eeh_addr_cache_build(void)
>> >               eeh_addr_cache_insert_dev(dev);
>> >               eeh_sysfs_add_device(dev);
>> >       }
>> > +}
>> >
>> > -#ifdef DEBUG
>> > -     /* Verify tree built up above, echo back the list of addrs. */
>> > -     eeh_addr_cache_print(&pci_io_addr_cache_root);
>> > -#endif
>> > +static int eeh_addr_cache_show(struct seq_file *s, void *v)
>> > +{
>> > +     struct rb_node *n = rb_first(&pci_io_addr_cache_root.rb_root);
>> > +     struct pci_io_addr_range *piar;
>> > +     int cnt = 0;
>> > +
>> > +     spin_lock(&pci_io_addr_cache_root.piar_lock);
>> > +     while (n) {
>> > +             piar = rb_entry(n, struct pci_io_addr_range, rb_node);
>> > +
>> > +             seq_printf(s, "%s addr range %3d [%pap-%pap]: %s\n",
>> > +                    (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
>> > +                    &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
>> > +
>> > +             n = rb_next(n);
>> > +             cnt++;
>> > +     }
>>
>> You can write that as a for loop can't you?
>>
>>         struct rb_node *n;
>>         int i = 0;
>>
>>         for (n = rb_first(&pci_io_addr_cache_root.rb_root); n; n = rb_next(n), i++) {
>
> IIRC I did try that, but it's too long. 85 cols wide according to my editor.

Don't care.

Long lines aren't inherently evil, they have some downsides but so do
the other options. In a case like this 85 columns would be preferable to
splitting the line or writing it a while loop.

cheers
