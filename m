Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059BEC46475
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 13:53:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467AA20827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467AA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pZ0K3QjtzF110
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 00:53:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pYyD4kTCzF10b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 00:52:01 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C2563154867;
 Mon,  5 Nov 2018 13:51:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE058173FB;
 Mon,  5 Nov 2018 13:51:58 +0000 (UTC)
Date: Mon, 5 Nov 2018 08:51:57 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: System not booting since dm changes? (was Linux 4.20-rc1)
Message-ID: <20181105135157.GA11485@redhat.com>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
 <87tvkvddnk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvkvddnk.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 05 Nov 2018 13:51:59 +0000 (UTC)
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

On Mon, Nov 05 2018 at  5:25am -0500,
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
> > Mike Snitzer (1):
> >     device mapper updates
> 
> Hi Mike,
> 
> Replying here because I can't find the device-mapper pull or the patch
> in question on LKML. I guess I should be subscribed to dm-devel.
> 
> We have a box that doesn't boot any more, bisect points at one of:
> 
>   cef6f55a9fb4 Mike Snitzer       dm table: require that request-based DM be layered on blk-mq devices 
>   953923c09fe8 Mike Snitzer       dm: rename DM_TYPE_MQ_REQUEST_BASED to DM_TYPE_REQUEST_BASED 
>   6a23e05c2fe3 Jens Axboe         dm: remove legacy request-based IO path 
> 
> 
> It's a Power8 system running Rawhide, it does have multipath, but I'm
> told it was setup by the Fedora installer, ie. nothing fancy.
> 
> The symptom is the system can't find its root filesystem and drops into
> the initramfs shell. The dmesg includes a bunch of errors like below:
> 
>   [   43.263460] localhost multipathd[1344]: sdb: fail to get serial
>   [   43.268762] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdb
>   [   43.268762] localhost multipathd[1344]: uevent trigger error
>   [   43.282065] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
...
>
> Any ideas what's going wrong here?

"table load rejected: not all devices are blk-mq request-stackable"
speaks to the fact that you aren't using blk-mq for scsi (aka scsi-mq).

You need to use scsi_mod.use_blk_mq=Y on the kernel commandline (or set
CONFIG_SCSI_MQ_DEFAULT in your kernel config)

Mike
