Return-Path: <B29882@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D02FCB703D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 05:44:46 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
Date: Tue, 20 Dec 2011 18:44:37 +0000
Message-ID: <CAEsOVNdAhx+X3GFFtNO4XYC96OUyQF7uBePxGEE7RJ=BkTOAGA@mail.gmail.com>
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
 <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
 <1324006543.4875.1.camel@pasglop> <4EEBB84C.2050001@freescale.com>
In-Reply-To: <4EEBB84C.2050001@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 16, 2011 at 3:29 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 12/15/2011 09:35 PM, Benjamin Herrenschmidt wrote:
>> On Fri, 2011-12-16 at 03:29 +0000, McClintock Matthew-B29882 wrote:
>>> On Thu, Dec 15, 2011 at 9:12 PM, Benjamin Herrenschmidt
>>> <benh@kernel.crashing.org> wrote:
>>>> On Mon, 2011-11-28 at 22:24 -0600, Matthew McClintock wrote:
>>>>> boot_cpuid and init_thread_info.cpu are redundant, just use the
>>>>> var that stays around longer and add a define to make boot_cpuid
>>>>> point at the correct value
>>>>>
>>>>> boot_cpudid_phys is not needed and can completly go away from the
>>>>> SMP case, we leave it there for the non-SMP case since the paca
>>>>> struct is not around to store this info
>>>>>
>>>>> This patch also has the effect of having the logical cpu number
>>>>> of the boot cpu be updated correctly independently of the ordering
>>>>> of the cpu nodes in the device tree.
>
> Where does the ordering matter currently?

The kernel won't boot if the order of the cpu nodes in the device tree
does not match the reg property. This can be fixed by using
init_thread_info.cpu instead of a separate variable - which seems to
be correct since we don't actually need a separate boot_cpuid variable
at all for powerpc. The correct initialization occurs in this scenario
in early_init_dt_scan_cpus(). (boot_cpuid maps to init_thread_info.cpu
via a define and could be just renamed everywhere in arch/powerpc/ )

>>>> So what about head_fsl_booke.S comparing boot_cpuid to -1 ? That seems
>>>> to be broken now in at least 2 ways, boot_cpuid doesn't exist anymore
>>>> and you don't initialize it to -1 either...
>>>
>>> This is 4/5 which is also waiting for your review.
>>>
>>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-October/093474.html
>>
>> Ah missed that. This is FSL specific, I'd need Kumar and/or Scott's ack
>> for that one.
>
> It would be nice if we could eliminate all usage of the boot cpu dtb
> field -- it's easy to forget to set it, especially if you're not making
> an AMP config. =A0The default -1 means this patch would break booting wit=
h
> such a tree.

I can add a check here to see if the boot cpu in the device tree is -1
to assume this is the boot cpu in addition to the boot cpu matching
the PIR. This seems like the best approach to me, keep what I have in
these two patches and add this additional check to keep all device
tree's working properly.

> If we don't want to record the PIR of the first CPU to enter as the boot
> CPU (is the concern implementations where the CPU node's reg is not the
> same as what's in PIR?),

This is something that has been fixed by using init_thread_info.cpu
above, we don't need to change the current method of booting we are
doing. I was just making some additional fixes Ben requested while I
was looking at the same code fix some kexec issues with device tree
ordering.

Basically (I think) all we need to fix the device tree order is the followi=
ng:

-extern int boot_cpuid;
+#define boot_cpuid     (init_thread_info.cpu)

And all the other stuff could remain the same. That is we check some
variable and see if it's -1, if it is we are the boot cpu and we
change that variable to something else and the other cpus that boot
will know they are secondary cpus.

> how about just having a variable that gets set
> before releasing secondaries? =A0If you're in the boot entry code and tha=
t
> variable is set, you're a secondary. =A0Or, use a distinct release addres=
s
> for secondaries rather than __early_start.

The former method is the way things are working now, and the latter is
another possible solution which would require some more though/work
for me than the current changes.

-M=
