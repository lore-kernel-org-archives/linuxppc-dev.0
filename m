Return-Path: <vitalywool@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 4B1B467B9B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 21:48:21 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id x4so558036nfb
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Nov 2006 02:48:19 -0800 (PST)
Message-ID: <acd2a5930611010248o453b3a2ara1918d1213dac8aa@mail.gmail.com>
Date: Wed, 1 Nov 2006 13:48:19 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: [PATCH] Fix oprofile support for e500 in arch/powerpc
In-Reply-To: <Pine.LNX.4.61.0610271501270.23433@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <Pine.LNX.4.61.0610271501270.23433@ld0175-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Oprofile List <oprofile-list@lists.sourceforge.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/27/06, Andy Fleming <afleming@freescale.com> wrote:
> Fixed a compile error in building the 85xx support with oprofile, and in
> the process cleaned up some issues with the fsl_booke performance monitor
> code.
>
> * Reorganized FSL Book-E performance monitoring code so that the 7450
>   wouldn't be built if the e500 was, and cleaned it up so it was more
>   self-contained.
>
> * Added a cpu_setup function for FSL Book-E.  The original
>   cpu_setup function prototype had no arguments, assuming that
>   the reg_setup function would copy the required information into
>   variables which represented the registers.  This was silly for
>   e500, since it has 1 register per counter (rather than 3 for
>   all counters), so the code has been restructured to have
>   cpu_setup take the current counter config array as an argument,
>   with op_powerpc_setup() invoking op_powerpc_cpu_setup() through
>   on_each_cpu(), and op_powerpc_cpu_setup() invoking the
>   model-specific cpu_setup function with an argument.  The
>   argument is ignored on all other platforms at present.
>
> * Fixed a confusing line where a trinary operator only had two
>   arguments
> Signed-off-by: Andrew Fleming <afleming@freescale.com>

I'm pretty comfortable with this one, waiting for it to appear in the
powerpc git tree...

Vitaly
