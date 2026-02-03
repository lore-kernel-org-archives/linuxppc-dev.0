Return-Path: <linuxppc-dev+bounces-16556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747DE8784A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 17:02:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f58tH2bMQz3bW7;
	Wed, 04 Feb 2026 04:02:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770138151;
	cv=none; b=l4ahwqHVVDBrRbvJXo3qXpXTZ6vxUdNNh3k9RRiPyAV+FuHkEXJj+AWSXWRzHqz7WjOEtfA/Nw7+QXvzx0NUt1zHOMnKdribCHK5gT8aWQ5K5quXMqft5D0lLi/McgHYXFtxlq1a++FN59M6IMqD9qqPb8tNhM/C42r/2n1Z9fwyeuywdaUbZd3215V6+glt2U/BpUIefCAClFnfZW4VGXUcfOfB71ruxJVLupznMB4XURA/rSGixu0VJ/ZxdbyOby+Cc5xaDnS+jkVOUYv1BUPr2cUBOuZK8+sYPp0hmkoZTbZYGtakVGegDO4AMswu1qkPnngDL80uiBAzTJ3/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770138151; c=relaxed/relaxed;
	bh=ozfP7T8/HOa7xDhYSxSvfrB6MuqgIMkM/GQOyZDo2f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXYPvlAwl5QwPWSXTnxZ46elqXMjbtoamO3SP12S6xI5JWQtETUisBWKlqA5PPFLH68Rj6yFAP3EJ+NbsbqJB59m8hcWAjrFx40BxKf2h09/KpQs1FutiblHUJ0xfl4h98/7oj+WlLheA4mSsuXUI2xFKDsAU0fJ5vi1X1gGuKUN9uwHT3+LLr1lw0wCo00Wr6u9uuQRr2+WWzzCZd42ZQCjRmRjcZWy9PC/BIARqzOKqVXWIQ3PlGa6bQbDBySfhb3HnCRfBI/7y5lnjW2udhMJZ4t9LIfs/w9XayU6ef+jKnyA6zh0MgBEyZtrlZoiaDwehlmB9SK6wT8B06XMuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MXt++9/M; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=T1wOhjxd; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MXt++9/M;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=T1wOhjxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4f58tF43hSz2xjb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 04:02:29 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770138135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozfP7T8/HOa7xDhYSxSvfrB6MuqgIMkM/GQOyZDo2f4=;
	b=MXt++9/McakViuR7x2HaX4Q2tvhCEDirevT9xhWGnqoNR0QzLeNPvZulKTf9rfcUZGkbUt
	wEQTo170CNH/dhqTug+LS2AJqcnssWjhbpbkfaQNuumfRaFGIRXNxYGAbjaEIRYgVnNXTK
	Wv2brOTbPcO6Wbcft7AoTCtPwKdL/+eFgzx6TeSVpP2TczKiJ97JjBsAG+eee5RHGvkWoL
	P5u9TyWJ834uNRBegchmN7AX/QQGqW/my1oDccrGCi9mPKFvGY5av8Fh2ID8LdeJBmdEKf
	xz2KYADFUxNkfo/GkSNSoGbwvbL8tuRamSb3qs9QDmoIOALEj8hGK2io2BaCIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770138135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ozfP7T8/HOa7xDhYSxSvfrB6MuqgIMkM/GQOyZDo2f4=;
	b=T1wOhjxdp1eQIJGPph8/XRF6EmGswEKx8y+W+d5Oe6QxAWnrGxUOrBRz/45mcjCGMcU9A/
	9+OoElDkdDB88rCw==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tony Luck
 <tony.luck@intel.com>, Dave Hansen <dave.hansen@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dan Williams <dan.j.williams@intel.com>, Len
 Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Ricardo Neri
 <ricardo.neri@intel.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ricardo
 Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v7 19/24] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
In-Reply-To: <20230301234753.28582-20-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
 <20230301234753.28582-20-ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Feb 2026 18:02:14 +0100
Message-ID: <87y0l93gmh.ffs@tglx>
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
Content-Type: text/plain

