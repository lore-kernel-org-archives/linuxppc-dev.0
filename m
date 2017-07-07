Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3b7D6qPCzDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 10:28:24 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v670NYsr104774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jul 2017 20:28:22 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bhqu8hnyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 20:28:22 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 6 Jul 2017 18:28:21 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Oliver O'Halloran" <oohall@gmail.com>, skiboot@lists.ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org, "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [Skiboot] [RFC PATCH] powerpc/powernv: report error messages from
 opal
In-Reply-To: <87inj53lzk.fsf@concordia.ellerman.id.au>
References: <1482298544-8418-1-git-send-email-oohall@gmail.com>
 <1482299579-21599-1-git-send-email-oohall@gmail.com>
 <87van7pdjn.fsf@linux.vnet.ibm.com> <87inj53lzk.fsf@concordia.ellerman.id.au>
Date: Fri, 07 Jul 2017 10:28:13 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmoxnl9e.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>>> index 0e2e57bcab50..cb9c0e6afb33 100644
>>> --- a/arch/powerpc/include/asm/opal-api.h
>>> +++ b/arch/powerpc/include/asm/opal-api.h
>>> @@ -167,7 +167,8 @@
>>>  #define OPAL_INT_EOI				124
>>>  #define OPAL_INT_SET_MFRR			125
>>>  #define OPAL_PCI_TCE_KILL			126
>>> -#define OPAL_LAST				126
>>> +#define OPAL_SCRAPE_LOG				128
>>
>> (another thought, along with the skiboot thoughts), I don't like the
>> SCRAPE_LOG name so much, as it's more of a "hey linux, here's some log
>> messages from firmware, possibly before you were
>> involved"... OPAL_FETCH_LOG ?
>
> I'm not a huge fan of an interrupt followed by an opal call just to
> fetch a single line of log.
>
> Can't we do something more like the existing msglog code, where we have
> a ring buffer and then the interrupt just becomes "hey Linux you should
> look at your ring buffer".

Yeah... that would probably be a bit better...

Although that would mean we can only ever tell the running kernel what's
in the ring buffer. We couldn't work out a way to (after kexec) resend
important bits of info such as "we garded things out, your OCC didn't
start and we trained everything at really slow speeds"


-- 
Stewart Smith
OPAL Architect, IBM.
