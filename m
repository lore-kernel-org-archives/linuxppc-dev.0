Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x22a.google.com (mail-lb0-x22a.google.com
 [IPv6:2a00:1450:4010:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3ADD52C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 02:03:45 +1000 (EST)
Received: by mail-lb0-f170.google.com with SMTP id w7so7852574lbi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 09:03:39 -0700 (PDT)
Date: Wed, 11 Sep 2013 18:03:02 +0200
From: Vladimir Murzin <murzin.v@gmail.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: export cpu_to_chip_id
Message-ID: <20130911160255.GA1967@hp530>
References: <1378831135-2179-1-git-send-email-murzin.v@gmail.com>
 <52300FB9.5020104@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <52300FB9.5020104@linux.vnet.ibm.com>
Cc: paulus@samba.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 chenhui.zhao@freescale.com, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 11, 2013 at 12:07:45PM +0530, Vasant Hegde wrote:
> On 09/10/2013 10:08 PM, Vladimir Murzin wrote:
> > While cross-building for PPC64 I've got
> >
> Vladimir,
> 
> Below commit ID fixes this issue.

Great! For whatever reason I thought _GPL is default policy for exported
symbols... but, never mind ;)

Sorry for the noise
Vladimir

> 
> commit 256588fda10f2a712631f8a4e72641a66adebdb8
> Author: Guenter Roeck <linux@roeck-us.net>
> Date:   Mon Sep 9 18:37:56 2013 -0700
> 
>      powerpc: Export cpu_to_chip_id() to fix build error
> 
> -Vasant
> 
> > ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
> >
> > mtip32xx refer to topology_physical_package_id, which stands for
> > cpu_to_chip-id.
> >
> > Make cpu_to_chip-id (and topology_physical_package_id) available for
> > external users.
> >
> > Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> > ---
> >   arch/powerpc/kernel/smp.c |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 442d8e2..1d9c1c2 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
> >   	of_node_put(np);
> >   	return of_get_ibm_chip_id(np);
> >   }
> > +EXPORT_SYMBOL_GPL(cpu_to_chip_id);
> >
> >   /* Helper routines for cpu to core mapping */
> >   int cpu_core_index_of_thread(int cpu)
> >
> 
