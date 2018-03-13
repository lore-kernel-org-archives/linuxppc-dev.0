Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400v1M3HtCzDrDB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:14:46 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DCDPMk025761
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 08:14:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gpcwkmcp8-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 08:14:43 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 06:14:43 -0600
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
 <20180306135522.040707de@kitsune.suse.cz>
 <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
 <876060gq5s.fsf@concordia.ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 09:14:39 -0300
MIME-Version: 1.0
In-Reply-To: <876060gq5s.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c7cadceb-1957-046e-8934-592baccca5b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 03/13/2018 08:39 AM, Michael Ellerman wrote:
>> I agree; the 'Using fallback displacement flush' message is misleading
>> (is the system slower/fallback or not? Ô_o)

> That message is actually just wrong.
> 
> It still prints that even if enable=false.
> 
> So we should change all those messages, perhaps:
> 
> 	pr_info("rfi-flush: fallback displacement flush available\n");
> 	pr_info("rfi-flush: ori type flush available\n");
> 	pr_info("rfi-flush: mttrig type flush available\n");

Indeed.

>> So I wrote something with a new function parameter to force the init of
>> the fallback flush area (true in pseries, false in powernv).  Not that
>> contained, but it seemed to convey the intent here in a clear way.
>>
>> That's v2, just sent.

> OK thanks. I don't really like it :D - sorry!

No worries :) fair enough. Well, I didn't like it much, either, TBH.

> It's a lot of plumbing of that bool just to avoid the message, whereas I
> think we could just change the message like above.

Yup.

And what you think about a more descriptive confirmation of what flush
instructions/methods are _actually_ being used?

Currently and w/ your suggestion aobve, all that is known is what is
_available_, not what has gone in (or out, in the disable case) the
nop slots.

cheers,
mauricio
