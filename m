Date: Fri, 11 Apr 2003 16:04:49 -0500
From: Rob Latham <rob@terizla.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: glibc: optimized ppc bcopy
Message-ID: <20030411210449.GC92837@terizla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i noticed something when comparing lmbench numbers between os x and
linux on the same hardware:  linux beats os x at every category except
one: Bcopy (libc)

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
aragorn   Linux 2.4.20- 198. 216. 90.1  206.5  173.1  122.8  124.2 173. 358.3
os-x         Darwin 6.4 124. 121. 80.5  150.6  178.1  239.8  123.4 178. 411.9

So i looked a bit closer at glibc: there are no optimized powerpc
string or memory operations.  ( later confirmed by the glibc web
pages)

I know there are a zillion powerpc variants:  would it be hard to
write assembly that works with all of them?  I know almost zero about
powerpc assembly, but this might be a fun place to start learning.  Of
course, if anyone else has already started such an undertaking, i'll
defer to them and go work on something else.

For those curious, the full lmbench run can be found here:
http://terizla.org/~robl/pbook/benchmarks/lmbench-linux_vs_osx.1
(linux does quite well :> )

==rob

--
Rob Latham                                        Chicago, IL USA

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
