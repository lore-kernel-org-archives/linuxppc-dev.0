Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS2w65DfpzDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:29:42 +1000 (AEST)
Message-ID: <1502263749.2563.36.camel@kernel.crashing.org>
Subject: Re: [PATCH 10/10] powerpc/xive: fix the size of the cpumask used in
 xive_find_target_in_mask()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>
Date: Wed, 09 Aug 2017 17:29:09 +1000
In-Reply-To: <874lthnrse.fsf@concordia.ellerman.id.au>
References: <1502182969-3180-1-git-send-email-clg@kaod.org>
 <874lthnrse.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-08-09 at 17:06 +1000, Michael Ellerman wrote:
>   /**
>    * cpumask_weight - Count of bits in *srcp
>    * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
>    */
>   static inline unsigned int cpumask_weight(const struct cpumask *srcp)
>   {
>         return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
>   }
> 
> 
> I don't know what the comment on srcp is trying to say. It's not true
> that it only counts nr_cpu_ids worth of bits.

Right, and that's what bit me. We should report that on lkml and maybe
propose a patch that crops the result...

Cheers,
Ben.
