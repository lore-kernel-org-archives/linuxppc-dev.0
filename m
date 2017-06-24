Return-Path: <larry.finger@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ww2PM3DdCzDr1L
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 03:29:27 +1000 (AEST)
Received: by mail-ot0-x243.google.com with SMTP id p48so7848062otc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 10:29:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Regression in kernel 4.12-rc1 for Powerpc 32 - bisected to commit
 3448890c32c3
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linuxppc-dev@lists.ozlabs.org
References: <69187aa4-611f-b08a-8d14-b8fa47b4c464@lwfinger.net>
 <1588557c-2706-0c0e-3387-4ae65d0b5790@lwfinger.net>
 <20170621212257.GN10672@ZenIV.linux.org.uk>
 <5f4b9fa4-262a-31b1-32ba-a2f6e789b3d6@lwfinger.net>
 <20170621213415.GO10672@ZenIV.linux.org.uk>
 <655d304e-e455-6e0c-56e1-f127653ea13c@lwfinger.net>
 <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
Date: Sat, 24 Jun 2017 12:29:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170623202943.GS10672@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2017 03:29 PM, Al Viro wrote:
> On Fri, Jun 23, 2017 at 01:49:16PM -0500, Larry Finger wrote:
> 
>>> BTW, could you try to check what happens if you kill the
>>> 	if (__builtin_constant_p(n) && (n <= 8))
>>> bits in raw_copy_{to,from}_user()?  The usefulness of those (in __copy_from_user()
>>> originally) had always been dubious and the things are simpler without them.
>>> If _that_ turns out to cure breakage, I would be very surprised, though.
>>>
>> Sorry I was gone so long. Installing jessie on this box resulted in a crash
>> on boot. Lubuntu 14.04 yielded a desktop with a functioning cursor, but
>> nothing else. Finally, Ubuntu 12.04 resulted in a working system. I hate
>> Unity, but I guess I'm stuck for now.
> 
> Ho-hum...  Jessie is 3.16, so whatever is crashing there, it's something
> different...  Ubuntu 12.04 is what, 3.2?
> 
>> I know how easy it is to screw up a long bisection by booting the wrong
>> kernel. To help that problem and to work around the yaconf/yboot nonsense on
>> the MAC, my /etc/yaconf has always had generic kernel stanzas with only
>> default, old, and original kernels mentioned. From there I use a local
>> script to finish a kernel installation by moving the default links to the
>> old ones and creating the new default links pointing to the current kernel.
>> With those long-tested scripts, I'm sure that I am booting the one I want.
>>
>> With the new installation, kernel 4.12-rc6 failed, as did 3448890c with the
>> backported 46f401c4 added.
>>
>> Replacing "if (__builtin_constant_p(n) && (n <= 8))" with "if (0)" had no effect.
> 
> OK, that simplifies things a bit.  Just to make sure we are on the same page:
> 
> * f2ed8bebee69 + cherry-pick of 46f401c4 boots (Ubuntu 12.04 userland)
> * 3448890c32c3 + cherry-pick of 46f401c4 fails (Ubuntu 12.04 userland), ditto
>    with removal of constant-size bits in raw_copy_..._user().  Failure appears
>    to be on udev getting EFAULT on some syscalls.
> * straight Ubuntu 12.04 works
> * jessie crashes on boot.

I made a break through. If I turn off inline copy to/from users for 32-bit ppc 
with the following patch, then the system boots:

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 5c0d8a8cdae5..1e6a8723f497 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -267,12 +267,7 @@ do { 
        \
  extern unsigned long __copy_tofrom_user(void __user *to,
                 const void __user *from, unsigned long size);

-#ifndef __powerpc64__
-
-#define INLINE_COPY_FROM_USER
-#define INLINE_COPY_TO_USE
-
-#else /* __powerpc64__ */
+#ifdef __powerpc64__

  static inline unsigned long
  raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)

It seems whatever problem I am seeing is in the inline version of 
_copy_to_user() and _copy_from_user() on the 32-bit ppc. The only other 
difference between the two versions is the placement of the __user macro, which 
looks to be wrong in the non-inlined version of _copy_to_user() in 
lib/usercopy.c, but that is the one that works.

To me, this looks like a compiler error. On the PowerBook, 'gcc --version' 
reports "gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3".

I will prepare a proper patch that I will send to you privately. If you agree 
with it, it can be send through normal channels in time for the release of 4.12.

Larry
