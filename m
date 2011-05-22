Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20757B6FB1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 19:12:34 +1000 (EST)
Received: by vxi40 with SMTP id 40so4005406vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 02:12:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed1c0926526a93858f21a1538eb84f7b@kernel.crashing.org>
References: <1305973871-28244-2-git-send-email-dbaryshkov@gmail.com>
	<1305977629-26648-1-git-send-email-dbaryshkov@gmail.com>
	<cca27f630fb5e3388eef060ea784f024@kernel.crashing.org>
	<BANLkTimCq6zOtZ3LYKdXLsvqr5SVeMnsDg@mail.gmail.com>
	<ed1c0926526a93858f21a1538eb84f7b@kernel.crashing.org>
Date: Sun, 22 May 2011 13:12:30 +0400
Message-ID: <BANLkTi=8+c3NOFiYXZLbhc9vwtCBG9=9zQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpc925_edac: support single-processor configurations
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 22, 2011 at 12:04 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>>> You should be able to see which interfaces are enabled in some CPC925
>>> register,
>>> but maybe both _are_ enabled on your system (although one is not
>>> connected),
>>> which is causing the errors?
>>
>> Hmm, I dont't think this is the case: I'm using a MapleD board with two
>> CPUs
>> connected to separate PIs. However I can slect the service processor
>> to enable only one CPU via selecting correct bootscript. In this case
>> bootscript correctly enables only APIMASK_ADI0. However as cpc925_edac
>> checks the APIEXCP itself, it sees the APIEXCP_ADI1 bit set and spills
>> regular warnings about it (see below).
>
> (no below :-) )

Sorry, here it goes:

EDAC CPC925: Processor Interface Fault
Processor Interface register dump:
EDAC CPC925: APIMASK            0xdea00000
EDAC CPC925: APIEXCP            0x20000000
EDAC DEVICE0: INTERNAL ERROR: instance 0 'block' out of range (0 >=3D 0)

> I think the service processor left that processor interface enabled (the
> interface itself, not the exception stuff), so the exception thing will
> signal exceptions any time the CPC925 sends snoops to that second
> processor. =A0This also might reduce performance.
>
> Or maybe it is normal for the exception thing to signal errors on disable=
d
> interfaces.

I only have U4 manual, so I can't be sure about U3H. And for U4 manual is
also unclear about ADI1 exception.

>> If you'd prefer I can add a check for APIMASK at cpc925_cpu_init() time,
>> but I think that this will be less robust.
>
> Yeah that's less robust, for sure.
>
> Just keep what you have, but add a big fat comment that you are assuming
> the processor interface id is identical to the MPIC processor id :-)

sure

> Did you test disabling physical CPU #0 as well?

No. I still don't have _that_ level of understanding of PIBS boot scripts.

--=20
With best wishes
Dmitry
