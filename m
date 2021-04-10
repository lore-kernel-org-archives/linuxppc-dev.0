Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 16:53:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488D161105
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 16:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488D161105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHh034QGYz3bxw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 02:53:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FHgzh4s3Dz2xYh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 02:53:03 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13AGkG83008877;
 Sat, 10 Apr 2021 11:46:17 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 13AGkB0H008870;
 Sat, 10 Apr 2021 11:46:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 10 Apr 2021 11:46:11 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/traps: Enhance readability for trap types
Message-ID: <20210410164611.GI26583@gate.crashing.org>
References: <20210408140750.26832-1-sxwjean@me.com>
 <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu>
 <874kgfdmxq.fsf@mpe.ellerman.id.au>
 <f0a6713d-756c-86f2-636d-2a478bab9be4@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0a6713d-756c-86f2-636d-2a478bab9be4@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: pmladek@suse.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, kan.liang@linux.intel.com, mikey@neuling.org,
 maddy@linux.ibm.com, haren@linux.ibm.com, aik@ozlabs.ru, kjain@linux.ibm.com,
 ravi.bangoria@linux.ibm.com, john.ogness@linutronix.de, alistair@popple.id.au,
 npiggin@gmail.com, jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
 Xiongwei Song <sxwjean@me.com>, Xiongwei Song <sxwjean@gmail.com>,
 oleg@redhat.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 10, 2021 at 11:42:41AM +0200, Christophe Leroy wrote:
> Le 10/04/2021 à 02:04, Michael Ellerman a écrit :
> >I think these can all be avoided by defining most of the values
> >regardless of what platform we're building for. Only the values that
> >overlap need to be kept behind an ifdef.
> 
> Even if values overlap we can keep multiple definitions for the same value.

That works, but it can lead to puzzling bugs.  Of course we all *like*
working on more challenging bugs, but :-)


Segher
