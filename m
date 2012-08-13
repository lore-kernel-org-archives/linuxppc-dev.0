Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 816032C008B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 03:29:23 +1000 (EST)
Message-ID: <50293961.9070409@freescale.com>
Date: Mon, 13 Aug 2012 12:29:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/epapr: export epapr_hypercall_start
References: <20120810222121.GA9408@tyr.buserror.net>
 <CAMuHMdUZmT3g1+6yBPK3LAjTO-orE3Fh7QUP7AB5Kj8o4M4_1g@mail.gmail.com>
 <CAOZdJXW+Br2LCxCuMruHJtODqu+8xcdgWrcLPWE2aJ2U23RU3g@mail.gmail.com>
In-Reply-To: <CAOZdJXW+Br2LCxCuMruHJtODqu+8xcdgWrcLPWE2aJ2U23RU3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2012 08:07 AM, Tabi Timur-B04825 wrote:
> On Sat, Aug 11, 2012 at 2:01 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Sat, Aug 11, 2012 at 12:21 AM, Scott Wood <scottwood@freescale.com> wrote:
>>> +EXPORT_SYMBOL(epapr_hypercall_start);
>>
>> EXPORT_SYMBOL_GPL?
> 
> We prefer EXPORT_SYMBOL.  We don't want to restrict our customers from
> having to use GPL code.
> 

More specifically in this case, I don't see how use of this symbol in
any way suggests that the code would be GPL-derivative.  The API is
documented in the ePAPR standard or other external sources -- not a
kernel internal implementation issue.  The contents of
epapr_hypercall_start itself are not copyrightable (by default it's
basically "return -1", and is patched at runtime with a few instructions
provided by the hypervisor).  The header file with the inline accessors
is dual licensed (and also unlikely to be copyrightable, in terms of
what actually makes it into the output binary).

-Scott
