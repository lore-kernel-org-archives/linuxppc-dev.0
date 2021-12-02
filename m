Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB4C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Dec 2021 14:37:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4dnp5pcrz3cQY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Dec 2021 01:37:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.52; helo=mail-wr1-f52.google.com;
 envelope-from=wei.liu.linux@gmail.com; receiver=<UNKNOWN>)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J4dnK0Vh1z2ygB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Dec 2021 01:36:35 +1100 (AEDT)
Received: by mail-wr1-f52.google.com with SMTP id o13so59961768wrs.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Dec 2021 06:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xh3pKbxTnj8e62DOcRXknPoUROM+BODLvzmQyRbbH8s=;
 b=Ex7DpjvWTN9bOfeRMI9SsKZw0ttPcyestL5tYYBpstUeqUBdhtRD24BMmjHdHm6329
 wmMdVk+hSMFsRgz1m0KLDoMxdwqREI98BqlaB892rA+Qu/dO1QIkuhu/MVzv3Bj/Uh9R
 1xgsanFx6ouEXAk1tTAIZkIqP9OdI3C7h8yosJ9Xodv9GDdg6EFZBp4yus/E/mieWWG4
 PQLN8j2CA+jxE2c2p1zlqmJ84kst/hzvf72abDqHglS86RIeX4cIXFn7jCCtLXN6PZf3
 LVnW9h4L4jGBzTmCPV6Vz2Bn5IRvgkiiafOB/Tm5Iy1U/aU7cZKukg+NLNR2XmFNIZqp
 V9Mg==
X-Gm-Message-State: AOAM532ky55Q6MT4/g7zgndz4IQKgsSGrqQCYfsydgrpJ0ep+UNgfX6+
 9CdNHF/5ibhq3iRTJXDUlwI=
X-Google-Smtp-Source: ABdhPJwNpcGjwNKyiVWqPz1WBsz/Qi/GLv2M+5yPM20JS1pf2ye6xEbrzai84zM0oO2HmmRa7dC8TQ==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr15988721wrr.614.1638455790749; 
 Thu, 02 Dec 2021 06:36:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id q4sm2636132wrs.56.2021.12.02.06.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Dec 2021 06:36:29 -0800 (PST)
Date: Thu, 2 Dec 2021 14:36:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 11/22] x86/hyperv: Refactor hv_msi_domain_free_irqs()
Message-ID: <20211202143628.dgiikgujigylogoz@liuwe-devbox-debian-v2>
References: <20211126222700.862407977@linutronix.de>
 <20211126223824.737214551@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126223824.737214551@linutronix.de>
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
Cc: linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 ath11k@lists.infradead.org, Kevin Tian <kevin.tian@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Megha Dey <megha.dey@intel.com>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 27, 2021 at 02:18:51AM +0100, Thomas Gleixner wrote:
> No point in looking up things over and over. Just look up the associated
> irq data and work from there.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Wei Liu <wei.liu@kernel.org>
