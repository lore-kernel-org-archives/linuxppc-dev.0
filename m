Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401gsF65ZFzDrD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 05:55:29 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EItN3B092020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 14:55:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq5b8brw9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 14:55:25 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 14 Mar 2018 18:55:18 -0000
Date: Wed, 14 Mar 2018 11:54:52 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
 <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
Message-Id: <20180314185452.GB1060@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 10:51:26AM -0700, Dave Hansen wrote:
> On 03/14/2018 10:14 AM, Ram Pai wrote:
> > I look at key-0 as 'the key'. It has special status. 
> > (a) It always exist.
> 
> Do you mean "is always allocated"?

always allocated and cannot be freed. Hence always exists.

If we let it freed, than yes 'it is always allocated', but
may not 'always exist'.

> 
> > (b) it cannot be freed.
> 
> This is the one I'm questioning.

this is a philosophical question. Should we allow the application 
shoot-its-own-feet or help it from doing so. I tend to
gravitate towards the later.

> 
> > (c) it is assigned by default.
> 
> I agree on this totally. :)

good. we have some common ground :)

> 
> > (d) its permissions cannot be modified.
> 
> Why not?  You could pretty easily get a thread going that had its stack
> covered with another pkey and that was being very careful what it
> accesses.  It could pretty easily set pkey-0's access or write-disable bits.

ok. I see your point. Will not argue against it.

> 
> > (e) it bypasses key-permission checks when assigned.
> 
> I don't think this is necessary.  I think the only rule we *need* is:
> 
> 	pkey-0 is allocated implicitly at execve() time.  You do not
> 	need to call pkey_alloc() to allocate it.

And can be explicitly associated with any address range ?

> 
> > An arch need not necessarily map 'the key-0' to its key-0.  It could
> > internally map it to any of its internal key of its choice, transparent
> > to the application.
> 
> I don't understand what you are saying here.

I was trying to disassociate the notion that "application's key-0 
means hardware's key-0". Nevermind. its not important for this
discussion.

-- 
Ram Pai
