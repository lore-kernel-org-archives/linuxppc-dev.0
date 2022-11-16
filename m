Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF93C4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Nov 2022 17:09:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NC8fv6QLsz3fDd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Nov 2022 04:09:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YN9ryDJC;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GAWP5kCC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YN9ryDJC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GAWP5kCC;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NC8c76P07z3f6m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2022 04:07:19 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668618436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd/gKUYapNrdh0ZSm6QrYC6PPTCYxxulgG3RsV/ATaE=;
	b=YN9ryDJCC/rOCCbUcPXfjcQGAvLVHqYeD4VnXnvWk0GnhtJH/a8+axdLw1R7si8Asq7Wtm
	xmSPam/lkVBttAXhtYtNGErBXryQdJHhgSucQY5CQEAG5RjRF00VVJ7cGkoRrVPE0aTrOu
	z7rh0tYPNEfJkGWPbtVwM0gD4WU7Pj0nWFhvE5qltB+eq/UVeKZH3R+PIMuS4/5RSDHjDa
	1Cnp80V6+SGCEn3sb/SqF77dytylYbVDJGNkbSzhelSAv+xU/1SvdHsoD+1KGNrhPdueZQ
	r8D2HyQex1F7qKBhwnSmWPHO3TmAGkylb782rxLSci6kR9aYLUuK1rsViUdG8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668618436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd/gKUYapNrdh0ZSm6QrYC6PPTCYxxulgG3RsV/ATaE=;
	b=GAWP5kCC/f3/bXYJQ5IC8uOvwVhkdzvAb+untfep11uuS3PQT/MILH+iHWpVSwHDg1cMck
	GHc81CL3JRB22pAQ==
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to
 api.c
In-Reply-To: <20221116162322.GA1115421@bhelgaas>
References: <20221116162322.GA1115421@bhelgaas>
Date: Wed, 16 Nov 2022 18:07:16 +0100
Message-ID: <87h6yyq14r.ffs@tglx>
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
Cc: linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Jason Gunthorpe <jgg@mellanox.com>, Allen Hubbe <allenbh@gmail.com>, Kevin Tian <kevin.tian@intel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, Jon Mason <jdmason@kudzu.us>, linuxppc-dev@lists.ozlabs.org, Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 16 2022 at 10:23, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2022 at 02:54:51PM +0100, Thomas Gleixner wrote:
>> + * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
>> + * Check that function docs, and &struct irq_affinity, for more details.
>
> Is "&struct irq_affinity" some kernel-doc syntax, or is the "&"
> superfluous?

The latter.
