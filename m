Return-Path: <halesh.sadashiv@ap.sony.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 5CBC6DE4C5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 01:16:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Regarding select() on PPC
Date: Mon, 22 Sep 2008 20:45:52 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56E0DA@insardxms01.ap.sony.com>
From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



The issue is found only in PPC32.

Please let me if the patch is applicable.

+++ arch/powerpc/kernel/syscalls.c      2008-09-22 20:47:23.885126056
+0530
@@ -211,6 +211,9 @@
 int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set
__user *exp, struct timeval __user *tvp)
 {
+   if ( n < 0 )
+       return -EINVAL;
+
    if ( (unsigned long)n >=3D 4096 )
    {
        unsigned long __user *buffer =3D (unsigned long __user *)n;

Thanks,
Halesh


>-----Original Message-----
>From: Josh Boyer [mailto:jwboyer@gmail.com]
>Sent: Friday, September 19, 2008 7:49 PM
>To: Sadashiiv, Halesh
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Regarding select() on PPC
>
>On Fri, Sep 19, 2008 at 07:00:07PM +0530, Sadashiiv, Halesh wrote:
>>>For negetive value of n (first argument to select) select fails with
>>EINVAL
>>>error,
>>>
>>>But for the same when I tested for PowerPC it was giving EFAULT,
>>>Its on 2.6.16 kernel.
>
>2.6.16 is really old.  I tested your testcase on a 2.6.25 based kernel
on
>a ppc64 machine and it seemed to work fine.
>
>josh



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
