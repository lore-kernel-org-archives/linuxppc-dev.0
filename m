Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkhsZ4PXGzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 13:48:18 +1000 (AEST)
Message-ID: <1504324083.4974.102.camel@kernel.crashing.org>
Subject: Re: [PATCH 14/19] powerpc: Add ppc_strict_facility_enable boot option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 02 Sep 2017 13:48:03 +1000
In-Reply-To: <1446079451-8774-15-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-15-git-send-email-anton@samba.org>
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

On Thu, 2015-10-29 at 11:44 +1100, Anton Blanchard wrote:
>  
> +extern void msr_check_and_set(unsigned long bits);
> +extern bool strict_msr_control;
> +extern void __msr_check_and_clear(unsigned long bits);
> +static inline void msr_check_and_clear(unsigned long bits)
> +{
> +       if (strict_msr_control)
> +               __msr_check_and_clear(bits);
> +}
> +
>  static inline unsigned long mfvtb (void)

Sounds like a good candidate for a static key...

Cheers,
Ben.
