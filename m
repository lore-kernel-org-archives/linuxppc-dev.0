Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wctJ013VvzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 11:32:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4V1SloZ080711
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 21:32:11 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2asjtbtv26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 21:32:11 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 31 May 2017 11:32:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4V1VvKc56295582
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 11:32:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4V1VOEf021951
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 11:31:24 +1000
Subject: Re: [PATCH 1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@lists.ozlabs.org
References: <20170530054637.0D6C4AC0B9@b01ledav006.gho.pok.ibm.com>
 <e5441c6f-d2e4-428a-9b1d-49a15e5be39c@au1.ibm.com>
 <87wp8y4m9c.fsf@concordia.ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 31 May 2017 11:31:04 +1000
MIME-Version: 1.0
In-Reply-To: <87wp8y4m9c.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <77df7e51-d936-3157-bb6f-98551fc170d2@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30/05/17 21:28, Michael Ellerman wrote:
> You and a few other people who are also wrong ;)
>
> Using PPC_BIT() means people have to go and dereference that macro
> before they can grok the code, and when they do look at the macro they
> go "huh, wut is this insanity".

Any non-PPC person who's looking in EEH code is in for a fun time anyway :)

> Having said that I don't love the use of >> 63 here. Better would be:
>
> #define PE_MASK	(1ull << 63)	// Name could be better if I knew what this code was doing
>
> if (peA & PE_MASK)
> 	...
>
>
> Even better IMHO is to fully flesh out the constant:
>
> #define PE_MASK	0x8000000000000000

Agreed, I just don't like seeing >> being used of extracting a bit.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
