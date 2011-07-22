Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f43.google.com (mail-vw0-f43.google.com
	[209.85.212.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 354ACB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:11:16 +1000 (EST)
Received: by vws10 with SMTP id 10so3142934vws.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 13:11:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <276D152E-9A93-448C-BB1B-D749697FF4F0@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-11-git-send-email-dbaryshkov@gmail.com>
	<276D152E-9A93-448C-BB1B-D749697FF4F0@kernel.crashing.org>
Date: Sat, 23 Jul 2011 00:11:13 +0400
Message-ID: <CALT56yMseM-2kcuszcVPJq_o3O1Mb4dSsgrMY_rHQD-2Q50D-A@mail.gmail.com>
Subject: Re: [PATCH 10/14] 85xx/mpc85xx_rdb: merge p1020_rdb and p2020_rdb
	machine entries
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/19/11, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:
>
>> p1020_rdb and p2020_rdb machine entries bear no in-kernel differencies
>> other than dt compatible strings. Merge them into single machine entry
>> named mpc85xx_rdb
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>> arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   40
>> ++++++----------------------
>> 1 files changed, 9 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> index 088f30b..7a3a37b 100644
>> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> @@ -120,47 +120,25 @@ static int __init mpc85xxrdb_publish_devices(void)
>> {
>> 	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
>> }
>> -machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
>> -machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
>> +machine_device_initcall(mpc85xx_rdb, mpc85xxrdb_publish_devices);
>>
>> /*
>>  * Called very early, device-tree isn't unflattened
>>  */
>> -static int __init p2020_rdb_probe(void)
>> +static int __init mpc85xx_rdb_probe(void)
>> {
>> 	unsigned long root = of_get_flat_dt_root();
>>
>> -	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB"))
>> +	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB") ||
>> +	    of_flat_dt_is_compatible(root, "fsl,P2020RDB")) {
>> 		return 1;
>> -	return 0;
>> +	} else
>> +		return 0;
>> }
>>
>> -static int __init p1020_rdb_probe(void)
>> -{
>> -	unsigned long root = of_get_flat_dt_root();
>> -
>> -	if (of_flat_dt_is_compatible(root, "fsl,P1020RDB"))
>> -		return 1;
>> -	return 0;
>> -}
>> -
>> -define_machine(p2020_rdb) {
>> -	.name			= "P2020 RDB",
>> -	.probe			= p2020_rdb_probe,
>> -	.setup_arch		= mpc85xx_rdb_setup_arch,
>> -	.init_IRQ		= mpc85xx_rdb_pic_init,
>> -#ifdef CONFIG_PCI
>> -	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
>> -#endif
>> -	.get_irq		= mpic_get_irq,
>> -	.restart		= fsl_rstcr_restart,
>> -	.calibrate_decr		= generic_calibrate_decr,
>> -	.progress		= udbg_progress,
>> -};
>> -
>> -define_machine(p1020_rdb) {
>> -	.name			= "P1020 RDB",
>> -	.probe			= p1020_rdb_probe,
>> +define_machine(mpc85xx_rdb) {
>> +	.name			= "MPC85xx RDB",
>
> breaking 'name' this way isn't acceptable.

BTW: what is so special in p1010rdb, so it's not
merged into this file, but exists as a separate .c file?

>
>> +	.probe			= mpc85xx_rdb_probe,
>> 	.setup_arch		= mpc85xx_rdb_setup_arch,
>> 	.init_IRQ		= mpc85xx_rdb_pic_init,
>> #ifdef CONFIG_PCI
>> --
>> 1.7.2.5
>
>


-- 
With best wishes
Dmitry
