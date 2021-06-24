Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10926C49EA6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:04:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5BC613EC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5BC613EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9hhW20l2z3c6n
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 00:04:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9hh8183Nz306P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 00:04:08 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G9hh66gyWz9sVm; Fri, 25 Jun 2021 00:04:06 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, Haren Myneni <haren@linux.ibm.com>,
 herbert@gondor.apana.org.au, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
In-Reply-To: <827bf56dce09620ebecd8a00a5f97105187a6205.camel@linux.ibm.com>
References: <827bf56dce09620ebecd8a00a5f97105187a6205.camel@linux.ibm.com>
Subject: Re: [PATCH v6 00/17] Enable VAS and NX-GZIP support on PowerVM
Message-Id: <162454339513.2931445.11540292090564537199.b4-ty@ellerman.id.au>
Date: Fri, 25 Jun 2021 00:03:15 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Jun 2021 13:24:31 -0700, Haren Myneni wrote:
> Virtual Accelerator Switchboard (VAS) allows kernel subsystems
> and user space processes to directly access the Nest Accelerator
> (NX) engines which provides HW compression. The true user mode
> VAS/NX support on PowerNV is already included in Linux. Whereas
> PowerVM support is available from P10 onwards.
> 
> This patch series enables VAS / NX-GZIP on PowerVM which allows
> the user space to do copy/paste with the same existing interface
> that is available on PowerNV.
> 
> [...]

Applied to powerpc/next.

[01/17] powerpc/powernv/vas: Release reference to tgid during window close
        https://git.kernel.org/powerpc/c/91cdbb955aa94ee0841af4685be40937345d29b8
[02/17] powerpc/vas: Move VAS API to book3s common platform
        https://git.kernel.org/powerpc/c/413d6ed3eac387a2876893c337174f0c5b99d01d
[03/17] powerpc/powernv/vas: Rename register/unregister functions
        https://git.kernel.org/powerpc/c/06c6fad9bfe0b6439e18ea1f1cf0d178405ccf25
[04/17] powerpc/vas: Add platform specific user window operations
        https://git.kernel.org/powerpc/c/1a0d0d5ed5e3cd9e3fc1ad4459f1db2f3618fce0
[05/17] powerpc/vas: Create take/drop pid and mm reference functions
        https://git.kernel.org/powerpc/c/3856aa542d90ed79cd5ed4cfd828b1fb04017131
[06/17] powerpc/vas: Move update_csb/dump_crb to common book3s platform
        https://git.kernel.org/powerpc/c/3b26797350352479f37216d674c8e5d126faab66
[07/17] powerpc/vas: Define and use common vas_window struct
        https://git.kernel.org/powerpc/c/7bc6f71bdff5f8921e324da0a8fad6f4e2e63a85
[08/17] powerpc/pseries/vas: Define VAS/NXGZIP hcalls and structs
        https://git.kernel.org/powerpc/c/8f3a6c92802b7c48043954ba3b507e9b33d8c898
[09/17] powerpc/vas: Define QoS credit flag to allocate window
        https://git.kernel.org/powerpc/c/540761b7f51067d76b301c64abc50328ded89b1c
[10/17] powerpc/pseries/vas: Add hcall wrappers for VAS handling
        https://git.kernel.org/powerpc/c/f33ecfde30ce6909fff41339285e0274bb403fb8
[11/17] powerpc/pseries/vas: Implement getting capabilities from hypervisor
        https://git.kernel.org/powerpc/c/ca77d48854177bb9749aef7329201f03b2382fbb
[12/17] powerpc/pseries/vas: Integrate API with open/close windows
        https://git.kernel.org/powerpc/c/b22f2d88e435cdada32581ca1f11b9806adf459a
[13/17] powerpc/pseries/vas: Setup IRQ and fault handling
        https://git.kernel.org/powerpc/c/6d0aaf5e0de00491de136f387ebed55604cedebe
[14/17] crypto/nx: Rename nx-842-pseries file name to nx-common-pseries
        https://git.kernel.org/powerpc/c/7da00b0e71334aa1e3d8db1cc1f40eb47cb1e188
[15/17] crypto/nx: Get NX capabilities for GZIP coprocessor type
        https://git.kernel.org/powerpc/c/b4ba22114c78de48fda3818f569f75e97d58c719
[16/17] crypto/nx: Add sysfs interface to export NX capabilities
        https://git.kernel.org/powerpc/c/8c099490fd2bd3b012b3b6d0babbba3b90e69b55
[17/17] crypto/nx: Register and unregister VAS interface on PowerVM
        https://git.kernel.org/powerpc/c/99cd49bb39516d1beb1c38ae629b15ccb923198c

cheers
