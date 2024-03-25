Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B186FC54E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2024 21:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3Qxh2fPsz3vXx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2024 08:27:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3QxF2Xmbz3cBG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2024 08:26:56 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 42PLNSwl017539;
	Mon, 25 Mar 2024 16:23:28 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 42PLNQcP017538;
	Mon, 25 Mar 2024 16:23:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 25 Mar 2024 16:23:26 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: Appropriate liburcu cache line size for Power
Message-ID: <20240325212326.GD19790@gate.crashing.org>
References: <19c3ea76-9e05-4552-8b93-6c42df105747@efficios.com> <87jzlqqcdl.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzlqqcdl.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
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
Cc: paulmck <paulmck@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Nicholas Piggin <npiggin@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2024 at 03:34:30PM -0500, Nathan Lynch wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> For what it's worth, I found a copy of an IBM Journal of Research &
> Development article confirming that POWER5's L3 had a 256-byte line
> size:
> 
>   Each slice [of the L3] is 12-way set-associative, with 4,096
>   congruence classes of 256-byte lines managed as two 128-byte sectors
>   to match the L2 line size.
> 
> https://www.eecg.utoronto.ca/~moshovos/ACA08/readings/power5.pdf
> 
> I don't know of any reason to prefer 256 over 128 for current Power
> processors though.

The reason some old CPUs use bigger physical cache line sizes is to have
fewer cache lines, which speeds up lookup, or reduces power consumption
of lookup, or both.  This isn't trivial at all when implemented as a
parallel read and compare of all tags, which was the usual way to do
things long ago.

Nowadays usually a way predictor is used, severely limiting the number
of tags to be compared.  So we can use a 128B physical line size always
now.  Note that this was physical only, everything looked like 128B on
a P5 system as well.

P5 wasn't first like this fwiw, look at the L2 on a 604 for example :-)


Segher
