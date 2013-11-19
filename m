Return-Path: <michael@ellerman.id.au>
Date: Tue, 19 Nov 2013 15:04:56 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH powerpc] Fix compiling error in powernv/rng.c
Message-ID: <20131119040455.GB27740@concordia>
References: <1384500964.2491.11.camel@ThinkPad-T5421>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384500964.2491.11.camel@ThinkPad-T5421>
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 03:36:04PM +0800, Li Zhong wrote:
> This is seen when CONFIG_SMP is not enabled:
> 
> arch/powerpc/platforms/powernv/rng.c: In function 'rng_init_per_cpu':
> arch/powerpc/platforms/powernv/rng.c:74: error: implicit declaration of function 'cpu_to_chip_id'

Hi Li,

We try whenever possible to avoid adding #ifdefs in C code.

Also on a multi chip system where there are multiple RNGs, your code for
UP will not necessarily choose the RNG on the same core as the cpu.

I have a different fix that I will send.

cheers
