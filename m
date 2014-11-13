Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 316981A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 17:19:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 13 Nov 2014 11:49:46 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AE5E6125805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:49:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAD6JwtC40829108
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:49:58 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAD6Jf74012585
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:49:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/TM: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
In-Reply-To: <1415857347.28703.8.camel@concordia>
References: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415753046.5175.22.camel@neuling.org> <87d28tasfe.fsf@linux.vnet.ibm.com>
 <1415857347.28703.8.camel@concordia>
Date: Thu, 13 Nov 2014 11:49:41 +0530
Message-ID: <87fvdnvczm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Wed, 2014-11-12 at 11:09 +0530, Aneesh Kumar K.V wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> 
>> > On Sun, 2014-11-02 at 20:02 +0530, Aneesh Kumar K.V wrote:
>> >> Runtime disable transactional memory feature looking at pa-features
>> >> device tree entry. We need to do this so that we can run a kernel
>> >> built with TM config in PR mode. 
>> >
>> > I'm happy to turn this off but why do we need to do this in PR mode?
>> > Can you explain this in the commit message.
>> 
>> Hmm, that commit message needs an update. I initially did the patch for
>> P8 PR support and wanted a mechanism to disable TM. Alex added basic TM
>> support for PR mode after that. So we can drop the PR part of the
>> commit message.
>> 
>> Michael Ellerman,
>> 
>> Let me know if you want me to send an updated version with the those
>> part of the commit message dropped
>
> How about:
>
>   powerpc: Disable CPU_FTR_TM if TM is disabled by firmware
>   
>   Firmware is allowed to communicate to us via the "ibm,pa-features" property
>   that TM (Transactional Memory) support is disabled.
>   
>   Currently this doesn't happen on any platform we're aware of, but we should
>   honor it anyway.
>

Looks good.

-aneesh
