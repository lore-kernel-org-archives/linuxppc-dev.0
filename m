Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C1341007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 06:40:37 +1100 (EST)
Message-ID: <4F3C0A2B.9000105@freescale.com>
Date: Wed, 15 Feb 2012 13:40:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
 <ADC42EDC-6F11-419E-9F31-B9E23D80FFE1@suse.de>
In-Reply-To: <ADC42EDC-6F11-419E-9F31-B9E23D80FFE1@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2012 01:36 PM, Alexander Graf wrote:
> 
> On 10.01.2012, at 01:51, Scott Wood wrote:
>> I was thinking we'd check ESR[EPID] or SRR1[IS] as appropriate, and
>> treat it as a kernel fault (search exception table) -- but this works
>> too and is a bit cleaner (could be other uses of external pid), at the
>> expense of a couple extra instructions in the emulation path (but
>> probably a slightly faster host TLB handler).
>>
>> The check wouldn't go in DO_KVM, though, since on bookehv that only
>> deals with diverting flow when xSRR1[GS] is set, which wouldn't be the
>> case here.
> 
> Thinking about it a bit more, how is this different from a failed get_user()? We can just use the same fixup mechanism as there, right?

The fixup mechanism can be the same (we'd like to know whether it failed
due to TLB miss or DSI, so we know which to reflect -- but if necessary
I think we can figure that out with a tlbsx).  What's different is that
the page fault handler needs to know that any external pid (or AS1)
fault is bad, same as if the address were in the kernel area, and it
should go directly to searching the exception tables instead of trying
to page something in.

-Scott
