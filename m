Return-Path: <fweisbec@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTLCM26d6zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:01:51 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id m70so491367wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 20:01:51 -0800 (PST)
Date: Thu, 23 Feb 2017 05:01:43 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove leftover cputime_to_nsecs call causing
 build error
Message-ID: <20170223040142.GA5323@lerouge>
References: <1487690321-21553-1-git-send-email-fweisbec@gmail.com>
 <87fuj5zz8o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fuj5zz8o.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2017 at 08:34:15AM +1100, Michael Ellerman wrote:
> Frederic Weisbecker <fweisbec@gmail.com> writes:
> 
> > This type conversion is a leftover that got ignored during the kcpustat
> > conversion to nanosecs, resulting in build breakage with config having
> > CONFIG_NO_HZ_FULL=y.
> >
> > 	arch/powerpc/kernel/time.c: In function 'running_clock':
> > 	arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function 'cputime_to_nsecs' [-Werror=implicit-function-declaration]
> > 	  return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> >
> > All we need is to remove it.
> >
> > Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Oliver O'Halloran <oohall@gmail.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> 
> LGTM.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> Are you going to send this to Linus, or should I?

I would prefer you send it to Linus if you don't mind.

The fate of a powerpc patch sent by me directly to Linus is
anything but predictable :o)

Thanks.
