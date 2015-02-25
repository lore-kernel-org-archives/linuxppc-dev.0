Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E8441A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 00:27:01 +1100 (AEDT)
Received: by mail-vc0-f172.google.com with SMTP id kv7so1297289vcb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 05:26:58 -0800 (PST)
Message-ID: <54EDCD9E.5010104@candw.ms>
Date: Wed, 25 Feb 2015 09:26:54 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Gerhard Pircher <gerhard_pircher@gmx.net>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>
 <54ECDE7D.6070303@candw.ms>
In-Reply-To: <54ECDE7D.6070303@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------090807060807070200050402"
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090807060807070200050402
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Verified that the problems with the

radeon: ring 0 test failed error

go back to at least  Kernel 3.0.1

On 2/24/2015 4:26 PM, Julian Margetson wrote:
> Thanks
>
> after skipping several times :
>
> git bisect skip
>
> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> b486e0e6d599b9ca8667fb9a7d49b7383ee963c7
> eab3bbeffd152125ae0f90863b8e9bc8eef49423
> 960cd9d4fef6dd9e235c0e5c0d4ed027f8a48025
> f02ad907cd9e7fe3a6405d2d005840912f1ed258
> 6a425c2a9b37ca3d2c37e3c1cdf973dba53eaa79
> ee0a89cf3c2c550e6d877dda21dd2947afb90cb6
> 92890583627ee2a0518e55b063fcff86826fef96
> 95d6eb3b134e1826ed04cc92b224d93de13e281f
> 9469244d869623e8b54d9f3d4d00737e377af273
> We cannot bisect more!
>
>
>
> On 2/24/2015 3:14 PM, Gerhard Pircher wrote:
>> Am 2015-02-24 um 12:08 schrieb Julian Margetson:
>>> Problems with  the Gib bisect
>>> Kernel wont compile after 10th bisect .
>> You can try "git bisect skip" to select another commit for testing.
>> Hopefully that one compiles fine then.
>>
>> Gerhard
>>
>>> drivers/built-in.o: In function `drm_mode_atomic_ioctl':
>>> (.text+0x865dc): undefined reference to `__get_user_bad'
>>> make: *** [vmlinux] Error 1
>>> root@julian-VirtualBox:/usr/src/linux# git bisect log
>>> git bisect start
>>> # bad: [c517d838eb7d07bbe9507871fab3931deccff539] Linux 4.0-rc1
>>> git bisect bad c517d838eb7d07bbe9507871fab3931deccff539
>>> # good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
>>> git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
>>> # good: [02f1f2170d2831b3233e91091c60a66622f29e82] kernel.h: remove ancient __FUNCTION__ hack
>>> git bisect good 02f1f2170d2831b3233e91091c60a66622f29e82
>>> # bad: [796e1c55717e9a6ff5c81b12289ffa1ffd919b6f] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
>>> git bisect bad 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
>>> # good: [9682ec9692e5ac11c6caebd079324e727b19e7ce] Merge tag 'driver-core-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
>>> git bisect good 9682ec9692e5ac11c6caebd079324e727b19e7ce
>>> # good: [a9724125ad014decf008d782e60447c811391326] Merge tag 'tty-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
>>> git bisect good a9724125ad014decf008d782e60447c811391326
>>> # good: [f43dff0ee00a259f524ce17ba4f8030553c66590] Merge tag 'drm-amdkfd-next-fixes-2015-01-25' of git://people.freedesktop.org/~gabbayo/linux into drm-next
>>> git bisect good f43dff0ee00a259f524ce17ba4f8030553c66590
>>> # bad: [cffe1e89dc9bf541a39d9287ced7c5addff07084] drm: sti: HDMI add audio infoframe
>>> git bisect bad cffe1e89dc9bf541a39d9287ced7c5addff07084
>>> # good: [2f5b4ef15c60bc5292a3f006c018acb3da53737b] Merge tag 'drm/tegra/for-3.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
>>> git bisect good 2f5b4ef15c60bc5292a3f006c018acb3da53737b
>>> # bad: [865844448ce80ccd714793e9ba4140d7ae214229] drm/udl: optimize udl_compress_hline16 (v2)
>>> git bisect bad 865844448ce80ccd714793e9ba4140d7ae214229
>>> # bad: [d47df63393ed81977e0f6435988d9cbd70c867f7] drm/panel: simple: Add AVIC TM070DDH03 panel support
>>> git bisect bad d47df63393ed81977e0f6435988d9cbd70c867f7
>>> # bad: [9469244d869623e8b54d9f3d4d00737e377af273] drm/atomic: Fix potential use of state after free
>>> git bisect bad 9469244d869623e8b54d9f3d4d00737e377af273
>>> root@julian-VirtualBox:/usr/src/linux#
>>>
>>>
>>>
>>> On 02/24/2015, you wrote:
>>>
>>>> On Fri, 2015-02-20 at 15:25 -0400, Julian Margetson wrote:
>>>>> On 2/18/2015 11:25 PM, Julian Margetson wrote:
>>>>>   re PPC4XX PCI(E) MSI support.
>>>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html
>>>> Hmm, I think all those comments were addressed before it was merged.
>>>>
>>>> I tried to get a 4xx board going here last week, but it doesn't seem happy. I
>>>> can get a bit of uboot but then it hangs, might be overheating.
>>>>
>>>> cheers
>>>>
>>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>
>


