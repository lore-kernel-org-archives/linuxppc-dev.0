Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B0CCB71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 06:03:24 +1000 (EST)
In-Reply-To: <BANLkTimCq6zOtZ3LYKdXLsvqr5SVeMnsDg@mail.gmail.com>
References: <1305973871-28244-2-git-send-email-dbaryshkov@gmail.com>
	<1305977629-26648-1-git-send-email-dbaryshkov@gmail.com>
	<cca27f630fb5e3388eef060ea784f024@kernel.crashing.org>
	<BANLkTimCq6zOtZ3LYKdXLsvqr5SVeMnsDg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ed1c0926526a93858f21a1538eb84f7b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] cpc925_edac: support single-processor configurations
Date: Sat, 21 May 2011 22:04:54 +0200
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> If second CPU is not enabled, CPC925 EDAC driver will spill out
>>> warnings
>>> about errors on second Processor Interface. Support masking that out,
>>> by detecting at runtime which CPUs are present in device tree.
>>
>> That doesn't quite work, there can be multiple CPUs per processor
>> interface.
>
> Are you sure that there can be multiple CPUs on one PI with CPC925
> (CPC945 isn't supported by this driver anyway, IIUC).

I do not know any board that actually uses this.  And, hrm, you cannot
use 970MP with CPC925 if I remember correctly.

It's still better to look what processor interfaces are working 
correctly
though.  But given that this is essentially a dead platform, I'm okay 
with
this hack, if it works ;-)

>> You should be able to see which interfaces are enabled in some CPC925
>> register,
>> but maybe both _are_ enabled on your system (although one is not
>> connected),
>> which is causing the errors?
>
> Hmm, I dont't think this is the case: I'm using a MapleD board with 
> two CPUs
> connected to separate PIs. However I can slect the service processor
> to enable only one CPU via selecting correct bootscript. In this case
> bootscript correctly enables only APIMASK_ADI0. However as cpc925_edac
> checks the APIEXCP itself, it sees the APIEXCP_ADI1 bit set and spills
> regular warnings about it (see below).

(no below :-) )

I think the service processor left that processor interface enabled (the
interface itself, not the exception stuff), so the exception thing will
signal exceptions any time the CPC925 sends snoops to that second
processor.  This also might reduce performance.

Or maybe it is normal for the exception thing to signal errors on 
disabled
interfaces.

> If you'd prefer I can add a check for APIMASK at cpc925_cpu_init() 
> time,
> but I think that this will be less robust.

Yeah that's less robust, for sure.

Just keep what you have, but add a big fat comment that you are assuming
the processor interface id is identical to the MPIC processor id :-)

Did you test disabling physical CPU #0 as well?


Segher
