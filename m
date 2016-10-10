Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st2Fz73vyzDrbk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 01:15:19 +1100 (AEDT)
Subject: Re: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
To: Nicholas Piggin <npiggin@gmail.com>
References: <20161009152121.GA13188@roeck-us.net>
 <20161010164953.5f37e6e4@roar.ozlabs.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d55b4014-1265-da65-1698-2860d3acd603@roeck-us.net>
Date: Mon, 10 Oct 2016 07:15:11 -0700
MIME-Version: 1.0
In-Reply-To: <20161010164953.5f37e6e4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/09/2016 10:49 PM, Nicholas Piggin wrote:
> On Sun, 9 Oct 2016 08:21:21 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> Nicholas,
>>
>> some of my qemu tests for ppc64 started failing on mainline (and -next).
>> You can find a test log at
>> http://kerneltests.org/builders/qemu-ppc64-master/builds/580/steps/qemubuildcommand/logs/stdio
>>
>> The scripts to run the test are available at
>> https://github.com/groeck/linux-build-test/tree/master/rootfs/ppc64
>>
>> Bisect points to commit f9aa67142ef26 ("powerpc/64s: Consolidate Alignment 0x600
>> interrupt"). Bisect log is attached.
>>
>> Since I don't have the means to run the code on a real system, I have no idea
>> if the problem is caused by qemu or by the code. It is interesting, though, that
>> only the 'mac99' tests are affected.
>>
>> Please let me know if there is anything I can do to help tracking down the
>> problem.
>
> Thanks for this. That patch just moves a small amount of code, so it's likely
> that it's caused something to get placed out of range of its caller, or the
> linker started generating a stub for some reason. I can't immediately see the
> problem, but it could be specific to your exact toolchain.
>
> Something that might help, would you be able to put the compiled vmlinux binaries
> from before/after the bad patch somewhere I can grab them?
>

http://server.roeck-us.net/qemu/ppc64/mac99/

'bad' is at f9aa67142ef26, 'good' is one commit earlier, 'tot' is from top of tree
(b66484cd7470, more specifically).

Key difference in System.map, from the bad case:

c000000000005c00 T __end_interrupts
c000000000007000 t end_virt_trampolines
c000000000008000 t 00000010.long_branch.power4_fixup_nap+0
c000000000008100 t fs_label
c000000000008100 t start_text

00000010.long_branch.power4_fixup_nap+0 does not exist in the good case,
and fs_label/start_text are at c000000000008000.

Toolchain is from poky 1.5.1, which uses gcc 4.8.1 and binutils 2.23.2.
I also tried with the toolchain from poky 1.6, using gcc 4.8.2 and binutils 2.24,
with the same result.

Guenter
