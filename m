Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05998C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:05:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F2420834
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F2420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437qbQ2bTGzDqbc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 03:05:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437qHz0pBBzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 02:52:15 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B6D413AA4;
 Mon,  3 Dec 2018 15:52:13 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-35.ams2.redhat.com
 [10.36.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C44BE2655B;
 Mon,  3 Dec 2018 15:52:11 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
 <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
 <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com>
 <87va4g5d3o.fsf@oldenburg.str.redhat.com>
 <20181203040249.GA11930@ram.oc3035372033.ibm.com>
Date: Mon, 03 Dec 2018 16:52:02 +0100
In-Reply-To: <20181203040249.GA11930@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Sun, 2 Dec 2018 20:02:49 -0800")
Message-ID: <87pnuibobh.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 03 Dec 2018 15:52:13 +0000 (UTC)
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
Cc: Dave Hansen <dave.hansen@intel.com>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Ram Pai:

> So the problem is as follows:
>
> Currently the kernel supports  'disable-write'  and 'disable-access'.
>
> On x86, cpu supports 'disable-write' and 'disable-access'. This
> matches with what the kernel supports. All good.
>
> However on power, cpu supports 'disable-read' too. Since userspace can
> program the cpu directly, userspace has the ability to set
> 'disable-read' too.  This can lead to inconsistency between the kernel
> and the userspace.
>
> We want the kernel to match userspace on all architectures.

Correct.

> Proposed Solution:
>
> Enhance the kernel to understand 'disable-read', and facilitate architectures
> that understand 'disable-read' to allow it.
>
> Also explicitly define the semantics of disable-access  as 
> 'disable-read and disable-write'
>
> Did I get this right?  Assuming I did, the implementation has to do
> the following --
>   
> 	On power, sys_pkey_alloc() should succeed if the init_val
> 	is PKEY_DISABLE_READ, PKEY_DISABLE_WRITE, PKEY_DISABLE_ACCESS
> 	or any combination of the three.

Agreed.

> 	On x86, sys_pkey_alloc() should succeed if the init_val is
> 	PKEY_DISABLE_WRITE or PKEY_DISABLE_ACCESS or PKEY_DISABLE_READ
> 	or any combination of the three, except  PKEY_DISABLE_READ
>       	specified all by itself.

Again agreed.  That's a clever way of phrasing it actually.

> 	On all other arches, none of the flags are supported.
>
>
> Are we on the same plate?

I think so, thanks.

Florian
