Return-Path: <laurent@vivier.eu>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E85A1A0D7A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 22:34:27 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com>
 <1446851564.14282.40.camel@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <563DE1B3.4060402@vivier.eu>
Date: Sat, 7 Nov 2015 12:34:11 +0100
MIME-Version: 1.0
In-Reply-To: <1446851564.14282.40.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/11/2015 00:12, Benjamin Herrenschmidt a écrit :
> On Fri, 2015-11-06 at 15:09 -0600, Scott Wood wrote:
>> On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
>>> When I try to cross compile a ppc64 kernel, it generally
>>> fails on the VDSO stage. This is true for powerpc64 cross-
>>> compiler, but also when I try to build a ppc64le kernel
>>> on a ppc64 host.
>>>
>>> VDSO64L fails:
>>>
>>>   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
>>> /usr/bin/powerpc64-linux-gnu-ld:
>>> arch/powerpc/kernel/vdso64/sigtramp.o:
>>> file class ELFCLASS64 incompatible with ELFCLASS32
>>> /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong
>>> format
>>>
>>> This fails because gcc calls "collect2" with
>>> "--oformat elf32-powerpcle" with ppc64 objects, without the
>>> "--oformat" ld works well because it use the format of the
>>> first object as output format.
>>>
>>> As this case is correctly managed to build the other kernel
>>> objects, this patch replaces $(GCC) by $(LD) to generate the
>>> VDSO objects.
> 
> This is LE ? I think that's a bug in binutils or gcc ... I remember we
> fought that a while ago for the openpower builds. It might have been
> fixed in upstream toolchain.

Yes, Segher has given me the commit id. It is just what I need.

Laurent
