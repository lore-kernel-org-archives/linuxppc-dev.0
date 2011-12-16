Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B17E61007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2011 08:29:59 +1100 (EST)
Message-ID: <4EEBB84C.2050001@freescale.com>
Date: Fri, 16 Dec 2011 15:29:48 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded boot_cpuid{,
 _phys}
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
 <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
 <1324006543.4875.1.camel@pasglop>
In-Reply-To: <1324006543.4875.1.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/15/2011 09:35 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-12-16 at 03:29 +0000, McClintock Matthew-B29882 wrote:
>> On Thu, Dec 15, 2011 at 9:12 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>>> On Mon, 2011-11-28 at 22:24 -0600, Matthew McClintock wrote:
>>>> boot_cpuid and init_thread_info.cpu are redundant, just use the
>>>> var that stays around longer and add a define to make boot_cpuid
>>>> point at the correct value
>>>>
>>>> boot_cpudid_phys is not needed and can completly go away from the
>>>> SMP case, we leave it there for the non-SMP case since the paca
>>>> struct is not around to store this info
>>>>
>>>> This patch also has the effect of having the logical cpu number
>>>> of the boot cpu be updated correctly independently of the ordering
>>>> of the cpu nodes in the device tree.

Where does the ordering matter currently?

>>> So what about head_fsl_booke.S comparing boot_cpuid to -1 ? That seems
>>> to be broken now in at least 2 ways, boot_cpuid doesn't exist anymore
>>> and you don't initialize it to -1 either...
>>
>> This is 4/5 which is also waiting for your review.
>>
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-October/093474.html
> 
> Ah missed that. This is FSL specific, I'd need Kumar and/or Scott's ack
> for that one.

It would be nice if we could eliminate all usage of the boot cpu dtb
field -- it's easy to forget to set it, especially if you're not making
an AMP config.  The default -1 means this patch would break booting with
such a tree.

If we don't want to record the PIR of the first CPU to enter as the boot
CPU (is the concern implementations where the CPU node's reg is not the
same as what's in PIR?), how about just having a variable that gets set
before releasing secondaries?  If you're in the boot entry code and that
variable is set, you're a secondary.  Or, use a distinct release address
for secondaries rather than __early_start.

-Scott
