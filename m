Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54D101A0CE9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 15:55:40 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 0/4] powerpc: trivial unused functions cleanup
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
 <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
 <1426825436.2581.1.camel@ellerman.id.au>
Date: Fri, 20 Mar 2015 11:55:32 +0700
In-Reply-To: <1426825436.2581.1.camel@ellerman.id.au> (Michael Ellerman's
 message of "Fri, 20 Mar 2015 15:23:56 +1100")
Message-ID: <87pp84w9mj.fsf@KB00016249.iskra.kb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Fri, 2015-03-20 at 10:56 +0700, Arseny Solokha wrote:
>> This series removes unused functions from powerpc tree that I've been ab=
le
>> to discover.
>>=20
>> Two machines at hands, e300 and e500 based, boot and run without regress=
ions
>> on my workload with this series applied. The removed code seems also been
>> rarely touched, so it seems the series is safe at least in general. But I
>> can't obviously express any strong point in support of the series, so it=
's
>> completely OK to leave things as is.
>>=20
>> v3: In patch 4/4, do not remove fsl_mpic_primary_get_version() from
>>     arch/powerpc/sysdev/mpic.c because the patch by Jia Hongtao
>>     ("powerpc/85xx: workaround for chips with MSI hardware errata") makes
>>     use of it.
>
> Sorry, too late.
>
> https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/commit/?h=3Dne=
xt&id=3D5e86bfde9cd93f272844c3ff6ac5f93d3666b3e7
>
>
> The patch that needs it can just add it back.

I failed to notice that the series has been finally committed, so resent it=
. Of
course Hongtao can add the removed function back if he needs to.

And by the way, while revisiting the series I've noticed that though the pa=
tch
4/4 basically reverts [1], it leaves

  #define MPIC_GREG_GLOBAL_CONF_1		0x00030

in arch/powerpc/include/asm/mpic.h untouched. That define also loses its us=
es
after applying the patch. Compare the following hunk in today's patch w/ th=
e one
you committed:

  @@ -33,11 +33,6 @@
   #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
   #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
   #define		MPIC_GREG_GCONF_MCK			0x08000000
  -#define MPIC_GREG_GLOBAL_CONF_1		0x00030
  -#define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
  -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
  -#define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO(r)	\
  -			(((r) << 28) & MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK)
   #define MPIC_GREG_VENDOR_0		0x00040
   #define MPIC_GREG_VENDOR_1		0x00050
   #define MPIC_GREG_VENDOR_2		0x00060

So the question is, should #define MPIC_GREG_GLOBAL_CONF_1 have been also
removed, or could be left as is?

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-June/023867.html

Ars=C3=A9ny

> cheers
