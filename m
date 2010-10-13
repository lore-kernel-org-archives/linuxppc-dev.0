Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74A46B70F1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 04:29:56 +1100 (EST)
Subject: Re: [PATCH v3] powerpc/fsl-booke: Add support for FSL 64-bit e5500
	core
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101013105808.4ca3b565@udp111988uds.am.freescale.net>
Date: Wed, 13 Oct 2010 12:29:47 -0500
Message-Id: <F858E875-9C4D-4F73-9405-9E6861DA9548@kernel.crashing.org>
References: <1286975832-31895-1-git-send-email-galak@kernel.crashing.org>
	<20101013105808.4ca3b565@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 10:58 AM, Scott Wood wrote:

> On Wed, 13 Oct 2010 08:17:11 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>=20
>> The new e5500 core is similar to the e500mc core but adds 64-bit
>> support.  We support running it in 32-bit mode as it is identical to =
the
>> e500mc.
>>=20
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> * clean up kconfig further to reduce use of E500MC
>=20
> Looks better, just a few nits:
>=20
>> -#ifdef CONFIG_E500
>> +#if defined(CONFIG_E500) || defined(CONFIG_PPC_BOOK3E_64)
>> /* All e500 */
>> #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
>> #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
>=20
> Is this really supposed to be here for all 64-bit book3e?  Likewise in
> the C code.

This is a question I need to ask BenH about.  If we intend or desire to =
have a single kernel image that works on all 64-bit book3e parts or not.

>=20
>> +obj-$(CONFIG_PPC_BOOK3E_64)	+=3D cpu_setup_fsl_booke.o
>=20
> CONFIG_PPC_FSL_BOOK3E?

will fix.

>> @@ -66,6 +66,10 @@ extern void __restore_cpu_ppc970(void);
>> extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* =
spec);
>> extern void __restore_cpu_power7(void);
>> #endif /* CONFIG_PPC64 */
>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)
>> +extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* =
spec);
>> +extern void __restore_cpu_e5500(void);
>> +#endif /* CONFIG_PPC_BOOK3E_64 || CONFIG_E500 */
>=20
> CONFIG_E500 should be sufficient.  Not sure why these need to be
> ifdeffed at all, though it seems to be existing practice here.

again, about if we want a generic ppc64e build or not, but I'm now =
thinking that would end up setting CONFIG_E500 anyways.

>> /* This table only contains "desktop" CPUs, it need to be filled with =
embedded
>>  * ones as well...
>> @@ -1891,7 +1895,28 @@ static struct cpu_spec __initdata cpu_specs[] =
=3D {
>> 		.platform		=3D "ppc5554",
>> 	}
>> #endif /* CONFIG_E200 */
>> -#ifdef CONFIG_E500
>> +#endif /* CONFIG_PPC32 */
>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)
>=20
> Just E500 should work.
>=20
>> @@ -538,6 +538,11 @@ int machine_check_e500(struct pt_regs *regs)
>>=20
>> 	return 0;
>> }
>> +
>> +int machine_check_generic(struct pt_regs *regs)
>> +{
>> +	return 0;
>> +}
>=20
> Hmm, it seems that either the cputable entry that references this
> should not be built in if we don't support those chips, or the real
> implementation shouldn't be under an #else if we are going to support
> multiplatform coexistence with them.


- k=
