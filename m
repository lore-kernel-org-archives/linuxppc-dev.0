Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6309AC761A6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Apr 2023 15:16:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrWZ16mSpz3fGQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Apr 2023 01:16:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrWXt4k6Mz3cf8
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2023 01:15:25 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 334FADOc011641;
	Tue, 4 Apr 2023 10:10:13 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 334FAAO1011634;
	Tue, 4 Apr 2023 10:10:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 4 Apr 2023 10:10:10 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Always build with 128-bit long double
Message-ID: <20230404151010.GC25951@gate.crashing.org>
References: <20230404102847.3303623-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404102847.3303623-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dan@danny.cz, daniel@octaforge.org, amd-gfx@lists.freedesktop.org, tpearson@raptorengineering.com, alexdeucher@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Apr 04, 2023 at 08:28:47PM +1000, Michael Ellerman wrote:
> The amdgpu driver builds some of its code with hard-float enabled,
> whereas the rest of the kernel is built with soft-float.
> 
> When building with 64-bit long double, if soft-float and hard-float
> objects are linked together, the build fails due to incompatible ABI
> tags.

> Currently those build errors are avoided because the amdgpu driver is
> gated on 128-bit long double being enabled. But that's not a detail the
> amdgpu driver should need to be aware of, and if another driver starts
> using hard-float the same problem would occur.

Well.  The kernel driver either has no business using long double (or
any other floating point even) at all, or it should know exactly what is
used: double precision, double-double, or quadruple precision.  Both of
the latter two are 128 bits.

> All versions of the 64-bit ABI specify that long-double is 128-bits.
> However some compilers, notably the kernel.org ones, are built to use
> 64-bit long double by default.

Mea culpa, I suppose?  But builddall doesn't force 64 bit explicitly.
I wonder how this happened?  Is it maybe a problem in the powerpc64le
config in GCC itself?  I have a patch from summer last year (Arnd's
toolchains are built without it) that does
+       powerpc64le-*)  TARGET_GCC_CONF=--with-long-double-128
Unfortunately I don't remember why I did that, and I never investigated
what the deeper problem is :-/

In either case, the kernel should always use specific types, not rely on
the toolchain to pick a type that may or may not work.  The correct size
floating point type alone is not enough, but it is a step in the right
direction certainly.

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
