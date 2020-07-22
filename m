Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31DC433F4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 02:25:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B80207BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 02:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B80207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBK7j2my7zDqfM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 12:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=76.164.61.194; helo=kernel.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBK5T3T3FzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 12:23:41 +1000 (AEST)
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06M2N9le018584
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2020 21:23:17 -0500
Message-ID: <882f86756e78365c62f9ec2c57ef19744e0a3737.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/pseries/svm: capture instruction faulting
 on MMIO access, in sprg0 register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Jul 2020 12:23:03 +1000
In-Reply-To: <875zags3qp.fsf@mpe.ellerman.id.au>
References: <1594888333-9370-1-git-send-email-linuxram@us.ibm.com>
 <875zags3qp.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: sukadev@linux.vnet.ibm.com, aik@ozlabs.ru, bharata@linux.ibm.com,
 sathnaga@linux.vnet.ibm.com, ldufour@linux.ibm.com, bauerman@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-07-22 at 12:06 +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > An instruction accessing a mmio address, generates a HDSI fault.  This fault is
> > appropriately handled by the Hypervisor.  However in the case of secureVMs, the
> > fault is delivered to the ultravisor.
> > 
> > Unfortunately the Ultravisor has no correct-way to fetch the faulting
> > instruction. The PEF architecture does not allow Ultravisor to enable MMU
> > translation. Walking the two level page table to read the instruction can race
> > with other vcpus modifying the SVM's process scoped page table.
> 
> You're trying to read the guest's kernel text IIUC, that mapping should
> be stable. Possibly permissions on it could change over time, but the
> virtual -> real mapping should not.

This will of course no longer work if userspace tries to access MMIO
but as long as you are ok limiting MMIO usage to the kernel, that's one
way.

iirc MMIO emulation in KVM on powerpc already has that race because of
HW TLB inval broadcast and it hasn't hurt anybody ... so far.

> > This problem can be correctly solved with some help from the kernel.
> > 
> > Capture the faulting instruction in SPRG0 register, before executing the
> > faulting instruction. This enables the ultravisor to easily procure the
> > faulting instruction and emulate it.
> 
> This is not something I'm going to merge. Sorry.

Another approach is to have the guest explicitly switch to using UV
calls for MMIO.

Cheers,
Ben.


