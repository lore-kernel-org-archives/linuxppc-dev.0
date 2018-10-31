Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682FECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:43:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254572080A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 22:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254572080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ljzy507lzF3Lg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 09:43:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ljxj4hkHzF3Jy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 09:41:45 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CD46DABCE;
 Wed, 31 Oct 2018 22:41:41 +0000 (UTC)
Date: Wed, 31 Oct 2018 23:41:40 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
Message-ID: <20181031234140.70021082@naga.suse.cz>
In-Reply-To: <87bm79n57l.fsf@linux.ibm.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
 <877ehyf1cj.fsf@oldenburg.str.redhat.com>
 <87efc5n73a.fsf@linux.ibm.com>
 <87in1hlsa7.fsf@oldenburg.str.redhat.com>
 <87bm79n57l.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Florian Weimer <fweimer@redhat.com>,
 "Lynn A. Boger" <laboger@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 31 Oct 2018 19:04:14 -0300
Tulio Magno Quites Machado Filho <tuliom@ascii.art.br> wrote:

> Florian Weimer <fweimer@redhat.com> writes:
> 
> > * Tulio Magno Quites Machado Filho:
> >  
> >> I wonder if this is restricted to linker that Golang uses.
> >> Were you able to reproduce the same problem with Binutils'
> >> linker?  
> >
> > The example is carefully constructed to use the external linker.  It
> > invokes gcc, which then invokes the BFD linker in my case.  
> 
> Indeed. That question was unnecessary.  :-D
> 
> > Based on the relocations, I assume there is only so much the linker
> > can do here.  I'm amazed that it produces an executable at all, let
> > alone one that runs correctly on some kernel versions!  
> 
> Agreed.  That isn't expected to work.  Both the compiler and the
> linker have to generate PIE for it to work.
> 
> > I assume that the Go toolchain simply lacks PIE support on
> > ppc64le.  
> 
> Maybe the support is there, but it doesn't generate PIC by default?
> 
golang has -fPIC IIRC. It does not benefit from the GNU toolchian
synergy of always calling the linker with the correct flags
corresponding to the generated code, though. So when gcc flips the
switch default value golang happily produces incompatible objects.

Also I suspect some pieces of stdlib are not compiled with the flags
you pass in for the build so there are always some objects somewhere
that are not compatible.

Thanks

Michal
