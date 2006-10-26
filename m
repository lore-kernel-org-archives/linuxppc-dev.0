Return-Path: <jhf@columbus.rr.com>
Received: from ms-smtp-03.ohiordc.rr.com (ms-smtp-03.ohiordc.rr.com
	[65.24.5.137]) by ozlabs.org (Postfix) with ESMTP id 5858D67C0D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 16:11:41 +1000 (EST)
Date: Thu, 26 Oct 2006 02:11:32 -0400
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061026061131.GA9265@nineveh.rivenstone.net>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
From: jhf@columbus.rr.com (Joseph Fannin)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, 2006 at 01:56:41AM -0700, Andrew Morton wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
>

    The "Lazy interrupt disabling for 64-bit machines" patch
(which is in -rc2-mm2 through git-powerpc) seems to make -rc2-mm2
not build for ppc32 when KEXEC is enabled.  Building with kexec
enabled worked in -rc2-mm1.

    Building -mm2 fails when trying to make the vmlinux.  I don't have
the exact messages anymore, sorry, but it was an "undefined reference
to hard_irq_disable' in arch/powerpc/kernel/entry_32.S".  This appears
to be the result of an earlier warning about an "implicit
declaration of hard_irq_disable" in arch/powerpc/kernel/crash.c .

    (There's a comment at the top of that file that made it sound to
me like the file is for PPC64 only, but looking closer makes me think
that's not the case.)

    Backing out that "lazy interrupt" patch got -mm2 building again.
Turning kexec off works too.

    I don't use kexec, I just have it config'd on.  I doubt anyone is
actually using kexec in -mm on ppc32.  I'm just sayin'.

--
Joseph Fannin
jhf@columbus.rr.com
