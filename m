Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37F08B6F7B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2011 21:38:15 +1000 (EST)
Subject: Re: [RFC][PATCH] powerpc: respect how command line nr_cpus is set
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1304562302.2513.418.camel@pasglop>
Date: Thu, 5 May 2011 06:38:01 -0500
Message-Id: <B122211D-FA1E-4B0D-8399-6EC4F701FCDF@kernel.crashing.org>
References: <1304540257-19831-1-git-send-email-galak@kernel.crashing.org>
	<1304562302.2513.418.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 4, 2011, at 9:25 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2011-05-04 at 15:17 -0500, Kumar Gala wrote:
>> We should utilize nr_cpus as the max # of CPUs that we can have =
present
>> instead of NR_CPUS.  This way we actually respect how nr_cpus is set =
on
>> the command line rather than ignoring it.
>>=20
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> I think this is what we should be doing, but would like someone else =
to take
>> a look.
>=20
> The main question I have is should max_cpus absolutely limit the =
number
> of possible CPUs or should it limit the number that get automatically
> onlined at boot, potentially letting us bring the rest online later on =
?
>=20
> Cheers,
> Ben.

=46rom Documentation/kernel-parameters.txt:

        nr_cpus=3D        [SMP] Maximum number of processors that an SMP =
kernel
                        could support.  nr_cpus=3Dn : n >=3D 1 limits =
the kernel to
                        supporting 'n' processors. Later in runtime you =
can not
                        use hotplug cpu feature to put more cpu back to =
online.
                        just like you compile the kernel NR_CPUS=3Dn

Which makes me think we should have max_cpus be an absolute limit.

- k=
