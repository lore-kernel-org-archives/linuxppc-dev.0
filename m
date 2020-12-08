Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF7DC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 23:04:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07E23A7B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 23:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07E23A7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrG2b4NM0zDqjn
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Dec 2020 10:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=caKXgnd/; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=5J7Hq6Oe; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrFzF50MnzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2020 10:01:13 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1607468467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aG1iFfSdBNfp1+ipOz8CIIBIA9ljbLDO35QyjUEKrTE=;
 b=caKXgnd/6F5+flu3BbUK6Urny2VYChTcHAdM+E61wnEpdFwoiiwFLZTuOuPOEFUE4VFgZJ
 b+NID39FwSsidMYttdhBz9Ogi7JcWmGpuu2dNeUMMscvAwuPYo14sIVNSUvOCEEEIZ2lFk
 ZPEG7P5kTbJyxqYu+n3urcd/BUA6fsxaek6BkVVvhX4kFQpO8/16f973TSQ6NvIO3QoJpZ
 4yle9IIkIfGPO14+x2qxuUCS8RGtHwIiozuZ6YbDvOHVvfO9Angxjtnpze8SQt9MsYF7O2
 qbWrapPKKJQEje/bg1+jSWZRtsmx4HFigDgRV0JMA+G4u4u31AVASP25js+e8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1607468467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aG1iFfSdBNfp1+ipOz8CIIBIA9ljbLDO35QyjUEKrTE=;
 b=5J7Hq6OeCCL/rGYGl/L1A2mCM4OFzpbzrJf5/KHAOBf52T4tPNcIvPHYPODs0Uy+MxHbwP
 t5c3+1xPYLlDycCg==
To: Michael Ellerman <mpe@ellerman.id.au>, "Enrico Weigelt\,
 metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
In-Reply-To: <877dptt5av.fsf@mpe.ellerman.id.au>
References: <20201207143146.30021-1-info@metux.net>
 <877dptt5av.fsf@mpe.ellerman.id.au>
Date: Wed, 09 Dec 2020 00:01:07 +0100
Message-ID: <87y2i7298s.fsf@nanos.tec.linutronix.de>
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
Cc: linux-s390@vger.kernel.org, hpa@zytor.com, linux-parisc@vger.kernel.org,
 deller@gmx.de, x86@kernel.org, linux-um@lists.infradead.org,
 James.Bottomley@HansenPartnership.com, mingo@redhat.com, paulus@samba.org,
 richard@nod.at, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, jdike@addtoit.com,
 anton.ivanov@cambridgegreys.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 08 2020 at 13:11, Michael Ellerman wrote:
> "Enrico Weigelt, metux IT consult" <info@metux.net> writes:
>> All archs, except Alpha, print out the irq number in hex, but the message
>> looks like it was a decimal number, which is quite confusing. Fixing this
>> by adding "0x" prefix.
>
> Arguably decimal would be better, /proc/interrupts and /proc/irq/ both
> use decimal.
>
> The whole message is very dated IMO, these days the number it prints is
> (possibly) virtualised via IRQ domains, ie. it's not necessarily a
> "vector" if that even makes sense on all arches). Arguably "trap" is the
> wrong term on some arches too.
>
> So it would be better reworded entirely IMO, and also switched to
> decimal to match other sources of information on interrupts.

So much for the theory.

The printk originates from the very early days of i386 Linux where it
was called from the low level entry code when there was no interrupt
assigned to a vector, which is an x86'ism.

That was copied to other architectures without actually thinking about
whether the vector concept made sense on that architecture and at some
point it got completely bonkers because it moved to core code without
thought.

There are a few situations why it is invoked or not:

  1) The original x86 usage is not longer using it because it complains
     rightfully about a vector being raised which has no interrupt
     descriptor associated to it. So the original reason for naming it
     vector is gone long ago. It emits:

     pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
                          __func__, smp_processor_id(), vector);

     Directly from the x86 C entry point without ever invoking that
     function.  Pretty popular error message due to some AMD BIOS
     wreckage. :)

  2) It's invoked when there is an interrupt descriptor installed but
     not configured/requested. In that case some architectures need to
     ack it in order not to block further interrupt delivery. In that
     case 'vector is bogus' and really want's to be 'irqnr' or such
     because there is a Linux virq number associated to it.

  3) It's invoked from __handle_domain_irq() when the 'hwirq' which is
     handed in by the caller does not resolve to a mapped Linux
     interrupt which is pretty much the same as the x86 situation above
     in #1, but it prints useless data.

     It prints 'irq' which is invalid but it does not print the really
     interesting 'hwirq' which was handed in by the caller and did
     not resolve.

     In this case the Linux irq number is uninteresting as it is known
     to be invalid and simply is not mapped and therefore does not
     exist.

     This has to print out 'hwirq' which is kinda the equivalent to the
     original 'vector' message.

  4) It's invoked from the dummy irq chip which is installed for a
     couple of truly virtual interrupts where the invocation of
     dummy_irq_chip::irq_ack() is indicating wreckage.

     In that case the Linux irq number is the thing which is printed.

So no. It's not just inconsistent it's in some places outright
wrong. What we really want is:

ack_bad_irq(int hwirq, int virq)
{
        if (hwirq >= 0)
           print_useful_info(hwirq);
        if (virq > 0)
           print_useful_info(virq);
        arch_try_to_ack(hwirq, virq);
}
    
for this to make sense. Just fixing the existing printk() to be less
wrong is not really an improvement.

Thanks,

        tglx


