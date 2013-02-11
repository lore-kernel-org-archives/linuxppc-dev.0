Return-Path: <michael@ellerman.id.au>
Date: Mon, 11 Feb 2013 14:39:08 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Phileas Fogg <phileas-fogg@mail.ru>
Subject: Re: PS3 platform is broken on Linux 3.7.0
Message-ID: <20130211033908.GA21369@concordia>
References: <1355488506.55692113@f147.mail.ru>
 <1360498641.346858866@f116.mail.ru>
 <87mwvc41fc.fsf@linux.vnet.ibm.com>
 <1360518697.255951128@f337.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1360518697.255951128@f337.mail.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 10, 2013 at 09:51:37PM +0400, Phileas Fogg wrote:
> 
> >Phileas Fogg < phileas-fogg@mail.ru > writes:
> >
> 
> Patch:
> 
> --- arch/powerpc/kernel/setup_64.c.old    2013-02-10 19:34:53.787366191 +0100
> +++ arch/powerpc/kernel/setup_64.c    2013-02-10 19:35:38.834035478 +0100
> @@ -186,6 +186,9 @@
>      initialise_paca(&boot_paca, 0);
>      setup_paca(&boot_paca);
>  
> +    /* Allow percpu accesses to "work" until we setup percpu data */
> +    boot_paca.data_offset = 0;
> +

This is correct.

>      /* Initialize lockdep early or else spinlocks will blow */
>      lockdep_init();
>  
> @@ -208,8 +211,6 @@
>  
>      /* Fix up paca fields required for the boot cpu */
>      get_paca()->cpu_start = 1;
> -    /* Allow percpu accesses to "work" until we setup percpu data */
> -    get_paca()->data_offset = 0;

But this is not.

As you said, they are different pacas, so we need to make sure both
boot_paca, and "the paca of the boot cpu" are initialised with
data_offset = 0.

I'll send a patch to sort it.

cheers
