Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C31CC1A0895
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 19:44:26 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 2 Apr 2015 14:14:23 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 369BE1258044
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:16:03 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t328iIQe51511376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:14:19 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t328iH7Q003611
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:14:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
In-Reply-To: <87y4og70nu.fsf@linux.vnet.ibm.com>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au> <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au> <87y4og70nu.fsf@linux.vnet.ibm.com>
Date: Thu, 02 Apr 2015 14:14:18 +0530
Message-ID: <87ego2c42l.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
....
....
> With patch:
> sys: 0m11.3258
>
> ie, a -0.7% impact 
>
> If that impact is high we could possibly put that tracepoint within #ifdef
> CONFIG_DEBUG_VM ?

Since the ebizzy runs results were not stable, I did a micro benchmark
to measure this and I noticed that results observed are within the
run variance of the test. I made sure we don't have context-switches
between the runs. If I try to get large number of page-faults, we end up
with context switches.

for ex: We get without patch
--------------------------------
root@qemu-pr-host trace-fault]# bash run 

 Performance counter stats for './a.out 3000 300':

               643      page-faults               #    0.089 M/sec                  
          7.236562      task-clock (msec)         #    0.928 CPUs utilized          
         2,179,213      stalled-cycles-frontend   #    0.00% frontend cycles idle   
        17,174,367      stalled-cycles-backend    #    0.00% backend  cycles idle   
                 0      context-switches          #    0.000 K/sec                  

       0.007794658 seconds time elapsed

[root@qemu-pr-host trace-fault]# 

And with-patch:
---------------
[root@qemu-pr-host trace-fault]# bash run 

 Performance counter stats for './a.out 3000 300':

               643      page-faults               #    0.089 M/sec                  
          7.233746      task-clock (msec)         #    0.921 CPUs utilized          
                 0      context-switches          #    0.000 K/sec                  

       0.007854876 seconds time elapsed


 Performance counter stats for './a.out 3000 300':

               643      page-faults               #    0.087 M/sec                  
               649      powerpc:hash_fault        #    0.087 M/sec                  
          7.430376      task-clock (msec)         #    0.938 CPUs utilized          
         2,347,174      stalled-cycles-frontend   #    0.00% frontend cycles idle   
        17,524,282      stalled-cycles-backend    #    0.00% backend  cycles idle   
                 0      context-switches          #    0.000 K/sec                  

       0.007920284 seconds time elapsed

[root@qemu-pr-host trace-fault]# 
