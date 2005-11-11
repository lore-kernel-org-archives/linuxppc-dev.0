Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Gall <tom_gall@vnet.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0511111555580.6838@triton>
References: <Pine.LNX.4.64.0511111555580.6838@triton>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 09:13:28 +1100
Message-Id: <1131747209.24637.255.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, munroesj@us.ibm.com,
	libc-alpha@sources.redhat.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] glibc vDSO bits for ppc/ppc64 update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Additional hp_timer_t is now declared as unsigned long long int 
> to match up with benh's get_tbfreq on 32 bit ppc. (ppc64 is already
> 64 bit)

I'm not sure having hp_timer_t be 64 bits on 32 bits libraries is the
right thing to do. I suppose it's a matter of performances tradeoff. The
fact that the vDSO __kernel_get_tbfreq() returns a long long doesn't
force you to use a long long hp_timer_t, the vDSO doesn't have to return
a value of type hp_timer_t :)

I did that on the vDSO to avoid having to change the vDSO interface if
we ever have to deal with >4Ghz time sources.

Ben.
