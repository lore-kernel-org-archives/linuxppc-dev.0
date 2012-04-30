Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3659B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 13:40:58 +1000 (EST)
Message-ID: <1335757246.20866.31.camel@pasglop>
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Mon, 30 Apr 2012 13:40:46 +1000
In-Reply-To: <1335753820.20866.27.camel@pasglop>
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
 <20120403.180302.342779808900865443.davem@davemloft.net>
 <1333491102.3040.12.camel@pasglop> <1335753820.20866.27.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kaffeemonster@googlemail.com, eric.dumazet@gmail.com, matt@ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-04-30 at 12:43 +1000, Benjamin Herrenschmidt wrote:

> Ok, he hasn't so I'll dig a bit.
> 
> No obvious wrongness (but I'm not very familiar with bpf), though I do
> have a comment: sk_negative_common() and bpf_slow_path_common() should
> be made one and single macro which takes the fallback function as an
> argument.
> 
> I'll mess around & try to test using Jan test case & will come back
> with an updated patch.

Wow, hit that nasty along the way: The test program will not work
on big endian machines because of a nasty difference between
the kernel struct sock_fprog and libpcap struct bpf_program:

Kernel expects:

struct sock_fprog {     /* Required for SO_ATTACH_FILTER. */
        unsigned short          len;    /* Number of filter blocks */
        struct sock_filter __user *filter;
};

libpcap provides:

struct bpf_program {
        u_int bf_len;
        struct bpf_insn *bf_insns;
};

Note the unsigned short vs. unsigned int there ? This totally
breaks it here.

Is it expected that one can pass a struct bpf_program directly
to the kernel or should it be "converted" by the library in which
case it's just a bug in Jan's test program ?

Cheers,
Ben.
