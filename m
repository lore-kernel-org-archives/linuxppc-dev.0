Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 500EEB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 01:22:23 +1000 (EST)
Message-ID: <4E56689D.3080202@freescale.com>
Date: Thu, 25 Aug 2011 10:22:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: linux-next: build failure after merge of the final tree (tty
	tree related)
References: <20110825161843.daf46b6b4023926fcfeec387@canb.auug.org.au>
	<20110825140820.GA9126@kroah.com>
In-Reply-To: <20110825140820.GA9126@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH wrote:
>> > MSR_GS is defined in arch/powerpc/include/asm/reg_booke.h which is
>> > included by arch/powerpc/include/asm/reg.h but only when defined
>> > (CONFIG_BOOKE) || defined(CONFIG_40x).
> Thanks for the report.
> 
> Timur, care to send a fixup patch for this so this gets resolved?

Is there some trick to building allyesconfig on PowerPC?  When I do try that, I
get all sorts of weird build errors, and it dies long before it gets to my
driver.  I get stuff like:

  LD      arch/powerpc/sysdev/xics/built-in.o
WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1310): Section mismatch in
reference from the function .icp_native_init() to the function
.init.text:.icp_native_init_one_node()
The function .icp_native_init() references
the function __init .icp_native_init_one_node().
This is often because .icp_native_init lacks a __init
annotation or the annotation of .icp_native_init_one_node is wrong.

and

  AS      arch/powerpc/kernel/head_64.o
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1151: Error: attempt to move .org backwards
arch/powerpc/kernel/exceptions-64s.S:1160: Error: attempt to move .org backwards
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1

I guess I don't have the right compiler.

Anyway, I think I know how to fix the break that Stephen is seeing.  I will post
a v4 patch in a few minutes.


-- 
Timur Tabi
Linux kernel developer at Freescale
