Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bN2C98zF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:16 +1100 (AEDT)
In-Reply-To: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 =?utf-8?q?Michal_Such=C3=A1n?= =?utf-8?q?ek?= <msuchanek@suse.de>,
 Dave Young <dyoung@redhat.com>
Subject: Re: powerpc: kexec_file: Fix error code when trying to load kdump
 kernel
Message-Id: <40D0bL6Ncvz9s3v@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-29 at 19:05:43 UTC, Thiago Jung Bauermann wrote:
> kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
> returns -ENOTSUPP in that case.
> 
> I've recently learned that this errno is internal to the kernel and isn't
> supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
> is defined in an uapi header.
> 
> This does indeed make kexec-tools happier. Before the patch, on ppc64le:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Unknown error 524
> 
> After the patch:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Operation not supported
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Reported-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Reviewed-by: Simon Horman <horms@verge.net.au>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bf8a1abc3ddbd6e9a8312ea7d96e5d

cheers
