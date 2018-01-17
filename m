Return-Path: <srs0=s74q=em=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM4Hj5zk7zDqsT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 22:14:57 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zM4Hj55jkz8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 22:14:57 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zM4Hj1Ymyz9sDB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 22:14:57 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HBE824101920
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 06:14:55 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fj3gqwdpe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 06:14:54 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 17 Jan 2018 11:14:52 -0000
Subject: Re: [PATCH 3/6] KVM: PPC: Book3S HV: Allow HPT and radix on the
 same core for POWER9 v2.2
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Date: Wed, 17 Jan 2018 22:14:45 +1100
In-Reply-To: <1516182675-25331-4-git-send-email-paulus@ozlabs.org>
References: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
 <1516182675-25331-4-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516187685.31850.190.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-17 at 20:51 +1100, Paul Mackerras wrote:
> +
> +       /*
> +        * POWER9 chips before version 2.02 can't have some threads in
> +        * HPT mode and some in radix mode on the same core.
> +        */
> +       if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +               unsigned int pvr = mfspr(SPRN_PVR);
> +               if ((pvr >> 16) == PVR_POWER9 && (pvr & 0xfff) < 0x202)
> +                       no_mixing_hpt_and_radix = true;
> +       }
> +
>         return r;
>  }

You need to check that it's a Nimbus using the top nimble of the bottom
16 bits of PVR. For Cumulus, the fixes are either in 1.0 or 1.1 (to
check).

Cheers,
Ben.
