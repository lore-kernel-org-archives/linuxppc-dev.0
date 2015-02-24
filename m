Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBDD01A0FD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 06:05:52 +1100 (AEDT)
Received: by mail-vc0-f179.google.com with SMTP id hy4so10797757vcb.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 11:05:49 -0800 (PST)
Message-ID: <54ECCB89.9060309@candw.ms>
Date: Tue, 24 Feb 2015 15:05:45 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>
 <45dfe4c8990.73f22654@smtp.gmail.com>
In-Reply-To: <45dfe4c8990.73f22654@smtp.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/24/2015 7:10 AM, Julian Margetson wrote:
> Problems with  the Gib bisect
> Kernel wont compile after 10th bisect .
>
> drivers/built-in.o: In function `drm_mode_atomic_ioctl':
> (.text+0x865dc): undefined reference to `__get_user_bad'
> make: *** [vmlinux] Error 1
> root@julian-VirtualBox:/usr/src/linux# git bisect log
> git bisect start
> # bad: [c517d838eb7d07bbe9507871fab3931deccff539] Linux 4.0-rc1
> git bisect bad c517d838eb7d07bbe9507871fab3931deccff539
> # good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
> git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
> # good: [02f1f2170d2831b3233e91091c60a66622f29e82] kernel.h: remove ancient __FUNCTION__ hack
> git bisect good 02f1f2170d2831b3233e91091c60a66622f29e82
> # bad: [796e1c55717e9a6ff5c81b12289ffa1ffd919b6f] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
> git bisect bad 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
> # good: [9682ec9692e5ac11c6caebd079324e727b19e7ce] Merge tag 'driver-core-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 9682ec9692e5ac11c6caebd079324e727b19e7ce
> # good: [a9724125ad014decf008d782e60447c811391326] Merge tag 'tty-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect good a9724125ad014decf008d782e60447c811391326
> # good: [f43dff0ee00a259f524ce17ba4f8030553c66590] Merge tag 'drm-amdkfd-next-fixes-2015-01-25' of git://people.freedesktop.org/~gabbayo/linux into drm-next
> git bisect good f43dff0ee00a259f524ce17ba4f8030553c66590
> # bad: [cffe1e89dc9bf541a39d9287ced7c5addff07084] drm: sti: HDMI add audio infoframe
> git bisect bad cffe1e89dc9bf541a39d9287ced7c5addff07084
> # good: [2f5b4ef15c60bc5292a3f006c018acb3da53737b] Merge tag 'drm/tegra/for-3.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
> git bisect good 2f5b4ef15c60bc5292a3f006c018acb3da53737b
> # bad: [865844448ce80ccd714793e9ba4140d7ae214229] drm/udl: optimize udl_compress_hline16 (v2)
> git bisect bad 865844448ce80ccd714793e9ba4140d7ae214229
> # bad: [d47df63393ed81977e0f6435988d9cbd70c867f7] drm/panel: simple: Add AVIC TM070DDH03 panel support
> git bisect bad d47df63393ed81977e0f6435988d9cbd70c867f7
> # bad: [9469244d869623e8b54d9f3d4d00737e377af273] drm/atomic: Fix potential use of state after free
> git bisect bad 9469244d869623e8b54d9f3d4d00737e377af273
> root@julian-VirtualBox:/usr/src/linux#
>
>
>
> On 02/24/2015, you wrote:
>
>> On Fri, 2015-02-20 at 15:25 -0400, Julian Margetson wrote:
>>> On 2/18/2015 11:25 PM, Julian Margetson wrote:
>>>   re PPC4XX PCI(E) MSI support.
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html
>> Hmm, I think all those comments were addressed before it was merged.
>>
>> I tried to get a 4xx board going here last week, but it doesn't seem happy. I
>> can get a bit of uboot but then it hangs, might be overheating.
>>
>> cheers
>>
>>
>>
Kernel 4.0.0-rc1 boots ok when  DVI output used but not when HDMI output 
used.
