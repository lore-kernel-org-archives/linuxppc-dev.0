Return-Path: <SRS0=Va0a=WT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F87C3A589
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 04:02:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5E22341F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 04:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="TiSuWrKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5E22341F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46F7534ypkzDrRJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 14:01:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46F72s5MB4zDrQX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2019 14:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TiSuWrKv"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 46F72s3mKsz9s7T; Fri, 23 Aug 2019 14:00:05 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 46F72s37ZNz9sBp; Fri, 23 Aug 2019 14:00:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1566532805; bh=mNtdsViEFCyavtDiwsHTDK9xXch9sH1Vg8FJtRYNWO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TiSuWrKvb8jY5ggylKlgo6MZ25p+tSAZtqIluxy8K+FsmhgL/OEBUqDzdVUnHfEAk
 YyMUpt1SNIyDCfVOon2irmWAbPfmMEfRRxw3VrmZDfyqMM7EZ9I4gJn7lK8LbTnh/A
 Q2srBonqZZYrUEHlsFv768NVLLI54CiaISYERWt+G4i2BJHYiulEO3/ztD2yz9eEAe
 ABTQGZp7QKhTXSaOrTX7PEnwrbvu9wt2SLBFpeORB77isa9x+yQuoIBjrvnnr3ZSYF
 hraIZKTnsRvoZqiGMBLReMsGnHuZZXKRYW12rcYgoDJ7nq+Cg3yAwWgvVf3q2O6hh3
 rItA7KzAHpyBA==
Date: Fri, 23 Aug 2019 13:59:58 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v6 7/7] powerpc/kvm: Use UV_RETURN ucall to return to
 ultravisor
Message-ID: <20190823035958.tqpdtck2pl3foq5i@oak.ozlabs.ibm.com>
References: <20190822034838.27876-1-cclaudio@linux.ibm.com>
 <20190822034838.27876-8-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822034838.27876-8-cclaudio@linux.ibm.com>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Ryan Grimm <grimm@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Guerney Hunt <gdhh@linux.ibm.com>, Thiago Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 22, 2019 at 12:48:38AM -0300, Claudio Carvalho wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> When an SVM makes an hypercall or incurs some other exception, the
> Ultravisor usually forwards (a.k.a. reflects) the exceptions to the
> Hypervisor. After processing the exception, Hypervisor uses the
> UV_RETURN ultracall to return control back to the SVM.
> 
> The expected register state on entry to this ultracall is:
> 
> * Non-volatile registers are restored to their original values.
> * If returning from an hypercall, register R0 contains the return value
>   (unlike other ultracalls) and, registers R4 through R12 contain any
>   output values of the hypercall.
> * R3 contains the ultracall number, i.e UV_RETURN.
> * If returning with a synthesized interrupt, R2 contains the
>   synthesized interrupt number.

This isn't accurate: R2 contains the value that should end up in SRR1
when we are back in the secure guest.  HSRR0 and HSRR1 contain the
instruction pointer and MSR that the guest should run with.  They may
be different from the instruction pointer and MSR that the guest vCPU
last had, if the hypervisor has synthesized an interrupt for the
guest.  The ultravisor needs to detect this case and respond
appropriately.

> Thanks to input from Paul Mackerras, Ram Pai and Mike Anderson.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>

Apart from that comment on the patch description -

Acked-by: Paul Mackerras <paulus@ozlabs.org>
