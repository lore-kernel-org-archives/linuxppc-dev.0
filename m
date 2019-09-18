Return-Path: <SRS0=xS+q=XN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A3C4CECE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 05:19:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A2720856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 05:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pBaXb5JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A2720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Y7Zd2WmmzF3nm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 15:19:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Y7X002rgzF4GB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2019 15:17:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="pBaXb5JT"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46Y7Wz5hV6z9sN1;
 Wed, 18 Sep 2019 15:17:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1568783839;
 bh=/G/fMfo51L2IBi/WqzEf1ncwXWFlf5xXJj8Kcg+tBLs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pBaXb5JT5/LGMp5V8e7fZYMzDPBQkbj5nI8GkykF6Lfn2Vo9pTA+1C3V5s5GoptL6
 0L4fisKhr9F1HGascSZ4bO6dvpkErkmihyAwiVevfnDan3k1NGOqxA6+7MfddZbhgX
 0mB2gz0VtHykybFI5m2gE1LA5MwoEgAjhYJk4m5kMaXf/BmQ+AV4hrslKucWQ/Blan
 xBnwhRfXZ0cDryWgkubdhn+PtE1Thac7caJ58g2mEtFq2xZC2q88F5bE3E9qG9FyYQ
 p1giKEdrwuWULEWJe0Q95hmP95QyjgBRdWFehgi31xhhc5HjFTUV7XuSbOSEcSLj7V
 Lly8Yuhg2lwCA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] pseries/hotplug: Change the default behaviour of
 cede_offline
In-Reply-To: <87a7b2rfj0.fsf@linux.ibm.com>
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
 <87impxr0am.fsf@linux.ibm.com> <20190915074217.GA943@in.ibm.com>
 <87a7b2rfj0.fsf@linux.ibm.com>
Date: Wed, 18 Sep 2019 15:17:19 +1000
Message-ID: <87o8ziw5cw.fsf@mpe.ellerman.id.au>
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Kamalesh Babulal <kamaleshb@in.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
>> On Thu, Sep 12, 2019 at 10:39:45AM -0500, Nathan Lynch wrote:
>>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>>> > The patchset also defines a new sysfs attribute
>>> > "/sys/device/system/cpu/cede_offline_enabled" on PSeries Linux guests
>>> > to allow userspace programs to change the state into which the
>>> > offlined CPU need to be put to at runtime.
>>> 
>>> A boolean sysfs interface will become awkward if we need to add another
>>> mode in the future.
>>> 
>>> What do you think about naming the attribute something like
>>> 'offline_mode', with the possible values 'extended-cede' and
>>> 'rtas-stopped'?
>>
>> We can do that. However, IMHO in the longer term, on PSeries guests,
>> we should have only one offline state - rtas-stopped.  The reason for
>> this being, that on Linux, SMT switch is brought into effect through
>> the CPU Hotplug interface. The only state in which the SMT switch will
>> recognized by the hypervisors such as PHYP is rtas-stopped.
>
> OK. Why "longer term" though, instead of doing it now?
>
>
>> All other states (such as extended-cede) should in the long-term be
>> exposed via the cpuidle interface.
>>
>> With this in mind, I made the sysfs interface boolean to mirror the
>> current "cede_offline" commandline parameter. Eventually when we have
>> only one offline-state, we can deprecate the commandline parameter as
>> well as the sysfs interface.
>
> I don't care for adding a sysfs interface that is intended from the
> beginning to become vestigial...
>
> This strikes me as unnecessarily incremental if you're changing the
> default offline state. Any user space programs depending on the current
> behavior will have to change anyway (and why is it OK to break them?)
>
> Why isn't the plan:
>
>   1. Add extended cede support to the pseries cpuidle driver
>   2. Make stop-self the only cpu offline state for pseries (no sysfs
>      interface necessary)

I agree, that would be preferable. Adding more sysfs tunables sucks,
especially if they're going to be deprecated in the not too distant
future.

Another option would be to add extended cede to the cpuidle driver,
and retain the cede_offline boot parameter but make it false by default.

cheers
