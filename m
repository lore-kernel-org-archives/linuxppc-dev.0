Return-Path: <bernhard@bwalle.de>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
	[80.67.18.15]) by ozlabs.org (Postfix) with ESMTP id B6DA9B6EF4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 06:02:56 +1100 (EST)
Message-ID: <4B0D7CF4.8040402@bwalle.de>
Date: Wed, 25 Nov 2009 19:52:36 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
To: mohan@in.ibm.com
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com>
In-Reply-To: <20091125131747.GA28857@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

M. Mohan Kumar schrieb:
> Reserve memory for kdump kernel within RMO region
> 
> When the kernel size exceeds 32MB(observed with some distros), memory
> for kdump kernel can not be reserved as kdump kernel base is assumed to
> be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
> provide the feature to reserve the memory for kdump kernel anywhere in
> the RMO region.

Correct me if I'm wrong, but: CONFIG_RELOCATABLE is for the kernel that
gets loaded as crashkernel, not for the kernel that loads the
crashkernel. So it would be perfectly fine that a kernel that has not
CONFIG_RELOCATABLE set would load another kernel that has
CONFIG_RELOCATABLE set on an address != 32 M.

So it would be part of the command line to determine whether a fixed or
a variable address is used. The system configuration (or the admin)
knows both: if the kernel that should be loaded is relocatable (can be
detected with the x86 bzImage header or with the ELF type for vmlinux)
and it can also influence the boot command line.

To sum it up: I'm not against reserving it anywhere, I'm only against
making it dependent on CONFIG_RELOCATABLE which has another function.



Regards,
Bernhard
