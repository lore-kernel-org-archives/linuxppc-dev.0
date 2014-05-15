Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 30705140087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 20:46:52 +1000 (EST)
Message-ID: <53749B0E.4050900@roeck-us.net>
Date: Thu, 15 May 2014 03:46:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alan Modra <amodra@gmail.com>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net> <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au> <5372FC43.6010707@roeck-us.net>
 <20140514055219.GL5162@bubble.grove.modra.org>
 <20140514153430.GA28553@roeck-us.net>
 <20140515094716.GQ5162@bubble.grove.modra.org>
In-Reply-To: <20140515094716.GQ5162@bubble.grove.modra.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/15/2014 02:47 AM, Alan Modra wrote:
> On Wed, May 14, 2014 at 08:34:30AM -0700, Guenter Roeck wrote:
>> Bummer. Confirmed, if I replace "@h" with "@high" in just one place,
>> the builds pass with binutils 2.24. Unfortunately the same builds then
>> fails with binutils 2.23.
>>
>> Any idea how to get it to compile with both old and new versions ?
>
> The standard way with GNU software would be to write a configure test,
> that checks for @high support in the assembler, and defines a macro
> if the assembler passes the check.  I'm not that familiar with the
> linux kernel these days, but a little grepping around says that
> something like
>
> ashigh := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
> KBUILD_AFLAGS += $(ashigh)
>
> might work.
>

Yes, it does.

Thanks!

Guenter
