Date: Fri, 11 Apr 2003 15:21:02 -0700
From: Rob Baxter <robb@synergy.synergy.encinitas.ca.us>
To: Rob Latham <rob@terizla.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc: optimized ppc bcopy
Message-ID: <20030411152102.A29581@synergy>
References: <20030411210449.GC92837@terizla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030411210449.GC92837@terizla.org>; from rob@terizla.org on Fri, Apr 11, 2003 at 04:04:49PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 11, 2003 at 04:04:49PM -0500, Rob Latham wrote:
>
> i noticed something when comparing lmbench numbers between os x and
> linux on the same hardware:  linux beats os x at every category except
> one: Bcopy (libc)
>
> *Local* Communication bandwidths in MB/s - bigger is better
> -----------------------------------------------------------
> Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
>                              UNIX      reread reread (libc) (hand) read write
> --------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
> aragorn   Linux 2.4.20- 198. 216. 90.1  206.5  173.1  122.8  124.2 173. 358.3
> os-x         Darwin 6.4 124. 121. 80.5  150.6  178.1  239.8  123.4 178. 411.9
>
> So i looked a bit closer at glibc: there are no optimized powerpc
> string or memory operations.  ( later confirmed by the glibc web
> pages)
>
> I know there are a zillion powerpc variants:  would it be hard to
> write assembly that works with all of them?  I know almost zero about
> powerpc assembly, but this might be a fun place to start learning.  Of
> course, if anyone else has already started such an undertaking, i'll
> defer to them and go work on something else.
>
> For those curious, the full lmbench run can be found here:
> http://terizla.org/~robl/pbook/benchmarks/lmbench-linux_vs_osx.1
> (linux does quite well :> )
>
> ==rob
>
> --
> Rob Latham                                        Chicago, IL USA
>

Another route would be the use of an AltiVec coded library variant:

http://e-www.motorola.com/webapp/sps/site/overview.jsp?nodeId=03C1TR0467mKqW5Nf2d9nb

Rob Baxter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
