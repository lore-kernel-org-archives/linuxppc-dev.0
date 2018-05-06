Return-Path: <stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40f8y43GnjzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 01:37:16 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w46FY8Qw063930
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 May 2018 11:37:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hssp77xtw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 11:37:14 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Sun, 6 May 2018 11:37:13 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
In-Reply-To: <877eok9qs1.fsf@concordia.ellerman.id.au>
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
 <20180503090647.xsfw3p7mq2pwd2rw@aksadiga.ibm>
 <20180503192852.13a42712@roar.ozlabs.ibm.com>
 <87lgd13vjo.fsf@linux.vnet.ibm.com> <877eok9qs1.fsf@concordia.ellerman.id.au>
Date: Mon, 07 May 2018 01:37:07 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8736z44wyk.fsf@linux.vnet.ibm.com>
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
> ...
>>
>> Slightly stupid question: should we be disabling these here or should
>> Linux be better and deciding what states to use?
>>
>> I'm inclined to say this is a Linux problem as it should make the
>> decision of what hardware feature to used based on the ones OPAL says
>> *can* be used.
>
> Yeah I agree.
>
> Firmware shouldn't be implementing the policy around what states to use,
> it should tell the operating system (which might be Linux) what states
> are available and what their features are.

Yeah... I think I should work out somewhere to put this in the
documentation, a kind of design philosophy we can point back to.

> The exception to that would be that we have unfixable crash bugs in
> existing kernels, in that case firmware might have to filter out states
> that are known to cause those.

s/in/with/ and *cough* stop11 for example.

-- 
Stewart Smith
OPAL Architect, IBM.
