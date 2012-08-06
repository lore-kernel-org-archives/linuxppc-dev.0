Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDEF92C0079
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2012 17:58:21 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Aug 2012 17:57:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q767vv2917825972
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2012 17:57:58 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q767vvon025806
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2012 17:57:57 +1000
Message-ID: <501F7904.4050206@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2012 13:27:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: how to implement platform specific per process parameter?
References: <501F514C.2090909@ozlabs.ru>
In-Reply-To: <501F514C.2090909@ozlabs.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> There are 4 options:

> 1. [not a kernel interface] use ptrace to execute the register changing
> command inside the specified pid. The next context switch saves the new
> value in the thread_struct. Dirty hack.
> 
> 2. Add a new syscall which would receive pid + register value and do the
> job. A bit too much.
> 
> 3. Add some hook in /proc filesystem but so far there were no platform
> specific bits, right?
> 
> 4. Implement a static node "/sys/devices/system/cpu/dscr_control".
> write() would parse the input stream, call scanf("%d %x", &pid, &dscr)
> and do the job.
> 


/sys/ interface would be appropriate I believe. But in this way we can take a new
(pid, dscr) and update thread_struct. But there should be a way to enlist all
(pid, dscr) values which are explicitly set by the user and different than that
of /sys/devices/system/cpu/dscr_default. So that we can know which process is holding
to what value of DSCR at any point of time.

 

> What is the correct approach? Thanks.
> 
> 


Regards
Anshuman
