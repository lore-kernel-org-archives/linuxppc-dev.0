Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 5FC10B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 14:33:00 +1000 (EST)
Received: by yxm8 with SMTP id 8so918699yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 18 Jul 2010 21:32:58 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <8388D248-51F3-4F36-BBE0-CDE9E278E65E@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279496491.10390.1725.camel@pasglop>
	<8388D248-51F3-4F36-BBE0-CDE9E278E65E@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 18 Jul 2010 22:32:38 -0600
Message-ID: <AANLkTimJwnmf1YTPIy7OqdjseiUspzlxwRcjPMQ6Vv6j@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 18, 2010 at 10:28 PM, Matthew McClintock <msm@freescale.com> wr=
ote:
> On Jul 18, 2010, at 6:41 PM, Benjamin Herrenschmidt wrote:
>> On Thu, 2010-07-15 at 00:21 -0600, Grant Likely wrote:
>>> On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock <msm@freescale.com>=
 wrote:
>>>> To build a proper flat device tree for kexec we need to know which
>>>> memreserve region was used for the device tree for the currently
>>>> running kernel, so we can remove it and replace it with the new
>>>> memreserve for the kexec'ed kernel
>>>>
>>>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>>>
>>> Hi Matthew.
>>>
>>> I don't understand. =A0Why does userspace need to know about the old
>>> memreserve sections? =A0Doesn't kexec tear down all of the old
>>> allocations anyway? =A0How are they relevant for constructing the dtb
>>> for the kexec kernel? =A0I'll need a lot more details before I consider
>>> merging this.
>>>
>>> Also, please cc: me and Ben Herrenschmidt on powerpc related device
>>> tree changes.
>>
>> I admit to be the victim of a similar misunderstanding...
>>
>> Care to explain in more details ? (with examples)
>>
>
> Upon first examining the details of getting kexec working on our platform=
 I noticed our device tree passed from u-boot contained an additional memre=
serve section for the boot page. Subsequently, I've been trying to preserve=
 the ones passed in for the kexec'ed kernel thinking anyone could add anyth=
ing they wanted for their own particular needs and would quite possibly nee=
d those regions preserved across reboots.
>
> Recently, I've discovered the boot page address is given in the device tr=
ee as a property. So, for our platform (mpc85xx) in particular, I'm back to=
 not needing the read the old memreserve sections... I can completely recon=
struct the appropriate memreserve regions for kexec'ing from the informatio=
n passed in the device tree.
>
> That isn't to say there might not be more memreserve regions that are not=
 there for some valid reason. I'm not sure if we need to attempt to address=
 another scenario where there are other memreserve regions. So this would b=
e a good time to address this issue if anyone believes it is a worthwhile p=
ursuit to have a mechanism to have memreserve regions persistent across kex=
ec'ing - or any other reboot.

No, we haven't needed anything to date, so no sense trying to design a
solution for a theoretical need.  Leave it be for now.

g.
