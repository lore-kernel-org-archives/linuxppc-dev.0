Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C30C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDD961260
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDD961260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5mBh5t7wz3fT3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 14:28:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5m4L1bb6z3c4f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 14:22:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5m4J5cQ5z9sj1; Fri, 18 Jun 2021 14:22:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, jniethe5@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
Message-Id: <162398829384.1363949.8760283426768827075.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:51:33 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 20 May 2021 13:50:37 +0000 (UTC), Christophe Leroy wrote:
> This series is a cleanup of the use of 'struct ppc_inst'.
> 
> A confusion is made between internal representation of powerpc
> instructions with 'struct ppc_inst' and in-memory code which is
> and will always be an array of 'unsigned int'.
> 
> This series cleans it up.
> 
> [...]

Applied to powerpc/next.

[01/12] powerpc/inst: Fix sparse detection on get_user_instr()
        https://git.kernel.org/powerpc/c/b3a9e523237013477bea914b7fbfbe420428b988
[02/12] powerpc/inst: Reduce casts in get_user_instr()
        https://git.kernel.org/powerpc/c/9134806e149ebb214f122f0f84254096d3768bb2
[03/12] powerpc/inst: Improve readability of get_user_instr() and friends
        https://git.kernel.org/powerpc/c/042e0860e1c1d60a0ab1ff3f16b7f420573133e0
[04/12] powerpc/inst: Avoid pointer dereferencing in ppc_inst_equal()
        https://git.kernel.org/powerpc/c/036b5560bebc72c61d955ae0b115e8e69da8a563
[05/12] powerpc: Do not dereference code as 'struct ppc_inst' (uprobe, code-patching, feature-fixups)
        https://git.kernel.org/powerpc/c/18c85964b10b7b78a5cb59a4959a5f82fdc77e4c
[06/12] powerpc/lib/code-patching: Make instr_is_branch_to_addr() static
        https://git.kernel.org/powerpc/c/6c0d181daabcba286db9711eef8800b566fb1cce
[07/12] powerpc/lib/code-patching: Don't use struct 'ppc_inst' for runnable code in tests.
        https://git.kernel.org/powerpc/c/e90a21ea801d1776d9a786ad02354fd3fe23ce09
[08/12] powerpc: Don't use 'struct ppc_inst' to reference instruction location
        https://git.kernel.org/powerpc/c/69d4d6e5fd9f4e805280ad831932c3df7b9d7cc7
[09/12] powerpc/inst: Refactor PPC32 and PPC64 versions
        https://git.kernel.org/powerpc/c/077c4dedef09796ade917459a5330e3940fb5860
[10/12] powerpc/optprobes: Minimise casts
        https://git.kernel.org/powerpc/c/afd3287c8872142ec4298a2b77bd9077e2209c9c
[11/12] powerpc/optprobes: Compact code source a bit.
        https://git.kernel.org/powerpc/c/f38adf86ce4fdae84904f420e175ce5806509c4c
[12/12] powerpc/optprobes: use PPC_RAW_ macros
        https://git.kernel.org/powerpc/c/0e628ad2d60896de31148fba00cc73623b8c0aa1

cheers
