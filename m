Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E0EC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 04:46:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7EB2087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 04:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7EB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x5Kq6VHyzF3jY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 15:46:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x5HC3qrzzF3jw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:44:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42x5HC142Jz9sB5;
 Fri, 16 Nov 2018 15:44:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Oliver <oohall@gmail.com>
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard LOCKUP
 @ opal_interrupt+0x28/0x70 when module load/unload
In-Reply-To: <1542291418.15177.3.camel@abdul>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
 <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
 <1537784366.26347.15.camel@abdul.in.ibm.com> <1542280243.15177.2.camel@abdul>
 <1542291418.15177.3.camel@abdul>
Date: Fri, 16 Nov 2018 15:44:20 +1100
Message-ID: <87lg5ttyvv.fsf@concordia.ellerman.id.au>
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
Cc: manvanth <manvanth@linux.vnet.ibm.com>, sim <sim@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 maurosr <maurosr@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> On Thu, 2018-11-15 at 16:40 +0530, Abdul Haleem wrote:
>> On Mon, 2018-09-24 at 15:49 +0530, Abdul Haleem wrote:
>> > On Mon, 2018-09-24 at 19:35 +1000, Oliver wrote:
>> > > On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
>> > > <abdhalee@linux.vnet.ibm.com> wrote:
>> > > > Greeting's
>> > > >
>> > > > bnx2x module load/unload test results in continuous hard LOCKUP trace on
>> > > > my powerpc bare-metal running mainline 4.19.0-rc4 kernel
                                                ^^^^^^^^^^
>> 
>> Warnings also show up on 4.20.0-rc2-next-20181114
>
> We have a patch fix available https://patchwork.ozlabs.org/patch/998054/
>
> It fixed the problem.

But the bug it fixes wasn't present in 4.19.0-rc4, which is the version
you originally reported against. Or is that version string not accurate?

cheers
