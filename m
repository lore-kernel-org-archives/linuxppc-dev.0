Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A84C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 04:40:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCA62075C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 04:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCA62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tl0L5mxkzF3FZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.170; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0170.hostedemail.com
 [216.40.44.170])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TkyJ3j6SzF1fF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 15:38:48 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id D9563100E86C4;
 Tue,  9 Oct 2018 04:38:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue43_864aa42fe6b16
X-Filterd-Recvd-Size: 2264
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Tue,  9 Oct 2018 04:38:42 +0000 (UTC)
Message-ID: <5f968a498c3d9848389ce5c6e04d98fc59c6438a.camel@perches.com>
Subject: Re: [PATCH] powerpc/xmon/ppc-opc: Use ARRAY_SIZE macro
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>
Date: Mon, 08 Oct 2018 21:38:41 -0700
In-Reply-To: <874ldv3hty.fsf@concordia.ellerman.id.au>
References: <20181004171036.GA1907@embeddedor.com>
 <8e2f906a85c3cfe0715982370a6d96f08a37987c.camel@perches.com>
 <874ldv3hty.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Tue, 2018-10-09 at 14:43 +1100, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > On Thu, 2018-10-04 at 19:10 +0200, Gustavo A. R. Silva wrote:
> > > Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> > []
> > > diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
> > []
> > > @@ -966,8 +966,7 @@ const struct powerpc_operand powerpc_operands[] =
> > >    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
> > >  };
> > >  
> > > -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
> > > -					   / sizeof (powerpc_operands[0]));
> > > +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
> > 
> > It seems this is unused and could be deleted.
> 
> The code in this file is copied from binutils.
> 
> We don't want to needlessly diverge it.
> 
> I've said this before:
> 
>   https://lore.kernel.org/linuxppc-dev/874lfxjnzl.fsf@concordia.ellerman.id.au/

Don't expect people to remember this.

> Is there some way we can blacklist this file from checkpatch, Coccinelle
> etc?

Modify both to look for some specific tag
in a file and then update the scripts to
read the file when looking at patches too.

Otherwise, no.



