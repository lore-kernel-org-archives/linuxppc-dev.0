Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A80C32789
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:01:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBFC20827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 01:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBFC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qSm00smpzF3Fj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:01:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qSjl3lhDzF3DW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 11:59:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42qSjh65Vfz9sDL;
 Wed,  7 Nov 2018 11:59:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: System not booting since dm changes? (was Linux 4.20-rc1)
In-Reply-To: <20181105135157.GA11485@redhat.com>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
 <87tvkvddnk.fsf@concordia.ellerman.id.au> <20181105135157.GA11485@redhat.com>
Date: Wed, 07 Nov 2018 11:59:20 +1100
Message-ID: <871s7xsnx3.fsf@concordia.ellerman.id.au>
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
Cc: axboe@kernel.dk, satheera@in.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mike Snitzer <snitzer@redhat.com> writes:
> On Mon, Nov 05 2018 at  5:25am -0500,
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> ...
>> > Mike Snitzer (1):
>> >     device mapper updates
>> 
>> Hi Mike,
>> 
>> Replying here because I can't find the device-mapper pull or the patch
>> in question on LKML. I guess I should be subscribed to dm-devel.
>> 
>> We have a box that doesn't boot any more, bisect points at one of:
>> 
>>   cef6f55a9fb4 Mike Snitzer       dm table: require that request-based DM be layered on blk-mq devices 
>>   953923c09fe8 Mike Snitzer       dm: rename DM_TYPE_MQ_REQUEST_BASED to DM_TYPE_REQUEST_BASED 
>>   6a23e05c2fe3 Jens Axboe         dm: remove legacy request-based IO path 
>> 
>> 
>> It's a Power8 system running Rawhide, it does have multipath, but I'm
>> told it was setup by the Fedora installer, ie. nothing fancy.
>> 
>> The symptom is the system can't find its root filesystem and drops into
>> the initramfs shell. The dmesg includes a bunch of errors like below:
>> 
>>   [   43.263460] localhost multipathd[1344]: sdb: fail to get serial
>>   [   43.268762] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdb
>>   [   43.268762] localhost multipathd[1344]: uevent trigger error
>>   [   43.282065] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
> ...
>>
>> Any ideas what's going wrong here?
>
> "table load rejected: not all devices are blk-mq request-stackable"
> speaks to the fact that you aren't using blk-mq for scsi (aka scsi-mq).
>
> You need to use scsi_mod.use_blk_mq=Y on the kernel commandline (or set
> CONFIG_SCSI_MQ_DEFAULT in your kernel config)

Thanks.

Looks like CONFIG_SCSI_MQ_DEFAULT is default y, so new configs should
pick that up by default. We must have had an old .config that didn't get
that update.

cheers
