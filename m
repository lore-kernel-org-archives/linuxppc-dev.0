Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CEC19F2A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Aug 2022 15:50:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M3WVX2tnCz3c4w
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Aug 2022 01:50:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M3WTf66tdz3bbl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2022 01:49:58 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27BFlqBW006139;
	Thu, 11 Aug 2022 10:47:52 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 27BFlpgk006136;
	Thu, 11 Aug 2022 10:47:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 11 Aug 2022 10:47:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 11/14] powerpc/64s: Clear/restore caller gprs in syscall interrupt/return
Message-ID: <20220811154751.GG25951@gate.crashing.org>
References: <20220725063111.120926-1-rmclure@linux.ibm.com> <20220811151302.GF25951@gate.crashing.org> <cd3f5a35-dfda-ef2e-dd13-93d5c4011f16@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd3f5a35-dfda-ef2e-dd13-93d5c4011f16@csgroup.eu>
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
Cc: Rohan McLure <rmclure@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "npiggin@gmail.com" <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 11, 2022 at 03:39:58PM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/08/2022 à 17:13, Segher Boessenkool a écrit :
> > Hi!
> > 
> > On Mon, Jul 25, 2022 at 04:31:11PM +1000, Rohan McLure wrote:
> >> +	/*
> >> +	 * Zero user registers to prevent influencing speculative execution
> >> +	 * state of kernel code.
> >> +	 */
> >> +	NULLIFY_GPRS(5, 12)
> >> +	NULLIFY_NVGPRS()
> > 
> > "Nullify" means "invalidate", which is not what this does or is for :-(
> 
> Would "Zeroise" be more appropriate ?

That is probably a good compromise, yes.  It obviously is a verb, its
meaning is clear and unamiguous, and there is precedent for it even :-)

Thanks,


Segher
