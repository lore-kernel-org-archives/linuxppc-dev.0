Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh3Nb1NXYzF134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 13:33:02 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id t4so7719364plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 18:33:02 -0800 (PST)
Date: Wed, 14 Feb 2018 13:32:39 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "open list:LINUX
 FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
Message-ID: <20180214133239.498a1e73@balbir.ozlabs.ibm.com>
In-Reply-To: <20180212232551.GA5199@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
 <CAKTCnzmtDNJHThzuZa1+ydrriQG-dVovHA7uLSVvfLFG2MaidQ@mail.gmail.com>
 <20180212232551.GA5199@roeck-us.net>
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

On Mon, 12 Feb 2018 15:25:51 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Feb 13, 2018 at 10:01:57AM +1100, Balbir Singh wrote:
> > On Tue, Feb 13, 2018 at 9:34 AM, Guenter Roeck <linux@roeck-us.net> wrote:  
> > > If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
> > >
> > > arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> > > arch/powerpc/platforms/powernv/smp.c:236:4: error:
> > >         implicit declaration of function 'crash_ipi_callback'
> > >
> > > Add dummy function calls, similar to kdump_in_progress(), to solve the
> > > problem.
> > >
> > > Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---  
> > 
> > Thanks for working on this.
> > 
> > You've added two functions, I understand the crash_send_ipi() bits
> > that I broke. Looks like crash_ipi_callback broken without KEXEC_CORE?
> >   
> 
> If I recall correctly, 4145f358644b introduced the call to crash_ipi_callback().
> After I declared the dummy function for that, I got an error about the missing
> crash_send_ipi(). I didn't spend more time on it but just added another dummy
> function. It may well be that another problem was introduced in the same time
> frame. On the other side, maybe I got it all wrong, and my patch is not worth
> the computer it was written on.
> 

The patches worked for me with CONFIG_KEXEC=n and CONFIG_KEXEC_CORE=n

Tested-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
