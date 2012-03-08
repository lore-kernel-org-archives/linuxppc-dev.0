Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FC5FB6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 05:43:24 +1100 (EST)
Message-ID: <4F58FDC4.2080909@freescale.com>
Date: Thu, 8 Mar 2012 12:43:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH] PPC: Don't sync timebase when inside VM
References: <1330697553-27156-1-git-send-email-agraf@suse.de>
 <20120302162058.GA24552@schlenkerla.am.freescale.net>
 <9A229F04-DFC9-485D-AB06-B1A4F0AEB348@suse.de>
 <4F5100A0.8040802@freescale.com>
 <CAEsOVNczPUdfUK6oZ7WOTGUQbA135HgrntwvnydbYd-Eo4joLg@mail.gmail.com>
 <4F58F85F.8090604@freescale.com>
 <CAEsOVNcqSBh0hmgUQcJJjD28JbreBqYygHF7Q6Y8uaFzdj2PYw@mail.gmail.com>
In-Reply-To: <CAEsOVNcqSBh0hmgUQcJJjD28JbreBqYygHF7Q6Y8uaFzdj2PYw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 kvm list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2012 12:24 PM, McClintock Matthew-B29882 wrote:
> On Thu, Mar 8, 2012 at 12:20 PM, Scott Wood <scottwood@freescale.com> wrote:
>> On 03/08/2012 11:31 AM, McClintock Matthew-B29882 wrote:
>>> On Fri, Mar 2, 2012 at 11:17 AM, Scott Wood <scottwood@freescale.com> wrote:
>>>> On 03/02/2012 10:30 AM, Alexander Graf wrote:
>>>>>
>>>>> On 02.03.2012, at 17:20, Scott Wood wrote:
>>>>>> Again, for 85xx we should *never* sync the timebase in the kernel,
>>>>>> hypervisor or no.
>>>>>
>>>>> The code says "if the kexec config option is enabled, do the sync". I'm fairly sure it's there for a reason.
>>>>
>>>> Sigh.  I forgot about that.  It's because instead of doing kexec the
>>>> simple way, we actually physically reset the core.  We really shouldn't
>>>> do that.  And we *really* shouldn't do it just because CONFIG_KEXEC is
>>>> defined, regardless of whether we're actually booting from kexec.
>>>
>>> How would one rocver a core that's off in the weeds?
>>
>> System reset?
> 
> kdump restarts a kernel using a reserved memory region to inspect the
> memory of the crashed kernel. Wouldn't system reset cause issues here?

Oh, kdump.

Maybe in that case, go ahead and reset the other cores (or halt them via
some other means), but don't do anything with them.  Just boot a single
core in the dump kernel, do the dumping, then reset the system?

Or if you must sync the timebase in Linux, do it the way U-Boot does
(and skip it if you don't have access to the relevant CCSR bits).

Are I/O devices a problem with kdump and not resetting the system,
especially on some of our chips where certain I/O devices are difficult
to reset?

-Scott
