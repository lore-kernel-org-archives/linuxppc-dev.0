Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8CMr5yqGzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:54:16 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so1796624pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 17:54:16 -0700 (PDT)
Date: Wed, 10 Aug 2016 10:54:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Scott Wood
 <oss@buserror.net>, Alessio Igor Bogani <alessio.bogani@elettra.eu>, Paul
 Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 1/3] powerpc: Factor out common code in setup-common.c
Message-ID: <20160810105407.47cf4148@roar.ozlabs.ibm.com>
In-Reply-To: <CAHQ1cqH650Ef9mdoKiWvy4ubz=sx32bDjgQ9sYQRRve+q8rKMQ@mail.gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
 <20160801134031.7dcb7c82@roar.ozlabs.ibm.com>
 <CAHQ1cqH650Ef9mdoKiWvy4ubz=sx32bDjgQ9sYQRRve+q8rKMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2016 09:30:54 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> On Sun, Jul 31, 2016 at 8:40 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Thu, 28 Jul 2016 16:07:16 -0700
> > Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >  
> >> Factor out a small bit of common code in machine_restart(),
> >> machine_power_off() and machine_halt().
> >>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> ---
> >>
> >> No changes compared to v1.
> >>
> >>  arch/powerpc/kernel/setup-common.c | 23 ++++++++++++++---------
> >>  1 file changed, 14 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kernel/setup-common.c
> >> b/arch/powerpc/kernel/setup-common.c index 714b4ba..5cd3283 100644
> >> --- a/arch/powerpc/kernel/setup-common.c
> >> +++ b/arch/powerpc/kernel/setup-common.c
> >> @@ -130,15 +130,22 @@ void machine_shutdown(void)
> >>               ppc_md.machine_shutdown();
> >>  }
> >>
> >> +static void machine_hang(void)
> >> +{
> >> +     pr_emerg("System Halted, OK to turn off power\n");
> >> +     local_irq_disable();
> >> +     while (1)
> >> +             ;
> >> +}  
> >
> > What's the intended semantics of this function? A default power
> > off handler when the platform supplies none?  
> 
> I was mostly trying to avoid code duplication in
> machine_halt/machine_restart/machine_power_off and didn't intend that
> function to be used outside. The semantics is just - to hang the CPU
> when things didn't go as expected and code that was supposed to
> restart/halt/power off the machine failed.
> 
> > Would ppc_power_off()
> > be a good name?  
> 
> Calling it "power_off" seems a bit misleading, the function doesn't
> really try to do anything related to powering off, really.

Okay I don't feel too strongly against it.

Thanks,
Nick
