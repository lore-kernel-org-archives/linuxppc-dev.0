Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nbCz2NkDzF14Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 03:45:02 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IHha6w181432
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 13:44:59 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j209b18f0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 13:44:58 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 18 May 2018 18:44:57 +0100
Date: Fri, 18 May 2018 10:44:49 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Andy Lutomirski <luto@amacapital.net>
Subject: Re: pkeys on POWER: Default AMR, UAMOR values
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
Message-Id: <20180518174448.GE5479@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 18, 2018 at 03:17:14PM +0200, Florian Weimer wrote:
> I'm working on adding POWER pkeys support to glibc.  The coding work
> is done, but I'm faced with some test suite failures.
> 
> Unlike the default x86 configuration, on POWER, existing threads
> have full access to newly allocated keys.
> 
> Or, more precisely, in this scenario:
> 
> * Thread A launches thread B
> * Thread B waits
> * Thread A allocations a protection key with pkey_alloc
> * Thread A applies the key to a page
> * Thread A signals thread B
> * Thread B starts to run and accesses the page
> 
> Then at the end, the access will be granted.
> 
> I hope it's not too late to change this to denied access.
> 
> Furthermore, I think the UAMOR value is wrong as well because it
> prevents thread B at the end to set the AMR register.  In
> particular, if I do this
> 
> * … (as before)
> * Thread A signals thread B
> * Thread B sets the access rights for the key to PKEY_DISABLE_ACCESS
> * Thread B reads the current access rights for the key
> 
> then it still gets 0 (all access permitted) because the original
> UAMOR value inherited from thread A prior to the key allocation
> masks out the access right update for the newly allocated key.

Florian, is the behavior on x86 any different? A key allocated in the
context off one thread is not meaningful in the context of any other
thread. 

Since thread B was created prior to the creation of the key, and the key
was created in the context of thread A, thread B neither inherits the
key nor its permissions. Atleast that is how the semantics are supposed
to work as per the man page.

man 7 pkey 

" Applications  using  threads  and  protection  keys  should
be especially careful.  Threads inherit the protection key rights of the
parent at the time of the clone(2), system call.  Applications should
either ensure that their own permissions are appropriate for child
threads at the time when clone(2) is  called,  or ensure that each child
thread can perform its own initialization of protection key rights."


RP
