Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E8C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:31:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732122084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="sJhqTcOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732122084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJKK3Tj1zF3TM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:31:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="sJhqTcOW";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGpy6MlBzF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:23:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="sJhqTcOW"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGpy5PkXz9s3Z; Fri,  5 Oct 2018 14:23:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42RGpy4n1wz9s4V; Fri,  5 Oct 2018 14:23:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538713434; bh=okP6t4INvhrvYGKvfbhOtSEuqnMV8hy1hEeoeeOYX38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sJhqTcOWgfnXREhuDFFMJ/sUo3Jdw26EJZOrM4EN59cMww4wEZJjVfQgViGpelWDG
 iV3V23H5CiCUJ6FUjf8+cgmqcW9ZQZaWc8y+WeLbw/xbZocv+jSuQNBspxHwmktGyo
 ROcCTdSiQ5gO5i/osgbDA75e3IVk24aah934XaM3EzegWGyJn3EGt/eIbRXhyiloLR
 Qh79P5C59kVvCqUdvnruyi0ThJgJDZ84cWlpsV2ow0oUOPcM8aKWH/L+VhpXZhPqRF
 twWTcWXx1GmfWqeQ/FRaRqXOJ4OopPmhLIqe5OEQ7szcdJVE/UYUjv+hf3zKsCPLXC
 uBUB683DJJeng==
Date: Fri, 5 Oct 2018 14:23:50 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested
 vcpu moves physical cpu
Message-ID: <20181005042350.GA3309@fergus>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
 <20181005040908.GK7004@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005040908.GK7004@umbus.fritz.box>
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

On Fri, Oct 05, 2018 at 02:09:08PM +1000, David Gibson wrote:
> On Thu, Oct 04, 2018 at 09:56:02PM +1000, Paul Mackerras wrote:
> > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > 
> > This is only done at level 0, since only level 0 knows which physical
> > CPU a vcpu is running on.  This does for nested guests what L0 already
> > did for its own guests, which is to flush the TLB on a pCPU when it
> > goes to run a vCPU there, and there is another vCPU in the same VM
> > which previously ran on this pCPU and has now started to run on another
> > pCPU.  This is to handle the situation where the other vCPU touched
> > a mapping, moved to another pCPU and did a tlbiel (local-only tlbie)
> > on that new pCPU and thus left behind a stale TLB entry on this pCPU.
> > 
> > This introduces a limit on the the vcpu_token values used in the
> > H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.
> 
> This does make the vcpu tokens no longer entirely opaque to the L0.
> It works for now, because the only L1 is Linux and we know basically
> how it allocates those tokens.  Eventually we probably want some way
> to either remove this restriction or to advertise the limit to the L1.

Right, we could use something like a hash table and have it be
basically just as efficient as the array when the set of IDs is dense
while also handling arbitrary ID values.  (We'd have to make sure that
L1 couldn't trigger unbounded memory consumption in L0, though.)

Paul.


