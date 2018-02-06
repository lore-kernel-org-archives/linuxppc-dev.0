Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbQ465FDszF0Z0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 00:17:41 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w16DGxLc006091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Feb 2018 08:17:39 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fybrbc6hj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 08:17:39 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 6 Feb 2018 06:17:38 -0700
Subject: Re: Kernel 4.15 lost set_robust_list support on POWER 9
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Jiri Slaby <jslaby@suse.cz>
References: <3ef0c599-0285-e77a-c002-e21152823fb8@redhat.com>
 <d5f533cf-bd97-794a-38e8-6b6d8c005023@linux.vnet.ibm.com>
 <1517867731.2312.146.camel@au1.ibm.com>
 <20180206110616.5d1d5881@roar.ozlabs.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 11:17:31 -0200
MIME-Version: 1.0
In-Reply-To: <20180206110616.5d1d5881@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <135fc358-3595-67aa-cf52-a13ec35ad9db@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/05/2018 11:06 PM, Nicholas Piggin wrote:
> Does this help?
> 
> powerpc/64s/radix: allocate guard-PID for kernel contexts at boot

Yes, the test-case passes:

     # strace -e set_robust_list -f ./test
     set_robust_list(0x7fff8d453910, 24)     = 0
     +++ exited with 0 +++

     # uname -r
     4.15.0.guardpid

Thanks!

cheers,
Mauricio
