Return-Path: <cxie@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 75BB82C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2012 13:34:19 +1000 (EST)
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7T3YHdu024348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2012 23:34:17 -0400
Received: from localhost.localdomain ([10.66.13.237])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 q7T3YEdi016378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2012 23:34:16 -0400
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 29 Aug 2012 11:34:08 +0800
Subject: The MAX high_addr for `mmap` on PPC64
MIME-Version: 1.0
From: madper <cxie@redhat.com>
Message-ID: <op.wjr9i6t4xxpu98@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi every one,
     I use the ltp (Linux-Test-Project) and run it on both ppc64 and x86_64.
     There is a code like follows in  
`ltp/testcase/kernel/mem/hugetbl/hugemmap/hugemmap03.c`:
`code`
         #define HIGH_ADDR       (void *)(0x1000000000000)
	/* Attempt to mmap into highmem addr, should get ENOMEM */
	addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
	            MAP_SHARED | MAP_FIXED, fildes, 0);
`code ends`
     It return ENOMEM on x86_64 as well as we expected. But return EINVAL  
on ppc64. So I want to know the MAX high addr for PPC64.

-- 
Thanks,
Madper Xie.
