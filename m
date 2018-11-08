Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D405ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:25:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF8C206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF8C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rZXm4yzZzF3Sx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:25:28 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rZVp4Hb3zF3T3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 07:23:44 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9549461F8;
 Thu,  8 Nov 2018 20:23:42 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E9FC100194A;
 Thu,  8 Nov 2018 20:23:40 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
Date: Thu, 08 Nov 2018 21:23:35 +0100
In-Reply-To: <20181108201231.GE5481@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Thu, 8 Nov 2018 12:12:31 -0800")
Message-ID: <87bm6z71yw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 08 Nov 2018 20:23:43 +0000 (UTC)
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
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Ram Pai:

> Florian,
>
> 	I can. But I am struggling to understand the requirement. Why is
> 	this needed?  Are we proposing a enhancement to the sys_pkey_alloc(),
> 	to be able to allocate keys that are initialied to disable-read
> 	only?

Yes, I think that would be a natural consequence.

However, my immediate need comes from the fact that the AMR register can
contain a flag combination that is not possible to represent with the
existing PKEY_DISABLE_WRITE and PKEY_DISABLE_ACCESS flags.  User code
could write to AMR directly, so I cannot rule out that certain flag
combinations exist there.

So I came up with this:

int
pkey_get (int key)
{
  if (key < 0 || key > PKEY_MAX)
    {
      __set_errno (EINVAL);
      return -1;
    }
  unsigned int index = pkey_index (key);
  unsigned long int amr = pkey_read ();
  unsigned int bits = (amr >> index) & 3;

  /* Translate from AMR values.  PKEY_AMR_READ standing alone is not
     currently representable.  */
  if (bits & PKEY_AMR_READ)
    return PKEY_DISABLE_ACCESS;
  else if (bits == PKEY_AMR_WRITE)
    return PKEY_DISABLE_WRITE;
  return 0;
}

And this is not ideal.  I would prefer something like this instead:

  switch (bits)
    {
      case PKEY_AMR_READ | PKEY_AMR_WRITE:
        return PKEY_DISABLE_ACCESS;
      case PKEY_AMR_READ:
        return PKEY_DISABLE_READ;
      case PKEY_AMR_WRITE:
        return PKEY_DISABLE_WRITE;
      case 0:
        return 0;
    }

By the way, is the AMR register 64-bit or 32-bit on 32-bit POWER?

Thanks,
Florian
