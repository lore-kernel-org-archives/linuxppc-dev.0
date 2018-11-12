Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482B4C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:31:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3272241B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3272241B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tn9S3hVZzF3R0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 21:31:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tn7B03kpzF3Hj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 21:29:25 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84629C049D7F;
 Mon, 12 Nov 2018 10:29:23 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60DF75D9D6;
 Mon, 12 Nov 2018 10:29:22 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <20181108192226.GC5481@ram.oc3035372033.ibm.com>
Date: Mon, 12 Nov 2018 11:29:17 +0100
In-Reply-To: <20181108192226.GC5481@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Thu, 8 Nov 2018 11:22:26 -0800")
Message-ID: <87bm6utwqq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 12 Nov 2018 10:29:23 +0000 (UTC)
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
Cc: linux-api@vger.kernel.org, dave.hansen@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Ram Pai:

> On Thu, Nov 08, 2018 at 01:05:09PM +0100, Florian Weimer wrote:
>> Would it be possible to reserve a bit for PKEY_DISABLE_READ?
>> 
>> I think the POWER implementation can disable read access at the hardware
>> level, but not write access, and that cannot be expressed with the
>> current PKEY_DISABLE_ACCESS and PKEY_DISABLE_WRITE bits.
>
> POWER hardware can disable-read and can **also disable-write**
> at the hardware level. It can disable-execute aswell at the
> hardware level.   For example if the key bits for a given key in the AMR
> register is  
> 	0b01  it is read-disable
> 	0b10  it is write-disable
>
> To support access-disable, we make the key value 0b11.
>
> So in case if you want to know if the key is read-disable 'bitwise-and' it
> against 0x1.  i.e  (x & 0x1)

Not sure if we covered that alreay, but my problem is that I cannot
translate a 0b01 mask to a PKEY_DISABLE_* flag combination with the
current flags.  0b10 and 0b11 are fine.

POWER also loses the distinction between PKEY_DISABLE_ACCESS and
PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE, but that's fine.  This breaks
the current glibc test case, but I have a patch for that.  Arguably, the
test is wrong or at least overly strict in what it accepts.

Thanks,
Florian
