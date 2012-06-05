Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7815AB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 02:16:10 +1000 (EST)
Message-ID: <4FCE30B8.2070902@freescale.com>
Date: Tue, 5 Jun 2012 11:15:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
 <4FC933BF.1020901@freescale.com>
 <20120604110444.GA20676@localhost.localdomain>
 <4FCCE32F.1060301@freescale.com>
 <20120605111823.GB22427@localhost.localdomain>
In-Reply-To: <20120605111823.GB22427@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2012 06:18 AM, Zhao Chenhui wrote:
> On Mon, Jun 04, 2012 at 11:32:47AM -0500, Scott Wood wrote:
>> On 06/04/2012 06:04 AM, Zhao Chenhui wrote:
>>> On Fri, Jun 01, 2012 at 04:27:27PM -0500, Scott Wood wrote:
>>>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
>>>>> -#ifdef CONFIG_KEXEC
>>>>> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
>>>>
>>>> Let's not grow lists like this.  Is there any harm in building it
>>>> unconditionally?
>>>>
>>>> -Scott
>>>
>>> We need this ifdef. We only set give_timebase/take_timebase
>>> when CONFIG_KEXEC or CONFIG_HOTPLUG_CPU is defined.
>>
>> If we really need this to be a compile-time decision, make a new symbol
>> for it, but I really think this should be decided at runtime.  Just
>> because we have kexec or hotplug support enabled doesn't mean that's
>> actually what we're doing at the moment.
>>
>> -Scott
> 
> If user does not enable kexec or hotplug, these codes are redundant.
> So use CONFIG_KEXEC and CONFIG_HOTPLUG_CPU to gard them.

My point is that these lists tend to grow and be a maintenance pain.
For small things it's often better to not worry about saving a few
bytes.  For larger things that need to be conditional, define a new
symbol rather than growing ORed lists like this.

-Scott
