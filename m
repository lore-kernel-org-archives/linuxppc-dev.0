Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4042fG5g3GzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 02:09:09 +1100 (AEDT)
Date: Sun, 18 Mar 2018 11:08:57 -0400 (EDT)
Message-Id: <20180318.110857.1660518649370410007.davem@davemloft.net>
To: khalid.aziz@oracle.com
Cc: dave.hansen@linux.intel.com, aarcange@redhat.com,
 akpm@linux-foundation.org, allen.pais@oracle.com,
 aneesh.kumar@linux.vnet.ibm.com, anthony.yznaga@oracle.com, arnd@arndb.de,
 benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com,
 corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com,
 david.j.aldridge@oracle.com, dwindsor@gmail.com, ebiederm@xmission.com,
 elena.reshetova@intel.com, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
 henry.willard@oracle.com, hpa@zytor.com, hughd@google.com,
 imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
 jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
 khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
 ktkhai@virtuozzo.com, liam.merwick@oracle.com, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
 linux@roeck-us.net, me@tobin.cc, mgorman@suse.de,
 mgorman@techsingularity.net, mhocko@suse.com, mike.kravetz@oracle.com,
 minchan@kernel.org, mingo@kernel.org
Subject: Re: [PATCH v12 00/11] Application Data Integrity feature
 introduced by SPARC M7
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 10:15:42 -0700

> V12 changes:
> This series is same as v10 and v11 and was simply rebased on 4.16-rc2
> kernel and patch 11 was added to update signal delivery code to use the
> new helper functions added by Eric Biederman. Can mm maintainers please
> review patches 2, 7, 8 and 9 which are arch independent, and
> include/linux/mm.h and mm/ksm.c changes in patch 10 and ack these if
> everything looks good? 

Khalid I've applied this series to sparc-next, thank you!

But one thing has to be fixed up.

In uapi/asm/auxvec.h you conditionalize the ADI aux vectors on
CONFIG_SPARC64.

That's not correct, you should never control user facing definitions
based upon kernel configuration.

Also, both 32-bit and 64-bit applications running on ADI capable
machines want to compile against and use this informaiton.

So please remove these CPP checks.
