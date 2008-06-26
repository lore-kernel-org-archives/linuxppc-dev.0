Return-Path: <leitao@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A335E0A7F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 05:49:42 +1000 (EST)
Received: from mailhub3.br.ibm.com (unknown [9.18.232.110])
	by igw3.br.ibm.com (Postfix) with ESMTP id 45CC739017E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:32:33 -0300 (BRST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m5QJnaXS2363564
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:49:37 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5QJnV6Q016658
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:49:32 -0300
Message-ID: <4863F2CC.1030907@linux.vnet.ibm.com>
Date: Thu, 26 Jun 2008 16:49:32 -0300
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH 0/3] sched: allow arch override of cpu power
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
In-Reply-To: <1213835374-10868-1-git-send-email-ntl@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nathan,

Nathan Lynch wrote:
> There is an "interesting" quality of POWER6 cores, which each have 2
> hardware threads: assuming one thread on the core is idle, the primary
> thread is a little "faster" than the secondary thread.  To illustrate:
>   
I found this feature interesting and decided to do some tests.
After some tests I found that the example you post really runs fast in 
the first CPU, but a more "elaborated" application runs slower on the 
first CPU.
Here is a small example:

# taskset 0x1 time -f "%e,  %U, %S" ./a.out ; taskset 0x2 time -f "%e, 
%U, %S" ./a.out
10.77,  10.72, 0.01
10.53, 10.48, 0.01

# taskset 0x2 time -f "%e,  %U, %S" ./a.out ; taskset 0x1 time -f "%e, 
%U, %S" ./a.out
10.55,  10.50, 0.01
10.77, 10.72, 0.01

# cat calc.c
#include <stdio.h>

int main(){
    int j = 0;
    float i = 42;
   
    srand(123);
    while (j++ < 100000000){
        i = i*i + i;
        i = i/2 + random(2);
    }

    printf("%d\n", i);
    return 0;
}
# cat /proc/cpuinfo
processor    : 0
cpu        : POWER6 (architected), altivec supported
clock        : 5000.001000MHz
revision    : 3.2 (pvr 003e 0302)

processor    : 1
cpu        : POWER6 (architected), altivec supported
clock        : 5000.001000MHz
revision    : 3.2 (pvr 003e 0302)
...

Note that the IRQ are balanced among the 8 CPUs, and the machine is idle.
Do you know why I get this difference? Something wrong with the test?

Thanks

- 
Breno Leitao
Linux Technology Center Brazil
Phone: +55-16-8115-3915 (T/L: 839-1293)
leitao@linux.vnet.ibm.com
