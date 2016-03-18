Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRh5x5KtFzDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 10:20:21 +1100 (AEDT)
Message-ID: <1458343221.6622.88.camel@neuling.org>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
From: Michael Neuling <mikey@neuling.org>
To: benh@au1.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 shreyas@linux.vnet.ibm.com, rjw@rjwysocki.net, pc@us.ibm.com,
 viresh.kumar@linaro.org, anton@samba.org
Date: Sat, 19 Mar 2016 10:20:21 +1100
In-Reply-To: <1458340635.3107.89.camel@au1.ibm.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1458273857.6622.75.camel@neuling.org>
 <1458340635.3107.89.camel@au1.ibm.com>
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

On Sat, 2016-03-19 at 09:37 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-03-18 at 15:04 +1100, Michael Neuling wrote:
> >=20
> >  static int nr_chips;
> > +static DEFINE_PER_CPU(unsigned int, chip_id);
> > =20
> >  /*
> >   * Note: The set of pstates consists of contiguous integers, the
> > @@ -317,9 +318,7 @@ static void powernv_cpufreq_throttle_check(void
> > *data)
> > =20
> >         pmsr =3D get_pmspr(SPRN_PMSR);
> > =20
> > -       for (i =3D 0; i < nr_chips; i++)
> > -               if (chips[i].id =3D=3D cpu_to_chip_id(cpu))
> > -                       break;
> > +       i =3D this_cpu_read(chip_id);
>=20
> Except it's not a chip_id, so your patch confused me for a good 2mn
> ...
> Call it chip_idx maybe ? ie, index.

Yeah, it was a badly named variable but I changed it even more and
Shilpasri rebased it here:

http://patchwork.ozlabs.org/patch/599523/

Mikey
