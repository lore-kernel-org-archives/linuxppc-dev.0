Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F37C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 04:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A708E20878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 04:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="brJNEJyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708E20878
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pn791TsczDqY1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 14:16:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pn5N4gX2zDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 14:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="brJNEJyP"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 44pn5N0Dd1z9s4Y; Wed, 24 Apr 2019 14:14:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1556079272; bh=W1/qmFGLsuafhYkiCT1Qga7YKZtoh45yn3OyEMv9tFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=brJNEJyP8JVYAlZ6ckPNhzUBOYJgAsuzkEVTldQTt0VtSBm74xEJ6hkCaxGdaT6n9
 wptpmuhLNCq7tgP7cj0Z5umCrY5Pj1Y9Fe5WyzuQH0MeN/xrldM3bNQfckerkVILfk
 VF1qjiM0cj9Y7ouTh+JQPe6vpuCeI7CBHGZGRx7nOA2O3Yzi/NHmF1mmLRfr61jDBN
 MATWV1mc2qh0LdoQT7jXMKTATQpg+rG1uAtTW2T1UNfgYpuwhGk/21imZFW6YpSSAK
 zkbvOEIqoowoC8oBgp6XIthBMdlB6PxT8Pq07Sfq6agPoOqLiL0HX9vmUSTtnD5D7X
 cBr38Z+CXL8lA==
Date: Wed, 24 Apr 2019 14:14:23 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] KVM: PPC: Report single stepping capability
Message-ID: <20190424041423.frikbrby4e2hvkz7@oak.ozlabs.ibm.com>
References: <20190320183951.29537-1-farosas@linux.ibm.com>
 <20190320183951.29537-2-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320183951.29537-2-farosas@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, aik@ozlabs.ru,
 kvm-ppc@vger.kernel.org, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 03:39:50PM -0300, Fabiano Rosas wrote:
> When calling the KVM_SET_GUEST_DEBUG ioctl, userspace might request
> the next instruction to be single stepped via the
> KVM_GUESTDBG_SINGLESTEP control bit of the kvm_guest_debug structure.
> 
> We currently don't have support for guest single stepping implemented
> in Book3S HV.
> 
> This patch adds the KVM_CAP_PPC_GUEST_DEBUG_SSTEP capability in order
> to inform userspace about the state of single stepping support.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 5 +++++
>  include/uapi/linux/kvm.h   | 1 +
>  2 files changed, 6 insertions(+)

I assume since this is [RFC] that you're not expecting it to go
upstream as-is.  If it were to go upstream it would need to include an
update to Documentation/virtual/kvm/api.txt.

Paul.
