Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B800CC7618D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 00:30:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsMqF35R1z3g4N
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 10:30:49 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsMpk1ybsz3bbX
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 10:30:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMpk0bdtz4wgv;
	Thu,  6 Apr 2023 10:30:22 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
In-Reply-To: <20230310050834.63105-1-ruscur@russell.cc>
References: <20230310050834.63105-1-ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/mm: Fix false detection of read faults
Message-Id: <168074094283.3668270.12207993499305412796.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 10:29:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Michal Suchánek <msuchanek@suse.de>, Benjamin Gray <bgray@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 Mar 2023 16:08:34 +1100, Russell Currey wrote:
> To support detection of read faults with Radix execute-only memory, the
> vma_is_accessible() check in access_error() (which checks for PROT_NONE)
> was replaced with a check to see if VM_READ was missing, and if so,
> returns true to assert the fault was caused by a bad read.
> 
> This is incorrect, as it ignores that both VM_WRITE and VM_EXEC imply
> read on powerpc, as defined in protection_map[].  This causes mappings
> containing VM_WRITE or VM_EXEC without VM_READ to misreport the cause of
> page faults, since the MMU is still allowing reads.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix false detection of read faults
      https://git.kernel.org/powerpc/c/f2c7e3562b4c4f1699acc1538ebf3e75f5cced35

cheers
