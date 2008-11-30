Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix system calls on Cell entered with XER.SO=1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18739.2681.351794.669476@cargo.ozlabs.ibm.com>
References: <18739.2681.351794.669476@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 08:59:42 +1100
Message-Id: <1228082382.7356.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-01 at 08:49 +1100, Paul Mackerras wrote:
> It turns out that on Cell, on a kernel with CONFIG_VIRT_CPU_ACCOUNTING
> = y, if a program sets the SO (summary overflow) bit in the XER and
> then does a system call, the SO bit in CR0 will be set on return
> regardless of whether the system call detected an error.  Since CR0.SO
> is used as the error indication from the system call, this means that
> all system calls appear to fail.
> 
> The reason is that the workaround for the timebase bug on Cell uses a
> compare instruction.  With CONFIG_VIRT_CPU_ACCOUNTING = y, the
> ACCOUNT_CPU_USER_ENTRY macro reads the timebase, so we end up doing a
> compare instruction, which copies XER.SO to CR0.SO.  Since we were
> doing this in the system call entry patch after clearing CR0.SO but
> before saving the CR, this meant that the saved CR image had CR0.SO
> set if XER.SO was set on entry.
> 
> This fixes it by moving the clearing of CR0.SO to after the
> ACCOUNT_CPU_USER_ENTRY call in the system call entry path.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
