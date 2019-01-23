Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C3C282C0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 00:13:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13822218A6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 00:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13822218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mbwH4khLzDqQv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 11:13:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mbtb3bn8zDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 11:12:23 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0N6iFAL025684;
 Wed, 23 Jan 2019 00:44:17 -0600
Message-ID: <de777e750665d92509b1487a90acb79d70854cf3.camel@kernel.crashing.org>
Subject: Re: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE
 native exploitation mode hcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@ozlabs.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>
Date: Wed, 23 Jan 2019 17:44:15 +1100
In-Reply-To: <20190122052346.GF15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-12-clg@kaod.org> <20190122052346.GF15124@blackberry>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-22 at 16:23 +1100, Paul Mackerras wrote:
> 
> Which ones of these could be implemented in QEMU?  Are there any that
> can't possibly be implemented in QEMU because they need to do things
> that require calling internal interfaces that userspace doesn't have
> access to?

Implementing them in qemu doesn't make a lot of sense. Qemu doesn't
have access to most of the XIVE HW state. There's a XIVE model for full
emulation but when using the real thing, almost none of it is visible.
A lot of those hcalls effectively turn into OPAL calls.

> How often do we expect each of these hypercalls to be called?

It depends, I can't tell for AIX. For Linux, not often with one
exception: H_INT_ESB which will be used whenever you EOI an emulated
LSI.

 .../...

> Why do we need to provide real-mode versions of these hypercall
> handlers?  I thought these hypercalls would only get called
> infrequently, and in any case certainly much less frequently than once
> per interrupt delivered.  If they are infrequent, then let's leave out
> the real-mode version and just handle them in book3s_hv.c.

Agreed with the exception maybe of H_INT_ESB

> > @@ -5153,6 +5169,19 @@ static unsigned int default_hcall_list[] = {
> >        H_IPOLL,
> >        H_XIRR,
> >        H_XIRR_X,
> > +#endif
> > +#ifdef CONFIG_KVM_XIVE
> > +     H_INT_GET_SOURCE_INFO,
> > +     H_INT_SET_SOURCE_CONFIG,
> > +     H_INT_GET_SOURCE_CONFIG,
> > +     H_INT_GET_QUEUE_INFO,
> > +     H_INT_SET_QUEUE_CONFIG,
> > +     H_INT_GET_QUEUE_CONFIG,
> > +     H_INT_SET_OS_REPORTING_LINE,
> > +     H_INT_GET_OS_REPORTING_LINE,
> > +     H_INT_ESB,
> > +     H_INT_SYNC,
> > +     H_INT_RESET,
> >   #endif
> 
> The policy is not to add new hcalls to default_hcall_list[].  Is there
> a strong reason for adding them here?
> 
> Paul.