--------------090807060807070200050402
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Verified that the problems with the <br>
      <pre class="western">radeon: ring 0 test failed error</pre>
      go back to at least  Kernel 3.0.1<br>
      <br>
      On 2/24/2015 4:26 PM, Julian Margetson wrote:<br>
    </div>
    <blockquote cite="mid:54ECDE7D.6070303@candw.ms" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <div class="moz-cite-prefix">Thanks<br>
        <br>
        after skipping several times :<br>
        <br>
        <meta http-equiv="content-type" content="text/html;
          charset=utf-8">
        <p style="margin-bottom: 0in; line-height: 100%">git bisect skip</p>
        <pre class="western">There are only 'skip'ped commits left to test.
The first bad commit could be any of:
b486e0e6d599b9ca8667fb9a7d49b7383ee963c7
eab3bbeffd152125ae0f90863b8e9bc8eef49423
960cd9d4fef6dd9e235c0e5c0d4ed027f8a48025
f02ad907cd9e7fe3a6405d2d005840912f1ed258
6a425c2a9b37ca3d2c37e3c1cdf973dba53eaa79
ee0a89cf3c2c550e6d877dda21dd2947afb90cb6
92890583627ee2a0518e55b063fcff86826fef96
95d6eb3b134e1826ed04cc92b224d93de13e281f
9469244d869623e8b54d9f3d4d00737e377af273
We cannot bisect more!</pre>
        <title></title>
        <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
        <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
        <br>
        <br>
        On 2/24/2015 3:14 PM, Gerhard Pircher wrote:<br>
      </div>
      <blockquote cite="mid:54ECCD8A.3060708@gmx.net" type="cite">
        <pre wrap="">Am 2015-02-24 um 12:08 schrieb Julian Margetson:
</pre>
        <blockquote type="cite">
          <pre wrap="">Problems with  the Gib bisect
Kernel wont compile after 10th bisect .
</pre>
        </blockquote>
        <pre wrap="">You can try "git bisect skip" to select another commit for testing.
Hopefully that one compiles fine then.

Gerhard

</pre>
        <blockquote type="cite">
          <pre wrap="">drivers/built-in.o: In function `drm_mode_atomic_ioctl':
(.text+0x865dc): undefined reference to `__get_user_bad'
make: *** [vmlinux] Error 1
root@julian-VirtualBox:/usr/src/linux# git bisect log
git bisect start
# bad: [c517d838eb7d07bbe9507871fab3931deccff539] Linux 4.0-rc1
git bisect bad c517d838eb7d07bbe9507871fab3931deccff539
# good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
git bisect good bfa76d49576599a4b9f9b7a71f23d73d6dcff735
# good: [02f1f2170d2831b3233e91091c60a66622f29e82] kernel.h: remove ancient __FUNCTION__ hack
git bisect good 02f1f2170d2831b3233e91091c60a66622f29e82
# bad: [796e1c55717e9a6ff5c81b12289ffa1ffd919b6f] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
git bisect bad 796e1c55717e9a6ff5c81b12289ffa1ffd919b6f
# good: [9682ec9692e5ac11c6caebd079324e727b19e7ce] Merge tag 'driver-core-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect good 9682ec9692e5ac11c6caebd079324e727b19e7ce
# good: [a9724125ad014decf008d782e60447c811391326] Merge tag 'tty-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good a9724125ad014decf008d782e60447c811391326
# good: [f43dff0ee00a259f524ce17ba4f8030553c66590] Merge tag 'drm-amdkfd-next-fixes-2015-01-25' of git://people.freedesktop.org/~gabbayo/linux into drm-next
git bisect good f43dff0ee00a259f524ce17ba4f8030553c66590
# bad: [cffe1e89dc9bf541a39d9287ced7c5addff07084] drm: sti: HDMI add audio infoframe
git bisect bad cffe1e89dc9bf541a39d9287ced7c5addff07084
# good: [2f5b4ef15c60bc5292a3f006c018acb3da53737b] Merge tag 'drm/tegra/for-3.20-rc1' of git://anongit.freedesktop.org/tegra/linux into drm-next
git bisect good 2f5b4ef15c60bc5292a3f006c018acb3da53737b
# bad: [865844448ce80ccd714793e9ba4140d7ae214229] drm/udl: optimize udl_compress_hline16 (v2)
git bisect bad 865844448ce80ccd714793e9ba4140d7ae214229
# bad: [d47df63393ed81977e0f6435988d9cbd70c867f7] drm/panel: simple: Add AVIC TM070DDH03 panel support
git bisect bad d47df63393ed81977e0f6435988d9cbd70c867f7
# bad: [9469244d869623e8b54d9f3d4d00737e377af273] drm/atomic: Fix potential use of state after free
git bisect bad 9469244d869623e8b54d9f3d4d00737e377af273
root@julian-VirtualBox:/usr/src/linux# 



On 02/24/2015, you wrote:

</pre>
          <blockquote type="cite">
            <pre wrap="">On Fri, 2015-02-20 at 15:25 -0400, Julian Margetson wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">On 2/18/2015 11:25 PM, Julian Margetson wrote:
</pre>
            </blockquote>
            <blockquote type="cite">
              <pre wrap=""> re PPC4XX PCI(E) MSI support.
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html">https://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087273.html</a>
</pre>
            </blockquote>
            <pre wrap="">Hmm, I think all those comments were addressed before it was merged.

I tried to get a 4xx board going here last week, but it doesn't seem happy. I
can get a bit of uboot but then it hangs, might be overheating.

cheers


</pre>
          </blockquote>
          <pre wrap="">
_______________________________________________
Linuxppc-dev mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a>

</pre>
        </blockquote>
        <pre wrap="">
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------090807060807070200050402--
