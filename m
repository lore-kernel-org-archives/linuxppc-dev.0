Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVhsb14ZNzDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:05:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVhsZ4qCfz9t1v
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 22:05:21 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GC42ZO068630
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 08:05:19 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ktnhay8t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 08:05:19 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 16 Jun 2016 22:05:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E753A2CE8056
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 22:05:13 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5GC5DPY10551598
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 22:05:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5GC5D8l001151
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 22:05:13 +1000
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Darrick J. Wong"
 <darrick.wong@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Date: Thu, 16 Jun 2016 22:05:09 +1000
In-Reply-To: <87wplp8kxh.fsf@skywalker.in.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
Message-Id: <1466078709.24271.17.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	
 <1466054627.5400.5.camel@ellerman.id.au>
	
	
 <20160616055746.GC22590@birch.djwong.org>
	
	
 <8737oda1lt.fsf@skywalker.in.ibm.com>
	
	 <87ziql8l93.fsf@skywalker.in.ibm.com>
	 <87wplp8kxh.fsf@skywalker.in.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.3 (3.20.3-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2016-06-16 at 16:22 +0530, Aneesh Kumar K.V wrote:
> Hmm Qemu  does
> 
>         /* Looks like an IO address */
>         /* FIXME: What WIMG combinations could be sensible for IO?
>          * For now we allow WIMG=010x, but are there others? */
>         /* FIXME: Should we check against registered IO addresses? */
>         if ((ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M)) != HPTE64_R_I) {
>             return H_PARAMETER;
>         }
> 
> -aneesh

And what do we get ? M ? I think we might be OR'ing it
unconditionaly...

Ben.
