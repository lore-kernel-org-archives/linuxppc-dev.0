Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 99908679EB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 16:13:17 +1000 (EST)
Date: Mon, 17 Apr 2006 23:12:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: [PATCH] ppc64-soft-reset-fixes
Message-Id: <20060417231235.36546cb6.akpm@osdl.org>
In-Reply-To: <4443D738.3040704@us.ibm.com>
References: <4443D738.3040704@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Wilder <dwilder@us.ibm.com> wrote:
>
>  - For the crash scenario, when a CPU hangs with interrupts disabled and 
>  the other CPUs panic or user invoked kdump boot using sysrq-c. In this 
>  case, the hung CPU can not be stopped and causes the kdump boot not 
>  successful. This case can be treated as complete system hang and asks 
>  the user to activate soft-reset if all secondary CPUs are not stopped.

It breaks `make allmodconfig':

arch/powerpc/kernel/built-in.o(.toc+0x2a00): In function `PPC64_CACHES':
: undefined reference to `kexec_crash_image'
