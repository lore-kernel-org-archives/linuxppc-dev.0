Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE0C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 12:47:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7v5q34r4z3chL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 23:47:27 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7v4z1HQ4z3bcm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2022 23:46:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v4z5sm4z4xvJ;
 Wed,  2 Mar 2022 23:46:43 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20220224182312.1012527-1-danielhb413@gmail.com>
References: <20220224182312.1012527-1-danielhb413@gmail.com>
Subject: Re: [PATCH] powerpc/mm/numa: skip NUMA_NO_NODE onlining in
 parse_numa_properties()
Message-Id: <164622490916.2052779.5554430866574249249.b4-ty@ellerman.id.au>
Date: Wed, 02 Mar 2022 23:41:49 +1100
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Diego Domingos <diegodo@linux.vnet.ibm.com>, Ping Fang <pifang@redhat.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 24 Feb 2022 15:23:12 -0300, Daniel Henrique Barboza wrote:
> Executing node_set_online() when nid = NUMA_NO_NODE results in an
> undefined behavior. node_set_online() will call node_set_state(), into
> __node_set(), into set_bit(), and since NUMA_NO_NODE is -1 we'll end up
> doing a negative shift operation inside
> arch/powerpc/include/asm/bitops.h. This potential UB was detected
> running a kernel with CONFIG_UBSAN.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm/numa: skip NUMA_NO_NODE onlining in parse_numa_properties()
      https://git.kernel.org/powerpc/c/749ed4a20657bcea66a6e082ca3dc0d228cbec80

cheers
