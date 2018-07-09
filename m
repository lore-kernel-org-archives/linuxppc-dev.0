Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PNwP6h0CzDr02
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 21:51:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
In-Reply-To: <20180707221316.5b75e075@roar.ozlabs.ibm.com>
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
 <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
 <4f3a5969-88d5-134d-508d-7617947c588c@infradead.org>
 <20180707221316.5b75e075@roar.ozlabs.ibm.com>
Date: Mon, 09 Jul 2018 21:51:44 +1000
Message-ID: <87601oaapb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri, 6 Jul 2018 21:58:29 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> On 07/06/2018 06:45 PM, Benjamin Herrenschmidt wrote:
>> > On Thu, 2018-07-05 at 14:30 -0700, Randy Dunlap wrote:  
>> >> Hi,
>> >>
>> >> Is there a good way (or a shortcut) to do something like:
>> >>
>> >> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>> >>   to get a PPC32/32BIT allmodconfig
>> >>
>> >> and also be able to do:
>> >>
>> >> $make ARCH=powerpc O=PPC64 [other_options] allmodconfig
>> >>   to get a PPC64/64BIT allmodconfig?  
>> > 
>> > Hrm... O= is for the separate build dir, so there much be something
>> > else.
>> > 
>> > You mean having ARCH= aliases like ppc/ppc32 and ppc64 ?  
>> 
>> Yes.
>> 
>> > That would be a matter of overriding some .config defaults I suppose, I
>> > don't know how this is done on other archs.
>> > 
>> > I see the aliasing trick in the Makefile but that's about it.
>> >   
>> >> Note that arch/x86, arch/sh, and arch/sparc have ways to do
>> >> some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
>> >> sh and sparc based on a recent "fix" patch from me):  
>> > 
>> > I fail to see what you are actually talking about here ... sorry. Do
>> > you have concrete examples on x86 or sparc ? From what I can tell the
>> > "i386" or "sparc32/sparc64" aliases just change SRCARCH in Makefile and
>> > 32 vs 64-bit is just a Kconfig option...  
>> 
>> Yes, your summary is mostly correct.
>> 
>> I'm just looking for a way to do cross-compile builds that are close to
>> ppc32 allmodconfig and ppc64 allmodconfig.
>
> Would there a problem with adding ARCH=ppc32 / ppc64 matching? This
> seems to work...

It's a cute trick but I'd rather avoid it.

It overloads ARCH which can be confusing to people and tools. For
example I'd have to special case it in kisskb.

I think we can achieve a similar result by having more PHONY defconfig
targets.

eg, we can do ppc32_allmodconfig like below. And if there's interest we
could do a 4xx_allmodconfig etc.

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2ea575cb3401..2556c2182789 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
 	$(call merge_into_defconfig,mpc86xx_basic_defconfig,\
 		86xx-smp 86xx-hw fsl-emb-nonhw)
 
+PHONY += ppc32_allmodconfig
+ppc32_allmodconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
+		-f $(srctree)/Makefile allmodconfig
+
 define archhelp
   @echo '* zImage          - Build default images selected by kernel config'
   @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
diff --git a/arch/powerpc/configs/book3s_32.config b/arch/powerpc/configs/book3s_32.config
new file mode 100644
index 000000000000..8721eb7b1294
--- /dev/null
+++ b/arch/powerpc/configs/book3s_32.config
@@ -0,0 +1,2 @@
+CONFIG_PPC64=n
+CONFIG_PPC_BOOK3S_32=y


cheers
