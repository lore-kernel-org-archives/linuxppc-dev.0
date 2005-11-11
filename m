Return-Path: <sjmunroe@us.ibm.com>
In-Reply-To: <1131747209.24637.255.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
From: Steve Munroe <sjmunroe@us.ibm.com>
Message-ID: <OF64F7B949.DD4E083C-ON862570B6.007B524B-862570B6.007BCC7D@us.ibm.com>
Date: Fri, 11 Nov 2005 16:32:11 -0600
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Tom Gall <tom_gall@vnet.ibm.com>,
	munroesj@us.ibm.com, libc-alpha@sources.redhat.com,
	linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] glibc vDSO bits for ppc/ppc64 update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 11/11/2005 
04:13:28 PM:

> 
> > Additional hp_timer_t is now declared as unsigned long long int 
> > to match up with benh's get_tbfreq on 32 bit ppc. (ppc64 is already
> > 64 bit)
> 
> I'm not sure having hp_timer_t be 64 bits on 32 bits libraries is the
> right thing to do. I suppose it's a matter of performances tradeoff. The
> fact that the vDSO __kernel_get_tbfreq() returns a long long doesn't
> force you to use a long long hp_timer_t, the vDSO doesn't have to return
> a value of type hp_timer_t :)
> 
> I did that on the vDSO to avoid having to change the vDSO interface if
> we ever have to deal with >4Ghz time sources.
> 

A 64-bit timebase is required to the use hp-timing for clock_gettime(
CLOCK_PROCESS_CPUTIME_ID, ) and  clock_gettime(CLOCK_THREAD_CPUTIME_ID, ). 


So 64-bit it is.

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
