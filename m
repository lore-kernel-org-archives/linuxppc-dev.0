Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673BEC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:38:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0CB2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="FkvY/woe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0CB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJSX59ytzF3LS
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="FkvY/woe";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RJL5705fzF3Rn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 15:32:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="FkvY/woe"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RJL55x10z9s4s; Fri,  5 Oct 2018 15:32:29 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42RJL55Fgbz9s55; Fri,  5 Oct 2018 15:32:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538717549; bh=Ya4qkTFX5zVVlsv+x8GI/9uAk/hGa8K/cpoMf927+zU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FkvY/woe+3JL5rKLQ+Cj/G4/KEK97zvsmX3Wv9BRoUmdhBKashF0LhWbvsh0Dyh4B
 I6x0ojLhfkAzQ40HxX6M87OprA5yPdU7j3C1nuXk+Jjd4eaVCMIJ1mUDJr6WX7i48e
 eEHqeYg+93bt/qNKcBlON71fqldHiCNZM0FS9FgL0s5RlnPI/6TUq63D8aIsFXKHVE
 HawfPI60VRET6bUOP00fC93OirM9TdUsNDuK6hB4BIWylG9uwTO9FuXCVqVKDCz5Lr
 sGLxQWhAsouCZ47wLY0J/sQasQC2UU4MV7iq9BaFmA+QjjGs5fV0wWcVP4hY1z04Cp
 TYa47r6/P2lVg==
Date: Fri, 5 Oct 2018 15:32:26 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested
 vcpu moves physical cpu
Message-ID: <20181005053226.GB3309@fergus>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
 <20181005040908.GK7004@umbus.fritz.box>
 <20181005042350.GA3309@fergus>
 <20181005045428.GO7004@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005045428.GO7004@umbus.fritz.box>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 05, 2018 at 02:54:28PM +1000, David Gibson wrote:
> On Fri, Oct 05, 2018 at 02:23:50PM +1000, Paul Mackerras wrote:
> > On Fri, Oct 05, 2018 at 02:09:08PM +1000, David Gibson wrote:
> > > On Thu, Oct 04, 2018 at 09:56:02PM +1000, Paul Mackerras wrote:
> > > > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > > 
> > > > This is only done at level 0, since only level 0 knows which physical
> > > > CPU a vcpu is running on.  This does for nested guests what L0 already
> > > > did for its own guests, which is to flush the TLB on a pCPU when it
> > > > goes to run a vCPU there, and there is another vCPU in the same VM
> > > > which previously ran on this pCPU and has now started to run on another
> > > > pCPU.  This is to handle the situation where the other vCPU touched
> > > > a mapping, moved to another pCPU and did a tlbiel (local-only tlbie)
> > > > on that new pCPU and thus left behind a stale TLB entry on this pCPU.
> > > > 
> > > > This introduces a limit on the the vcpu_token values used in the
> > > > H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.
> > > 
> > > This does make the vcpu tokens no longer entirely opaque to the L0.
> > > It works for now, because the only L1 is Linux and we know basically
> > > how it allocates those tokens.  Eventually we probably want some way
> > > to either remove this restriction or to advertise the limit to the L1.
> > 
> > Right, we could use something like a hash table and have it be
> > basically just as efficient as the array when the set of IDs is dense
> > while also handling arbitrary ID values.  (We'd have to make sure that
> > L1 couldn't trigger unbounded memory consumption in L0, though.)
> 
> Another approach would be to sacifice some performance for L0
> simplicity:  when an L1 vCPU changes pCPU, flush all the nested LPIDs
> associated with that L1.  When an L2 vCPU changes L1 vCPU (and
> therefore, indirectly pCPU), the L1 would be responsible for flushing
> it.

That was one of the approaches I considered initially, but it has
complexities that aren't apparent, and it could be quite inefficient
for a guest with a lot of nested guests.  For a start you have to
provide a way for L1 to flush the TLB for another LPID, which guests
can't do themselves (it's a hypervisor privileged operation).  Then
there's the fact that it's not the pCPU where the moving vCPU has
moved to that needs the flush, it's the pCPU that it moved from (where
presumably something else is now running).  All in all, the simplest
solution was to have L0 do it, because L0 knows unambiguously the real
physical CPU where any given vCPU last ran.

Paul.
