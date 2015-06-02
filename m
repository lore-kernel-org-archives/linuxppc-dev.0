Return-Path: <dja@axtens.net>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35D491A0050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 09:39:08 +1000 (AEST)
Received: by pdbki1 with SMTP id ki1so143223194pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 16:39:06 -0700 (PDT)
Message-ID: <1433288296.438.30.camel@axtens.net>
Subject: Re: [PATCH v1 3/9]powerpc/powernv: Add cpu hotplug support
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter
 Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Preeti U Murthy
 <preeti@linux.vnet.ibm.com>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 09:38:16 +1000
In-Reply-To: <1433260778-26497-4-git-send-email-maddy@linux.vnet.ibm.com>
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-4-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-BpXyCyWRl2Gz73c9+mEu"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-BpXyCyWRl2Gz73c9+mEu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
> Patch adds cpu hotplug support. First online cpu in a node is picked as
> designated thread to read the Nest pmu counter data, and at the time of
> hotplug, next online cpu from the same node is picked up.

I'm not sure I understand this commit message. I think I understand the
first half - I think you're trying to say: "At boot, the first online
CPU in a node is picked as the designated thread to read the Nest PMU
counter data." I'm not sure I understand the second half: "picked up"
how and for what?

(I did eventually figure it out by reading the patch, but it'd be really
nice to have it spelled out nicely in the commit message.)

> +static void nest_exit_cpu(int cpu)
> +{
> +	int i, nid, target =3D -1;
> +	const struct cpumask *l_cpumask;
> +	int src_chipid;
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &cpu_mask_nest_pmu))
> +		return;
> +
> +	nid =3D cpu_to_node(cpu);
> +	src_chipid =3D topology_physical_package_id(cpu);
> +	l_cpumask =3D cpumask_of_node(nid);
> +	for_each_cpu(i, l_cpumask) {
> +		if (i =3D=3D cpu)
> +			continue;
> +		if (src_chipid =3D=3D topology_physical_package_id(i)) {
> +			target =3D i;
> +			break;
> +		}
> +	}

Some comments here would really help. I think you're looking for the
first CPU that's (a) not the cpu you're removing and (b) on the same
physical package, so sharing the same nest, but it took me a lot of
staring at the code to figure it out.

> +
> +	cpumask_set_cpu(target, &cpu_mask_nest_pmu);
> +	nest_change_cpu_context (cpu, target);
> +	return;
Return is redundant here and in several other functions in this patch.
> +}
> +
> +static void nest_init_cpu(int cpu)
> +{
> +	int i, src_chipid;
> +
> +	src_chipid =3D topology_physical_package_id(cpu);
> +	for_each_cpu(i, &cpu_mask_nest_pmu)
> +		if (src_chipid =3D=3D topology_physical_package_id(i))
> +			return;
> +
> +	cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
> +	nest_change_cpu_context ( -1, cpu);
Weird extra spaces here.

> +	return;
> +}
This function could also do with a comment: AFAICT, you've structured
the function so that it only calls nest_change_cpu_context if you've
picked up a cpu on a physical package that previously didn't have a nest
pmu thread on it.

> +
> +static int nest_cpu_notifier(struct notifier_block *self,
> +				unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu =3D (long)hcpu;
What's with this cast? You cast it to a long and then assign it to an
unsigned int?
> +
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_DOWN_FAILED:
Is it necessary to move the thread back if the CPU fails to go down?
You've moved it to another online CPU already; what's the benefit of
paying the time-penalty to move it back?
> +	case CPU_STARTING:
> +		nest_init_cpu(cpu);
> +		break;
> +	case CPU_DOWN_PREPARE:
> +		nest_exit_cpu(cpu);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

> =20

Now, I don't know the details of CPU hotplug _at all_, so this may be
stupid, but what happens if you hotplug a lot of CPUs all at once? Is
everything properly serialised or is this going to race and end up with
either multiple cpus trying to do PMU or no cpus?

Regards,
Daniel Axtens



--=-BpXyCyWRl2Gz73c9+mEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVbj5pAAoJEPC3R3P2I92FT9wQAMk7mNbuGwytFPqqxMkck5oQ
dY4r8cCDrNiANbGgzCnrQLm4gVHTztDS4NHAJ5FT3WBlwhheabW35dArEobVWx2h
6ZEBk7qSQQvWDRB1RYlASk8GARC1FZC6UB/oTvMY32q+R0CyhyULMRXFI+MgFB/9
D5/wMQR9a5dLW0yZnfIjGxaffYU38EjcYFAgB0nVgYhm9cSa9+Ov3tBxto1H72gM
2pwOm8yyFdY0zFm8bY8kh8zlYvwVmBFgpm3dTcARaTctmP9sdqPyedzs8M8Ia8aR
aYuB+bxHAMErsCaBYC5opxzOba4D7msN9uWt88riVxcQILCt+5tdvVFdVnRaGxHF
rvw/YckVtcoerkBrNnakxIqdEmqx0yECgPfXJASbgdqWTVhlhBTeAa0TvUSz9eK6
SvPWPykgx7Cjm2UKHt0h8q3AOpa7/qcsaIAEv1/2RY0BmKxwxH+WBCeUafm1SGbY
ktYwGoKaMP7nE+4XZyuxgux/+N5VDFhOffUbOE+UgWQ3nJViBpJcThmxORWMfTxm
he8zTFnfqBlWn48E2omOHCMp7rrk6wyYoNmKTXsWeSh9R2ifX0LtuEPeO0ek1l3d
gW/boB60Go3LaR6fx303scSGt/rTkusoy0i5fvJ6i0re+SS6a0GlPrlRfuJvWLlB
mRbGS6jTtn+9+wII7v2Z
=pwAz
-----END PGP SIGNATURE-----

--=-BpXyCyWRl2Gz73c9+mEu--
