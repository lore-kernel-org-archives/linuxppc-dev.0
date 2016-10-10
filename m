Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st0Hg3hrPzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 23:46:38 +1100 (AEDT)
Subject: Re: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20161009152121.GA13188@roeck-us.net>
 <87wphg68wb.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d3bd505d-e484-6720-f7a2-1fe66e4dcb68@roeck-us.net>
Date: Mon, 10 Oct 2016 05:46:34 -0700
MIME-Version: 1.0
In-Reply-To: <87wphg68wb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 10/09/2016 11:00 PM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
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
>
> Thanks for the report.
>
> I do test qemu mac99 as part of my CI, and it's booting OK, so there
> must be some config difference?
>
> I'm using pmac32_defconfig plus:
>
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_SERIAL_PMACZILOG=y
> CONFIG_SERIAL_PMACZILOG_TTYS=n
> CONFIG_SERIAL_PMACZILOG_CONSOLE=y
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
>
> And running with:
>
> $ qemu-system-ppc -nographic -vga none -M mac99 -m 1G -kernel vmlinux -initrd $HOME/static/ppc32-initrd.gz -append "console=ttyPZ0 init=/bin/sh"
>

I am building a 64bit image, and my test runs with qemu-system-ppc64.
My 32bit tests for mac99 are fine as well.

Guenter
