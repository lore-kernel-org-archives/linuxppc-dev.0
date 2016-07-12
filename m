Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpkN40tdbzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 00:08:51 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: vgoyal@redhat.com, dyoung@redhat.com, bhe@redhat.com,
 bauerman@linux.vnet.ibm.com, arnd@arndb.de, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
Date: Tue, 12 Jul 2016 08:25:48 -0500
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org> (AKASHI
 Takahiro's message of "Tue, 12 Jul 2016 10:41:58 +0900")
Message-ID: <87furf7ztv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC 0/3] extend kexec_file_load system call
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AKASHI Takahiro <takahiro.akashi@linaro.org> writes:

> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
>   
> This patch extends kexec_file_load system call by adding an extra
> argument to this syscall so that an arbitrary number of file descriptors
> can be handed out from user space to the kernel.
>
> See the background [1].
>
> Please note that the new interface looks quite similar to the current
> system call, but that it won't always mean that it provides the "binary
> compatibility."
>
> [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html

So this design is wrong.  The kernel already has the device tree blob,
you should not be extracting it from the kernel munging it, and then
reinserting it in the kernel if you want signatures and everything to
pass.

What x86 does is pass it's equivalent of the device tree blob from one
kernel to another directly and behind the scenes.  It does not go
through userspace for this.

Until a persuasive case can be made for going around the kernel and
probably adding a feature (like code execution) that can be used to
defeat the signature scheme I am going to nack this.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I am happy to see support for other architectures, but for the sake of
not moving some code in the kernel let's not build an attackable
infrastructure.

Eric
