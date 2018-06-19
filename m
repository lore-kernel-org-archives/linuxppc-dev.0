Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419D4P38BMzF0vb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:31:33 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JGTIvU074828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:31:31 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq4r01y4v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 12:31:29 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 19 Jun 2018 17:31:27 +0100
Date: Tue, 19 Jun 2018 09:31:18 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, luto@kernel.org,
 msuchanek@suse.de
Subject: Re: [PATCH v2 6/6] powerpc/pkeys: Deny read/write/execute by default
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <1528936144-6696-7-git-send-email-linuxram@us.ibm.com>
 <87602fx84g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <87602fx84g.fsf@concordia.ellerman.id.au>
Message-Id: <20180619163118.GE5294@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2018 at 10:39:59PM +1000, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > Deny all permissions on all keys, with some exceptions.  pkey-0 must
> > allow all permissions, or else everything comes to a screaching halt.
> > Execute-only key must allow execute permission.
> 
> Another ABI change.
> 
> Are we calling this a bug fix?

It is a ABI change. There are two cases where this could break an
existing application.

a) single threaded application, depending on the AMR bits of
	unallocated keys to do something.
       
	Not sure what one can achieve doing so.


b) Multithreaded application could see the difference. The scenarios is 
	i) Thread T2 allocates a key and associates with Memory M1
	ii) Thread T1 accesses the memory M1.

	Without the patch step (ii) will be successful.
	With the patch step (ii) will fail.

	I doubt any multithreaded applications are out there depending
	on this particular behavior. And if it does, than it is
	depending on a buggy behavior.

RP
