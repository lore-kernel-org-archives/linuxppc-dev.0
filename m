From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15761.26951.11211.147081@argo.ozlabs.ibm.com>
Date: Wed, 25 Sep 2002 17:44:07 +1000 (EST)
To: Ben Stanley <bds02@uow.edu.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] remove #ifdef __KERNEL__ from atomic.h
In-Reply-To: <3D914574.7030300@uow.edu.au>
References: <3D914574.7030300@uow.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben Stanley writes:

> I was trying to compile sumji (formerly xtunes), which requires
> libCommonC++. I found that libCommonC++ would not compile, because it
> needs to use the atomic functions declared in include/asm-ppc/atomic.h .
> However, this file does not declare these functions unless __KERNEL__ is
> defined. I believe that this is incorrect.

This has been gone over many times, user programs shouldn't be using
kernel headers.  I don't mind if you change /usr/include/asm/atomic.h,
that's a glibc header not a kernel header, but the #ifdef __KERNEL__
in the kernel header is there precisely to catch this sort of error.

(And of course /usr/include/asm should NOT be a symlink into the
kernel sources.)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
