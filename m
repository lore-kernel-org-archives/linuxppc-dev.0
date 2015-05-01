Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17E261A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 11:29:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 11:29:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9CC59357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 11:29:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t411TTpS2752996
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 11:29:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t411T4d8006053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 11:29:04 +1000
Date: Fri, 1 May 2015 11:28:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Delay probing EEH device during hotplug
Message-ID: <20150501012840.GA12990@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430436135-15721-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430437857.32679.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430437857.32679.2.camel@ellerman.id.au>
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 01, 2015 at 09:50:57AM +1000, Michael Ellerman wrote:
>On Fri, 2015-05-01 at 09:22 +1000, Gavin Shan wrote:
>> Commit 1c509148b ("powerpc/eeh: Do probe on pci_dn") probes EEH
>> devices in early stage, which is reasonable to pSeries platform.
>> However, it's wrong for PowerNV platform because the PE# isn't
>> determined until the resources (IO and MMIO) are assigned to
>> PE in hotplug case. So we have to delay probing EEH devices
>> for PowerNV platform until the PE# is assigned.
>> 
>> Fixes: 1c509148b ("powerpc/eeh: Do probe on pci_dn")
>
>I don't have that SHA.
>
>I've have a commit with the same subject which is ff57b454ddb9.
>
>Is that the same thing?
>

Yes, they're same thing.

>I also have 89a51df5ab1d, which Fixes that commit (ff57..).
>

There seems something wrong at local because "git show 1c509148b" leads
me to the patch as well. However, I believe ff57b454ddb9 is the correct
one. I'll send v2 to fix it up.

---

gwshan@gwshan:~/sandbox/linux$ git show 1c509148b
1 commit 1c509148bd6b5199dc1d97e146eda496f9f22a06
2 Author: Gavin Shan <gwshan@linux.vnet.ibm.com>
3 Date:   Tue Mar 17 10:49:45 2015 +1100
4 
5     powerpc/eeh: Do probe on pci_dn

gwshan@gwshan:~/sandbox/linux$ git show ff57b454ddb9
      1 commit ff57b454ddb938d98d48d8df356357000fedc88c
      2 Author: Gavin Shan <gwshan@linux.vnet.ibm.com>
      3 Date:   Tue Mar 17 16:15:06 2015 +1100
      4 
      5     powerpc/eeh: Do probe on pci_dn

Thanks,
Gavin

>cheers
>
>
