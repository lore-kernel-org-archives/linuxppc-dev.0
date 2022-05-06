Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B30DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 May 2022 19:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kw1NX6Y1Qz3cCJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 May 2022 05:49:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HioOdTso;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PhVvmh62;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=HioOdTso; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=PhVvmh62; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kw1Mq6X5Sz3bs0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2022 05:48:39 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651866508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
 b=HioOdTsoFc6QL4Q5ukxv+Ntea8dHeHBk4X2FT+oa3bbwVlhaaalijyMz3Ud42vI0Xz+Pm5
 5uNcxKXmjg9OVSDh0Dt4tYZQOtxWfVFjjhHrSpCQezPQxTgdp4FY13dtV9rXwDevFIpXv6
 muaKmsTE1yrW4JvMj8a2VNOKwIw/8hiF4TH9d66KAra9PGXIcwgS+d6jJ9pIjFAO9TVsmJ
 7WIXTpeAKzbt2/hokUTls/YOcFf5INx190TqnegdhNw+Iz7enysvt7LGD9aYjh0IdLT2O1
 F9KOHoFhYxx5YN++nCtmpnJKTcTtL7nhOGwRsnjxvDLfRK1XRQCtPb9oaZBu4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651866508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
 b=PhVvmh62AnNYLXZZs9XTvL0zSLIZOMjOmiHCiiYPPKnVJ9DouHuXu7vrlN828CvNAlUl2q
 /dCD5SBWUsoH+LDA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the
 best CPU for new vectors
In-Reply-To: <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 21:48:28 +0200
Message-ID: <878rreh27n.ffs@tglx>
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
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Joerg Roedel <joro@8bytes.org>, Ricardo Neri <ricardo.neri@intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ricardo,

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Certain types of interrupts, such as NMI, do not have an associated vector.
> They, however, target specific CPUs. Thus, when assigning the destination
> CPU, it is beneficial to select the one with the lowest number of
> vectors.

Why is that beneficial especially in the context of a NMI watchdog which
then broadcasts the NMI to all other CPUs?

That's wishful thinking perhaps, but I don't see any benefit at all.

> Prepend the functions matrix_find_best_cpu_managed() and
> matrix_find_best_cpu_managed()

The same function prepended twice becomes two functions :)

> with the irq_ prefix and expose them for
> IRQ controllers to use when allocating and activating vector-less IRQs.

There is no such thing like a vectorless IRQ. NMIs have a vector. Can we
please describe facts and not pulled out of thin air concepts which do
not exist?

Thanks,

        tglx
