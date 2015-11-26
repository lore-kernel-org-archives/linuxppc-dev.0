Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 996AE1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 20:26:41 +1100 (AEDT)
Message-ID: <1448530000.22295.4.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: tracing: don't trace hcalls on offline CPUs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 26 Nov 2015 20:26:40 +1100
In-Reply-To: <CAOJe8K0ggTkoBX8=N6qo=Ftnjm5V3z50QL+R1jPnawfrC2fJ5g@mail.gmail.com>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <1448389419-5296-2-git-send-email-kda@linux-powerpc.org>
 <1448519967.9839.13.camel@ellerman.id.au>
 <CAOJe8K0ggTkoBX8=N6qo=Ftnjm5V3z50QL+R1jPnawfrC2fJ5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-26 at 11:15 +0300, Denis Kirjanov wrote:
> On 11/26/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Tue, 2015-11-24 at 21:23 +0300, Denis Kirjanov wrote:
> > I can't get this to hit.
> > 
> > I've got LOCKDEP=y, I've enabled the hcall tracepoints, and then I offline
> > a cpu via sysfs.

> I haven't tried it via sysfs. Could you share the command
> so I give a try to reproduce.

Either manually:

$ echo 0 > /sys/devices/system/cpuN/online

Or using:

$ ppc64_cpu --cores-on=1
and/or
$ ppc64_cpu --smt=1

Which uses sysfs.

cheers
