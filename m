From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Ben Stanley" <bds02@uow.edu.au>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] remove #ifdef __KERNEL__ from atomic.h
Date: Wed, 25 Sep 2002 10:45:12 +0200
Message-Id: <20020925084512.18469@192.168.4.1>
In-Reply-To: <3D914574.7030300@uow.edu.au>
References: <3D914574.7030300@uow.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I was trying to compile sumji (formerly xtunes), which requires
>libCommonC++. I found that libCommonC++ would not compile, because it
>needs to use the atomic functions declared in include/asm-ppc/atomic.h .
>However, this file does not declare these functions unless __KERNEL__ is
>defined. I believe that this is incorrect.
>
>I have checked the i386 and s390 versions of atomic.h and they declare
>the atomic functions regardless of the status of the __KERNEL__ macro.
>Therefore I propose that it should be removed from asm-ppc/atomic.h, and
>have attached a patch to effect this.
>
>With this patch applied, I am able to compile libCommonC++.

This is wrong. The definitions in asm-ppc/atomic.h belong to the
kernel only and are not guaranteed to work outside of the kernel
environement. Typically, the 4xx version use some errata workaround
macros that rely on some of the kernel's CONFIG_xxx.

You should implement your own version of the atomic ops in userland
(and you should do that for i386 and s390 as well, it's just wrong
to use the kernel versions like this). Also your implementation
should probably add the sync that is needed for workaround of some
PPC 4xx bugs (see the version in the linuxppc_2_4_devel tree)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
