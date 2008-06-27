Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 32E3FDDF06
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:39:29 +1000 (EST)
Date: Fri, 27 Jun 2008 09:23:09 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 0/3] sched: allow arch override of cpu power
Message-ID: <20080627142309.GR9594@localdomain>
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
	<4863F2CC.1030907@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4863F2CC.1030907@linux.vnet.ibm.com>
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

Breno Leitao wrote:
> Nathan Lynch wrote:
>> There is an "interesting" quality of POWER6 cores, which each have 2
>> hardware threads: assuming one thread on the core is idle, the primary
>> thread is a little "faster" than the secondary thread.  To illustrate:
>>   
> I found this feature interesting and decided to do some tests.
> After some tests I found that the example you post really runs fast in  
> the first CPU, but a more "elaborated" application runs slower on the  
> first CPU.
> Here is a small example:
>
> # taskset 0x1 time -f "%e,  %U, %S" ./a.out ; taskset 0x2 time -f "%e,  
> %U, %S" ./a.out
> 10.77,  10.72, 0.01
> 10.53, 10.48, 0.01
>
> # taskset 0x2 time -f "%e,  %U, %S" ./a.out ; taskset 0x1 time -f "%e,  
> %U, %S" ./a.out
> 10.55,  10.50, 0.01
> 10.77, 10.72, 0.01

I've been able to duplicate your results, thanks for the testcase.
Guess I'll need to understand what's going on before continuing with
this...
