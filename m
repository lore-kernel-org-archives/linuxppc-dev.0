Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B53C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 08:14:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BE620989
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 08:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BE620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439T075f3gzDqdS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 19:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=lip6.fr
 (client-ip=192.134.164.104; helo=mail3-relais-sop.national.inria.fr;
 envelope-from=julia.lawall@lip6.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lip6.fr
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439Sxx3Tt1zDr5n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 19:12:19 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="5.56,321,1539640800"; d="scan'208";a="288090187"
Received: from eurosites-gw1.ter1.tc3.par.cust.as8218.eu (HELO hadrien.local)
 ([46.255.176.202])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Dec 2018 09:12:13 +0100
Date: Thu, 6 Dec 2018 09:12:12 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in
 ipic_set_priority()
In-Reply-To: <f570563c-1cc7-fecf-2ed2-58164047ec9d@c-s.fr>
Message-ID: <alpine.DEB.2.20.1812060908000.5574@hadrien>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
 <87sgzchcw8.fsf@concordia.ellerman.id.au>
 <f570563c-1cc7-fecf-2ed2-58164047ec9d@c-s.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-15127499-1544083933=:5574"
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
Cc: Kim Phillips <kim.phillips@freescale.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--8323329-15127499-1544083933=:5574
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 6 Dec 2018, Christophe LEROY wrote:

>
>
> Le 05/12/2018 à 04:26, Michael Ellerman a écrit :
> > Hi Dan,
> >
> > Thanks for the patch.
> >
> > Dan Carpenter <dan.carpenter@oracle.com> writes:
> > > The ipic_info[] array only has 95 elements so I have made the bounds
> > > check smaller to prevent a read overflow.  It was Smatch that found
> > > this issue:
> > >
> > >      arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
> > >      error: buffer overflow 'ipic_info' 95 <= 127
> > >
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > I wasn't able to find any callers of this code.  Maybe we removed the
> > > last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
> > > host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
> > > should just remove it.  I'm not really comfortable doing that myself,
> > > because I don't know the code well enough and can't build test
> > > it properly.
> >
> > Hah wow, last usage removed in 2006!
> >
> > I don't see any mention of it since then, so I'll remove it. If it
> > breaks something we can put it back.
> >
> > Can smatch help us find things like this that are defined non-static but
> > never used?
> >
>
> I think we have to do that carrefully. Some of those functions might be used
> by out-of-tree boards.
>
> I'm thinking especially at ipic_get_mcp_status() and ipic_set_mcp_status().
> They are used in my 832x boards's machine check handler to know when a machine
> check is a timeout from the 832x watchdog.

The message I have gotten in the past is that the Linux kernel doesn't
support code that is not used in the Linux kernel.  However, if I were to
do this, I would send the code to the individual maintainers, who
presumably would know what is actually needed and what is not.

Perhaps a good sanity check would be if the code has been used in the
past.  If there was a use in the past that has been removed, then perhaps
it is more likely that the function was intended for internal kernel use
rather than the case that you are describing.

julia
--8323329-15127499-1544083933=:5574--
