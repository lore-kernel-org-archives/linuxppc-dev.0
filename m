Return-Path: <maxk@qualcomm.com>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "wolverine01.qualcomm.com",
	Issuer "VeriSign Class 3 Secure Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 495B1DDDE0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 17:56:02 +1100 (EST)
Message-ID: <4923B597.7090208@qualcomm.com>
Date: Tue, 18 Nov 2008 22:43:35 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: default IRQ affinity change in v2.6.27 (breaking several SMP
	PPC based systems)
References: <4E3CD4D5-FC1B-40BF-A776-C612B95806B8@kernel.crashing.org>	<4901E6FB.4070200@redhat.com>	<36A821E7-7F37-42AF-9A05-7205FCBF89EE@kernel.crashing.org>
	<20081024.161818.256978293.davem@davemloft.net>
In-Reply-To: <20081024.161818.256978293.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"csnook@redhat.com" <csnook@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Miller wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Fri, 24 Oct 2008 10:39:05 -0500
> 
>> As for making it ARCH specific, that doesn't really help since not
>> all PPC hw has the limitation I spoke of.  Not even all MPIC (in our
>> cases) have the limitation.
> 
> Since the PPC code knows exactly which MPICs have the problem the
> PPC code is where the constraining can occur.
> 
> I agree completely with the suggestion that the arch code has to
> interpret the cpumask as appropriate for the hardware, since the
> user can stick "illegal" values there anyways.

Sorry for delay in replying to this. And sorry for causing regression on some
ppc platforms.
I totally agree with what Dave said above. ALL_CPUS is a sane default,
platform code has to sanity check masks passed via set_affinity() calls
anyway. So I beleive it should be fixed in the platform code.

Max
