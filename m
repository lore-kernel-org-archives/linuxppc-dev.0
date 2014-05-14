Return-Path: <amodra@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED4111400D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:42:44 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id bj1so1233188pad.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 22:42:41 -0700 (PDT)
Date: Wed, 14 May 2014 15:12:36 +0930
From: Alan Modra <amodra@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140514054236.GK5162@bubble.grove.modra.org>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
 <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140514133434.13b66009@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 14, 2014 at 01:34:34PM +1000, Stephen Rothwell wrote:
> OK, this appears to be an assembler bug.

Agreed.  Upgrade binutils!

> $ cat test.s
> 	.text
> x:
> 	.pushsection	b, "a"
> 	beq y
> 	.popsection
> 	.=0x80000
> y:
> $ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as --version
> GNU assembler (GNU Binutils) 2.22
> This assembler was configured for a target of `powerpc64-linux'.
> $ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o test.o test.s 
> test.s: Assembler messages:
> test.s:4: Error: operand out of range (0x0000000000080000 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> $ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as --version
> GNU assembler (GNU Binutils) 2.23.52.20130512
> This assembler was configured for a target of `powerpc64-linux'.
> $ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o test.o test.s 
> (no error)
> 
> Alan, can you shed light on when it was fixed?

2012-11-05
https://sourceware.org/ml/binutils/2012-11/msg00043.html
git show 3b8b57a9495016b2b02fbc2612dd1607d4b6f9ba

The part that actually fixes this problem is "Leave insn field zero...".

-- 
Alan Modra
Australia Development Lab, IBM
