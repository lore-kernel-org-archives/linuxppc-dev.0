Return-Path: <kumar.gala@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id AFB89B6EED
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 02:16:48 +1000 (EST)
Subject: Re: Please pull my perf.git urgent branch
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <20100728044731.GA2408@brick.ozlabs.ibm.com>
Date: Wed, 28 Jul 2010 11:15:38 -0500
Message-ID: <10DB64E9-7D7E-497C-9044-C2649D22981D@freescale.com>
References: <20100727124019.GB14947@brick.ozlabs.ibm.com>
	<20100727112854.7bf97d48@schlenkerla.am.freescale.net>
	<20100728044731.GA2408@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Wood <scottwood@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 27, 2010, at 11:47 PM, Paul Mackerras wrote:

> On Tue, Jul 27, 2010 at 11:28:54AM -0500, Scott Wood wrote:
>=20
>> Doesn't the setting of .period need to be maintained (it is in the =
other
>> powerpc perf_event implementation that this is derived from)?
>=20
> Gah, yes it does.
>=20
>> I don't see how this is a security fix -- the existing initializer =
above
>> should zero-fill the fields that are not explicitly initialized.  In =
fact,
>> it's taking other fields that were previously initialized to zero and =
is
>> making them uninitialized, since perf_sample_data_init only sets addr =
and
>> raw.
>=20
> So I misunderstood how an initializer for an automatic struct works.
> Brown paper bag time for me... :(
>=20
> Regarding the other fields, I assume Peter et al. have checked that
> they don't need to be cleared, so it's a microoptimization to not
> clear them.
>=20
>> CCing linuxppc-dev on the original patch would have been nice...
>=20
> True, but at least I can blame Peter Z. for that. :)
>=20
> Kumar and Ben, how do you want to proceed on this one?

If we aren't concerned about an oops being generated lets just submit a =
patch for 2.6.36.

- k=
