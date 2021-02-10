Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1498CC433E6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:28:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EA764DC3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EA764DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbMZC5qyVzDrWX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:28:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYQ1VhzzDshb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYN4ZGVz9sW8; Wed, 10 Feb 2021 23:57:43 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
In-Reply-To: <20201103043523.916109-1-oohall@gmail.com>
References: <20201103043523.916109-1-oohall@gmail.com>
Subject: Re: [PATCH 01/18] powerpc/pci: Add ppc_md.discover_phbs()
Message-Id: <161296170638.3178259.9042764630687204810.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:43 +1100 (AEDT)
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
Cc: Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 3 Nov 2020 15:35:06 +1100, Oliver O'Halloran wrote:
> On many powerpc platforms the discovery and initalisation of
> pci_controllers (PHBs) happens inside of setup_arch(). This is very early
> in boot (pre-initcalls) and means that we're initialising the PHB long
> before many basic kernel services (slab allocator, debugfs, a real ioremap)
> are available.
> 
> On PowerNV this causes an additional problem since we map the PHB registers
> with ioremap(). As of commit d538aadc2718 ("powerpc/ioremap: warn on early
> use of ioremap()") a warning is printed because we're using the "incorrect"
> API to setup and MMIO mapping in searly boot. The kernel does provide
> early_ioremap(), but that is not intended to create long-lived MMIO
> mappings and a seperate warning is printed by generic code if
> early_ioremap() mappings are "leaked."
> 
> [...]

Applied to powerpc/next.

[01/18] powerpc/pci: Add ppc_md.discover_phbs()
        https://git.kernel.org/powerpc/c/5537fcb319d016ce387f818dd774179bc03217f5
[02/18] powerpc/pci: Move PHB discovery for PCI_DN using platforms
        https://git.kernel.org/powerpc/c/fbbefb320214db14c3e740fce98e2c95c9d0669b
[03/18] powerpc/maple: Move PHB discovery
        (squashed into 2)
[04/18] powerpc/512x: Move PHB discovery
        https://git.kernel.org/powerpc/c/893586ec949d3e48573a585c26bf04998fea6e1f
[05/18] powerpc/52xx/efika: Move PHB discovery
        https://git.kernel.org/powerpc/c/eab3166f4eac384b48ebd2ed7b61dc465c1912cf
[06/18] powerpc/52xx/lite5200: Move PHB discovery
        https://git.kernel.org/powerpc/c/e0bf9de2242a31a8f79015376ed08c4efe74774a
[07/18] powerpc/52xx/media5200: Move PHB discovery
        https://git.kernel.org/powerpc/c/ba5087622a0f11c8d3c6587392ebc70f96503e51
[08/18] powerpc/52xx/mpc5200_simple: Move PHB discovery
        https://git.kernel.org/powerpc/c/a760cfd9cfa2193961d7e599f46fbfe2498c400a
[09/18] powerpc/82xx/*: Move PHB discovery
        https://git.kernel.org/powerpc/c/3c82a6aecd367bbbe7876c406cd3e12b5b0e4204
[10/18] powerpc/83xx: Move PHB discovery
        https://git.kernel.org/powerpc/c/83f84041ff1cf6c23fc38861218af2d4ca2d9b38
[11/18] powerpc/amigaone: Move PHB discovery
        https://git.kernel.org/powerpc/c/053d58c870298d62b9c5154672ef2f1684c4ea43
[12/18] powerpc/chrp: Move PHB discovery
        https://git.kernel.org/powerpc/c/407d418f2fd4c20aa8ca1cf4168a414d77766852
[13/18] powerpc/embedded6xx/holly: Move PHB discovery
        https://git.kernel.org/powerpc/c/08c4738254b87117c69816d8033dd25f38185f92
[14/18] powerpc/embedded6xx/linkstation: Move PHB discovery
        https://git.kernel.org/powerpc/c/daa6c24780c15f4abcb76a9d426142beff9f62c6
[15/18] powerpc/embedded6xx/mpc7448: Move PHB discovery
        https://git.kernel.org/powerpc/c/748770aeb44108ecb4e09d273e7718611cd60a98
[16/18] powerpc/embedded6xx/mve5100: Move PHB discovery
        https://git.kernel.org/powerpc/c/d20a864f434b277b245ac6508920d90a48f6155d
[17/18] powerpc/pasemi: Move PHB discovery
        https://git.kernel.org/powerpc/c/c144bc719234500e292c0545de99822bd8a78a6b
[18/18] powerpc/powermac: Move PHB discovery
        (squashed into 2)

cheers
