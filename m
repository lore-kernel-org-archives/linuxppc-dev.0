Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AF5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 10:19:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lg5jF5ynYz3f4r
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 20:19:13 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lg5gz0D5yz30Lp
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2022 20:18:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lg5gy4bRQz4xv5;
	Sat,  9 Jul 2022 20:18:06 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20220525130554.2614394-1-farosas@linux.ibm.com>
References: <20220525130554.2614394-1-farosas@linux.ibm.com>
Subject: Re: [PATCH 0/5] KVM: PPC: Book3S HV: Update debug timing code
Message-Id: <165736166828.12236.1106310523445235191.b4-ty@ellerman.id.au>
Date: Sat, 09 Jul 2022 20:14:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: kvm-ppc@vger.kernel.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 25 May 2022 10:05:49 -0300, Fabiano Rosas wrote:
> We have some debug information at /sys/kernel/debug/kvm/<vm>/vcpu#/timings
> which shows the time it takes to run various parts of the code.
> 
> That infrastructure was written in the P8 timeframe and wasn't updated
> along with the guest entry point changes for P9.
> 
> Ideally we would be able to just add new/different accounting points
> to the code as it changes over time but since the P8 and P9 entry
> points are different code paths we first need to separate them from
> each other. This series alters KVM Kconfig to make that distinction.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/5] KVM: PPC: Book3S HV: Fix "rm_exit" entry in debugfs timings
      https://git.kernel.org/powerpc/c/9981bace85d816ed8724ac46e49285e8488d29e6
[2/5] KVM: PPC: Book3S HV: Add a new config for P8 debug timing
      https://git.kernel.org/powerpc/c/3f8ed993be3cf154a91d9ab5e80470c6c755adbe
[3/5] KVM: PPC: Book3S HV: Decouple the debug timing from the P8 entry path
      https://git.kernel.org/powerpc/c/c3fa64c99c61d99631a8e06a6cf991c35c98ec7d
[4/5] KVM: PPC: Book3S HV: Expose timing functions to module code
      https://git.kernel.org/powerpc/c/2861c827286fb6646f6b6caee418efd99992097c
[5/5] KVM: PPC: Book3S HV: Provide more detailed timings for P9 entry path
      https://git.kernel.org/powerpc/c/b44bb1b7cbbae66ec73868f5fbd57c54f0612d1c

cheers
