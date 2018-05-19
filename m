Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nmjD30WpzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 10:52:31 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4J0mW6a001011
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 20:52:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j28by2r5f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 20:52:28 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 19 May 2018 01:52:26 +0100
Date: Fri, 18 May 2018 17:52:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>
Subject: Re: pkeys on POWER: Default AMR, UAMOR values
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
 <20180518174448.GE5479@ram.oc3035372033.ibm.com>
 <CALCETrV_wYPKHna8R2Bu19nsDqF2dJWarLLsyHxbcYD_AgYfPg@mail.gmail.com>
 <27e01118-be5c-5f90-78b2-56bb69d2ab95@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27e01118-be5c-5f90-78b2-56bb69d2ab95@redhat.com>
Message-Id: <20180519005219.GI5479@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 11:13:30PM +0200, Florian Weimer wrote:
> On 05/18/2018 09:39 PM, Andy Lutomirski wrote:
> >The difference is that x86 starts out with deny-all instead of allow-all.

Ah!. this explains the discrepency. But still does not explain one
thing.. see below.

> >The POWER semantics make it very hard for a multithreaded program to
> >meaningfully use protection keys to prevent accidental access to important
> >memory.
> 
> And you can change access rights for unallocated keys (unallocated
> at thread start time, allocated later) on x86.  I have extended the
> misc/tst-pkeys test to verify that, and it passes on x86, but not on
> POWER, where the access rights are stuck.

This is something I do not understand. How can a thread change permissions
on a key, that is not even allocated in the first place. Do you consider a key
allocated in some other thread's context, as allocated in this threads
context? If not, does that mean -- On x86, you can activate a key just
by changing its permission?


RP