On Wed, Mar 01 2023 at 15:47, Ricardo Neri wrote:
> + * An HPET channel is reserved for the detector. The channel issues an NMI to
> + * one of the CPUs in @watchdog_allowed_mask. This CPU monitors itself for
> + * hardlockups and sends an NMI IPI to the rest of the CPUs in the system.
> + *
> + * The detector uses IPI shorthands. Thus, all CPUs in the system get the NMI
> + * (offline CPUs also get the NMI but they "ignore" it). A cpumask is used to
> + * specify whether a CPU must check for hardlockups.
> + *
> + * The NMI also disturbs isolated CPUs. The detector fails to initialize if
> + * tick_nohz_full is enabled.

This can be completely avoided. See below.

> +/**
> + * hardlockup_detector_nmi_handler() - NMI Interrupt handler
> + * @type:	Type of NMI handler; not used.
> + * @regs:	Register values as seen when the NMI was asserted
> + *
> + * Check if our HPET channel caused the NMI. If yes, inspect for lockups by
> + * issuing an IPI to the rest of the CPUs. Also, kick the timer if it is
> + * non-periodic.
> + *
> + * Returns:
> + * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
> + * otherwise.
> + */
> +static int hardlockup_detector_nmi_handler(unsigned int type,
> +					   struct pt_regs *regs)
> +{
> +	struct hpet_hld_data *hdata = hld_data;
> +	int cpu;
> +
> +	/*
> +	 * The CPU handling the HPET NMI will land here and trigger the
> +	 * inspection of hardlockups in the rest of the monitored
> +	 * CPUs.
> +	 */
> +	if (is_hpet_hld_interrupt(hdata)) {
> +		/*
> +		 * Kick the timer first. If the HPET channel is periodic, it
> +		 * helps to reduce the delta between the expected TSC value and
> +		 * its actual value the next time the HPET channel fires.
> +		 */
> +		kick_timer(hdata, !(hdata->has_periodic));
> +
> +		if (cpumask_weight(hld_data->monitored_cpumask) > 1) {
> +			/*
> +			 * Since we cannot know the source of an NMI, the best
> +			 * we can do is to use a flag to indicate to all online
> +			 * CPUs that they will get an NMI and that the source of
> +			 * that NMI is the hardlockup detector. Offline CPUs
> +			 * also receive the NMI but they ignore it.
> +			 */
> +			cpumask_copy(hld_data->inspect_cpumask,
> +				     cpu_online_mask);
> +
> +			/* If we are here, IPI shorthands are enabled. */
> +			apic->send_IPI_allbutself(NMI_VECTOR);

This should be done differently so that the isolation stuff is
respected.

The HPET NMI is directed to one of the CPUs in the 'to be monitored'
mask. That CPU is known when this is [re-]configured. So this can be
changed to:

        seq = atomic_read(&hld.nmi_seq);
        if (seq == __this_cpu_read(hpet_wd_seq))
     		return;

        cpu = raw_smp_processor_id();
        if (cpu == hld.nmi_target) {
        	if (!hpet_hld_interrupt(...))
                	return;
        }
                
        next_cpu = cpumask_next_wrap(cpu, monitored_mask);
        if (next_cpu < nr_cpu_ids) {
                if (cpu == hld.nmi_target)
               	      atomic_inc(&hld.nmi_seq);
                apic->send_IPI(next_cpu, NMI_VECTOR);
	}
        __this_cpu_write(hpet_wd_seq, seq);

        watchdog_hardlockup_check();

which has the following downside:

      It requires x2APIC because xAPIC has this two stage ICR dance,
      which is not NMI safe and only to be used if there is no other
      choice, i.e. backtrace trigger from NMI context.

but the following upsides:

    1) The fast path quick check is a trivial memory read/cmp

       It is always dropping through for the NMI target CPUn as that has
       to check for the timing window. 

       For the other CPUs it only becomes true when the NMI target CPU
       incremented the sequence counter and sent a NMI to the next one.

    2) Propagating the NMI through the monitored mask avoids the whole
       limitation vs. the shorthand setup, which means the watchdog can
       be enabled early on.

       This also allows to use it in isolation scenarios.

Restricting this to x2APIC is in my opinion reasonable as the people who
crave for the lost PMC are surely not those who use 8 CPU machines from
two decades ago.

Thanks,

        tglx

