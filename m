Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B281C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:51:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4F72081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4F72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w9W0034JzDqS6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 18:51:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w9TH63KqzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 18:50:11 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x177nnDV012367;
 Thu, 7 Feb 2019 01:49:49 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x177nl68012366;
 Thu, 7 Feb 2019 01:49:47 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 7 Feb 2019 01:49:47 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/64s: Work around spurious warning on old gccs
 with -fsanitize-coverage
Message-ID: <20190207074947.GT14180@gate.crashing.org>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
 <20190207063736.GS14180@gate.crashing.org>
 <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <630e392b-e9a7-6b1e-e3d8-c5382f94e5d7@au1.ibm.com>
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
Cc: syzkaller@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 07, 2019 at 05:59:48PM +1100, Andrew Donnellan wrote:
> On 7/2/19 5:37 pm, Segher Boessenkool wrote:
> >On Thu, Feb 07, 2019 at 04:33:23PM +1100, Andrew Donnellan wrote:
> >>Some older gccs (<GCC 7), when invoked with -fsanitize-coverage=trace-pc,
> >>cause a spurious uninitialised variable warning in dt_cpu_ftrs.c:
> >>
> >>   arch/powerpc/kernel/dt_cpu_ftrs.c: In function 
> >>   ‘cpufeatures_process_feature’:
> >>   arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: ‘m’ may be used 
> >>   uninitialized in this function [-Wmaybe-uninitialized]
> >>     if (m->cpu_ftr_bit_mask)
> >
> >It seems to me the warning is correct?  If enable_unknown is false and no
> >cpu_feature is found, it will in
> >
> >	if (m->cpu_ftr_bit_mask)
> >		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
> >
> >enable random features (whatever was last in the table), or indeed access
> >via NULL if the table is length 0?  So maybe this should be
> >
> >	if (known && m->cpu_ftr_bit_mask)
> >		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
> >
> >instead?  (The code would be much clearer if all the known vs. !known
> >codepath was fully separated here).
> 
> The table is never length 0, it's a statically defined array.

Sure, and presumably that is why newer GCC doesn't warn.  But what about
the other point?  Is this code ever correct?  Enabling random features
(in cur_cpu_spec->cpu_features) when the name isn't found seems wrong.


Segher
