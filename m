Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71DDA1A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:41:41 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 May 2014 14:41:38 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3604B2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:41:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L4K97c63897754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:20:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L4fZnh008143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:41:35 +1000
Date: Wed, 21 May 2014 14:41:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
Message-ID: <20140521044134.GB1959@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <1400631131.3986.144.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400631131.3986.144.camel@pasglop>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 21, 2014 at 10:12:11AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2014-05-20 at 21:56 +1000, Gavin Shan wrote:
>
> .../...
>
>> >I think what you want is an irqfd that the in-kernel eeh code
>> >notifies when it sees a failure. When such an fd exists, the kernel
>> >skips its own error handling.
>> >
>> 
>> Yeah, it's a good idea and something for me to improve in phase II. We
>> can discuss for more later. For now, what I have in my head is something
>> like this:
>
>However, this would be a deviation from (or extension of) PAPR. At the
>moment, the way things work in PAPR is that the guest is responsible for
>querying the EEH state when something "looks" like an error (ie, getting
>ff's back). This is also how it works in pHyp.
>
>We have an interrupt path in the host when doing "native" EEH, and it
>would be nice to extend PAPR to also be able to shoot an event to the
>guest possibly using RTAS events, but let's get the basics working and
>upstream first.
>

Got it. Thanks, Ben :-)

Thanks,
Gavin
