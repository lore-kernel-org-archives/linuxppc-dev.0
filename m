Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A56C1B71AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 04:15:17 +1000 (EST)
Received: by vws20 with SMTP id 20so3738379vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 11:15:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cca27f630fb5e3388eef060ea784f024@kernel.crashing.org>
References: <1305973871-28244-2-git-send-email-dbaryshkov@gmail.com>
	<1305977629-26648-1-git-send-email-dbaryshkov@gmail.com>
	<cca27f630fb5e3388eef060ea784f024@kernel.crashing.org>
Date: Sat, 21 May 2011 22:15:13 +0400
Message-ID: <BANLkTimCq6zOtZ3LYKdXLsvqr5SVeMnsDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpc925_edac: support single-processor configurations
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On 5/21/11, Segher Boessenkool <segher@kernel.crashing.org> wrote:
>> If second CPU is not enabled, CPC925 EDAC driver will spill out
>> warnings
>> about errors on second Processor Interface. Support masking that out,
>> by detecting at runtime which CPUs are present in device tree.
>
> That doesn't quite work, there can be multiple CPUs per processor
> interface.

Are you sure that there can be multiple CPUs on one PI with CPC925
(CPC945 isn't supported by this driver anyway, IIUC).

> You should be able to see which interfaces are enabled in some CPC925
> register,
> but maybe both _are_ enabled on your system (although one is not
> connected),
> which is causing the errors?

Hmm, I dont't think this is the case: I'm using a MapleD board with two CPUs
connected to separate PIs. However I can slect the service processor
to enable only one CPU via selecting correct bootscript. In this case
bootscript correctly enables only APIMASK_ADI0. However as cpc925_edac
checks the APIEXCP itself, it sees the APIEXCP_ADI1 bit set and spills
regular warnings about it (see below).

If you'd prefer I can add a check for APIMASK at cpc925_cpu_init() time,
but I think that this will be less robust.

-- 
With best wishes
Dmitry
