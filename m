Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82FC10F03
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:17:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694F021773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694F021773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pkVP0ZMGzDqVL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 12:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=stgolabs.net
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dave@stgolabs.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=stgolabs.net
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pkSc6nqJzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 12:15:57 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9AF78AC63;
 Wed, 24 Apr 2019 02:15:53 +0000 (UTC)
Date: Tue, 23 Apr 2019 19:15:44 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Message-ID: <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
Mail-Followup-To: Daniel Jordan <daniel.m.jordan@oracle.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org, jgg@mellanox.com
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
 <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
 <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20180323
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, jgg@mellanox.com, Paul Mackerras <paulus@samba.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 03 Apr 2019, Daniel Jordan wrote:

>On Wed, Apr 03, 2019 at 06:58:45AM +0200, Christophe Leroy wrote:
>> Le 02/04/2019 =E0 22:41, Daniel Jordan a =E9crit=A0:
>> > With locked_vm now an atomic, there is no need to take mmap_sem as
>> > writer.  Delete and refactor accordingly.
>>
>> Could you please detail the change ?
>
>Ok, I'll be more specific in the next version, using some of your language=
 in
>fact.  :)
>
>> It looks like this is not the only
>> change. I'm wondering what the consequences are.
>>
>> Before we did:
>> - lock
>> - calculate future value
>> - check the future value is acceptable
>> - update value if future value acceptable
>> - return error if future value non acceptable
>> - unlock
>>
>> Now we do:
>> - atomic update with future (possibly too high) value
>> - check the new value is acceptable
>> - atomic update back with older value if new value not acceptable and re=
turn
>> error
>>
>> So if a concurrent action wants to increase locked_vm with an acceptable
>> step while another one has temporarily set it too high, it will now fail.
>>
>> I think we should keep the previous approach and do a cmpxchg after
>> validating the new value.

Wouldn't the cmpxchg alternative also be exposed the locked_vm changing bet=
ween
validating the new value and the cmpxchg() and we'd bogusly fail even when =
there
is still just because the value changed (I'm assuming we don't hold any loc=
ks,
otherwise all this is pointless).

   current_locked =3D atomic_read(&mm->locked_vm);
   new_locked =3D current_locked + npages;
   if (new_locked < lock_limit)
      if (cmpxchg(&mm->locked_vm, current_locked, new_locked) =3D=3D curren=
t_locked)
      	 /* ENOMEM */

>
>That's a good idea, and especially worth doing considering that an arbitra=
ry
>number of threads that charge a low amount of locked_vm can fail just beca=
use
>one thread charges lots of it.

Yeah but the window for this is quite small, I doubt it would be a real iss=
ue.

What if before doing the atomic_add_return(), we first did the racy new_loc=
ked
check for ENOMEM, then do the speculative add and cleanup, if necessary. Th=
is
would further reduce the scope of the window where false ENOMEM can occur.

>pinned_vm appears to be broken the same way, so I can fix it too unless so=
meone
>beats me to it.

This should not be a surprise for the rdma folks. Cc'ing Jason nonetheless.

Thanks,
Davidlohr
