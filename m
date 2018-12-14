Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F1C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 00:35:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF7E2075B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 00:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF7E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GBRZ6RYgzDr7L
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:35:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GBPL5nHQzDqxD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 11:33:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43GBPL39Tdz9sBZ;
 Fri, 14 Dec 2018 11:33:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 2/2] powerpc/pseries: Add debugfs interface to retrieve
 VPHN info
In-Reply-To: <1544698314.ofwuo2zvuf.naveen@linux.ibm.com>
References: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
 <e308130fe45a8930743cec9aba83d4885ac8d30d.1544459267.git.naveen.n.rao__35218.1831411601$1544472513$gmane$org@linux.ibm.com>
 <1544698314.ofwuo2zvuf.naveen@linux.ibm.com>
Date: Fri, 14 Dec 2018 11:33:56 +1100
Message-ID: <871s6lvte3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Naveen,

"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> writes:
> Hi Michael,
>
> Naveen N. Rao wrote:
>> Add debugfs interface to retrieve associativity information for lpar
>> vcpus (debugfs/vphn/lpar) and the hypervisor cpus (debugfs/vphn/hyp).
>> This information is useful to derive various metrics, including the vcpu
>> dispatch statistics in a SPLPAR environment.
>
> Any thoughts on this approach vs. adding a tracepoint?

Sorry I've been unresponsive on this stuff, I don't know this area that
well.

I guess I'm not opposed to adding some stuff to debugfs, but only if
it's for debugging.

We don't want customers running tools or scripts that rely on this stuff
in debugfs.

If we need to expose more information to be used by production tools
then I think we need to look at sysfs or something like taskstats as a
proper API.

cheers
