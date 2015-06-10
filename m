Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 132871A0F6F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:09:54 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 162AE140297
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:09:52 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 17:39:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 52CF0E005F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:43:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5AC9lY46685070
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:39:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AC9iid007132
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:39:45 +0530
Message-ID: <55782906.80102@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:39:42 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 04/10] powerpc, perf: Re organize PMU based branch
 filter processing in POWER8
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-4-git-send-email-khandual@linux.vnet.ibm.com>
 <1433912822.3096.31.camel@axtens.net>
In-Reply-To: <1433912822.3096.31.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 10:37 AM, Daniel Axtens wrote:
> 
>>  	/* Every thing else is unsupported */
>>  	return -1;
> You're returning -1 as a unsigned 64bit number. Other code that reads
> this value tests for -1 and I think it works everywhere just because it
> wraps around consistently. But I would still rather not do this and I'm
> surprised it doesn't throw a warning.

Thats the existing code which is going away with this patch series.
