Return-Path: <jfree@sovereign.org>
Received: from sovereign.org (sovereign.org [66.93.224.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lux.homenet", Issuer "lux.homenet" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5AB9B2BEDF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 15:33:41 +1000 (EST)
From: Jim Freeman <jfree@sovereign.org>
Date: Tue, 12 Oct 2004 23:18:55 -0600
To: Dan Kegel <dank@kegel.com>
Message-ID: <20041013051855.GB9264@sovereign.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B0021B045A@hqemmail02.nvidia.com>
	<416BF876.4020606@kegel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <416BF876.4020606@kegel.com>
Cc: Stephen Warren <SWarren@nvidia.com>, crossgcc <crossgcc@sources.redhat.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: FW: NPTL support on PPC32 (MPC5200) ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I find that I have to apply the attached patch to

	contrib/crosstool-0.28-rc34-nptl_fixes.patch

or else I get the following error:

	+ cp
	/opt/src/crosstool-0.28-rc37/build/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/glibc-2.3.3/nptl/sysdeps/unix/sysv/linux/ppc/bits/pthreadtypes.h
	/opt/src/crosstool-0.28-rc37/result/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/powerpc-8540-linux-gnu/include/bits/pthreadtypes.h
	cp: cannot stat
	`/opt/src/crosstool-0.28-rc37/build/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/glibc-2.3.3/nptl/sysdeps/unix/sysv/linux/ppc/bits/pthreadtypes.h':
	No such file or directory

[ ARCH=ppc, but dirname = powerpc/ ]

The build hasn't finished yet, but at least it no longer dies at this
spot.

...jfree
========
On Tue, Oct 12, 2004 at 08:29:58AM -0700, Dan Kegel wrote:
> Hi Stephen,
> to build NPTL, you need to apply 
> contrib/crosstool-0.28-rc34-nptl_fixes.patch
> Then see demo-x86_64-nptl.sh
> 
> Enough people need this that I've been intending for two weeks to merge it 
> asap,
> but I haven't gotten around to it.
> 
> That patch was only tested for x86, but ppc32 shouldn't be any
> harder, right? :-)
> - Dan
> 
> Stephen Warren wrote:
> >Hi. I'm attempting to use your crosstool to build a NPTL capable GLIBC
> >and toolchain for a 32-bit PowerPC target.
> >
> >I'm finding it very difficult to find information on which libc, kernel,
> >compiler and binutils versions are required for this.
> >
> >Can you point me to any information that'll tell me definitively which
> >software versions support this, or at any mailing lists that are
> >appropriate for this kind of question? I tried
> >linuxppc-embedded@ozlabs.org (see attached email) but didn't hear
> >anything back.
> >
> >Thanks for any pointers at all!

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc_nptl.diff"

--- contrib/crosstool-0.28-rc34-nptl_fixes.patch	2004/10/13 04:48:11	1.1
+++ contrib/crosstool-0.28-rc34-nptl_fixes.patch	2004/10/13 04:48:45
@@ -164,7 +164,7 @@
 +        # will have to manually be copied from under the tree of the desired
 +        # target pthread implementation.
 +        cp ${GLIBC_DIR}/nptl/sysdeps/pthread/pthread.h $HEADERDIR/pthread.h
-+        cp ${GLIBC_DIR}/nptl/sysdeps/unix/sysv/linux/${ARCH}/bits/pthreadtypes.h $HEADERDIR/bits/pthreadtypes.h
++        cp ${GLIBC_DIR}/nptl/sysdeps/unix/sysv/linux/${ARCH/ppc/powerpc}/bits/pthreadtypes.h $HEADERDIR/bits/pthreadtypes.h
 +
 +        # On s390, powerpc and sparc we also require bits/wordsize.h.
 +        case $TARGET in

--IJpNTDwzlM2Ie8A6--
