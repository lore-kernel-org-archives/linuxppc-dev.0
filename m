Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D3631A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:06:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 14:06:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BB2B52CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:06:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4146MBZ45809742
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 14:06:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4145ve9028043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 14:05:57 +1000
Date: Fri, 1 May 2015 14:05:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/eeh: Delay probing EEH device during hotplug
Message-ID: <20150501040533.GB9948@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430436135-15721-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430437857.32679.2.camel@ellerman.id.au>
 <20150501012840.GA12990@gwshan>
 <1430452297.11970.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430452297.11970.1.camel@ellerman.id.au>
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

On Fri, May 01, 2015 at 01:51:37PM +1000, Michael Ellerman wrote:
>On Fri, 2015-05-01 at 11:28 +1000, Gavin Shan wrote:
>> On Fri, May 01, 2015 at 09:50:57AM +1000, Michael Ellerman wrote:
>> >On Fri, 2015-05-01 at 09:22 +1000, Gavin Shan wrote:
>> >> Commit 1c509148b ("powerpc/eeh: Do probe on pci_dn") probes EEH
>> >> devices in early stage, which is reasonable to pSeries platform.
>> >> However, it's wrong for PowerNV platform because the PE# isn't
>> >> determined until the resources (IO and MMIO) are assigned to
>> >> PE in hotplug case. So we have to delay probing EEH devices
>> >> for PowerNV platform until the PE# is assigned.
>> >> 
>> >> Fixes: 1c509148b ("powerpc/eeh: Do probe on pci_dn")
>> >
>> >I don't have that SHA.
>> >
>> >I've have a commit with the same subject which is ff57b454ddb9.
>> >
>> >Is that the same thing?
>> 
>> Yes, they're same thing.
>
>OK.
>
>> There seems something wrong at local because "git show 1c509148b" leads
>> me to the patch as well. However, I believe ff57b454ddb9 is the correct
>> one. I'll send v2 to fix it up.
>
>You just have it in your tree from when you were developing it I guess?
>
>If you do:
>
>  $ git show --format=fuller 1c509148b
>
>It should show you the committer etc.
>

Yeah, it's true. The committer is myself for commit 1c509148b.

Thanks,
Gavin
