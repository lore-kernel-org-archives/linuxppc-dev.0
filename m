Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81EF61A09AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 02:04:37 +1100 (AEDT)
Message-ID: <54F87096.2070709@Freescale.com>
Date: Thu, 5 Mar 2015 09:04:54 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Jamal Hadi Salim <jhs@mojatatu.com>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
References: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
 <54F84CF1.80702@mojatatu.com> <54F85ECB.3070200@Freescale.com>
 <54F869CE.1080701@mojatatu.com>
In-Reply-To: <54F869CE.1080701@mojatatu.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Jamal,


On 03/05/2015 08:35 AM, Jamal Hadi Salim wrote:
> Hi Emil,
> 
> On 03/05/15 08:48, Emil Medve wrote:
> 
>> The intent is to upstream the entire suite of the DPAA drivers. All the
>> drivers are still WIP, but B/QMan have been already presented to the
>> upstream community and this is the first attempt to publish (some low
>> level code of) the FMan driver. As we go through our internal checklist
>> and in the same time address community feedback we'll soon get the
>> drivers to be acceptable for the upstream trees
>>
>> The first version of the actual Ethernet driver will follow imminently
>>
>> SDK enablement is a side-effect
> 
> Meaning? Let me ask the question differently:
> Do i need your sdk to use the features exposed

No. All the kernel drivers/code we want to upstream is meant to stand on
its own and be used the "normal" Linux/Unix way

> or can i use something
> like tc to set up the deficit rr or wred or the exposed classifiers
> and associated actions?

The SDK doesn't currently support the enablement of any HW QoS features
via standard Linux user-space tools. The SDK contains some FSL tools for
that. As a time moving target we intend to support lots of the DPAA
features via standard kernel/user-space means: ethtool, iptables,
iproute2, etc.

> Would your sdk (via user space direct programming) benefit because you
> have pushed these pieces into the kernel?

Not specifically because of the kernel drivers. In support for the
user-space DPAA the kernel will have some UIO/VFIO drivers to allow the
user-space to "mmap" these devices (portals, ports, MAC(s), etc.). The
intent is to use the same driver sources for the kernel- and user-space
drivers

>>> How are you planning to
>>> add support for your classifiers, queue schedulers etc?
>>
>> Yes
> 
> Yes as in these will be available via linux kernel or via your sdk?

As in these will be available via familiar kernel-/user-space tools

>>> Is that a patch
>>> on top of this or it is something that sits on user space?
>>
>> Both. Full DPAA/Ethernet enablement will be present in the kernel. We
>> also have support for user-space based approach. I'm unsure where/when
>> we might publish that. Of course the SDK is always a place you can turn
>> to for all the code we have (in whatever state it might be)
> 
> the sdk is open source?

I'm uncertain about *all* the licenses included, but you can look into
it and download the SDK via git.freescale.com and/or
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=SDKLINUX


Cheers,
