Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSMP01D8LzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:51:47 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LDnSQH003195
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:51:45 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rku6g5cq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:51:45 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 10:51:43 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 542483520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:51:07 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LDpZd517301704
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:51:40 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LDpKw3028109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:51:20 -0300
Subject: Re: [PATCH v3 3/3] powerpc/xmon: add debugfs entry for xmon
To: Pan Xinhui <xinhui@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1487642322-28380-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1487642322-28380-4-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <438891ca-62e7-6d76-e698-2a2c5c0480ad@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, xinhui.pan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 10:51:04 -0300
MIME-Version: 1.0
In-Reply-To: <438891ca-62e7-6d76-e698-2a2c5c0480ad@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk
Message-Id: <27dbed2d-65c9-a8d0-a50c-c5dafa729d5d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2017 03:35 AM, Pan Xinhui wrote:
> 
> 
> ÔÚ 2017/2/21 09:58, Guilherme G. Piccoli Ð´µÀ:
>> Currently the xmon debugger is set only via kernel boot command-line.
>> It's disabled by default, and can be enabled with "xmon=on" on the
>> command-line. Also, xmon may be accessed via sysrq mechanism.
>> But we cannot enable/disable xmon in runtime, it needs kernel reload.
>>
>> This patch introduces a debugfs entry for xmon, allowing user to query
>> its current state and change it if desired. Basically, the "xmon" file
>> to read from/write to is under the debugfs mount point, on powerpc
>> directory. It's a simple attribute, value 0 meaning xmon is disabled
>> and value 1 the opposite. Writing these states to the file will take
>> immediate effect in the debugger.
>>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>> ---
>> v3: logic improved based in the changes made on patch 1.
>>
>> v2: dropped the custom parser by using simple attributes [mpe suggestion].
>>
>>
>>  arch/powerpc/xmon/xmon.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index f1fcfa8..764ea62 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -29,6 +29,10 @@
>>  #include <linux/nmi.h>
>>  #include <linux/ctype.h>
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +#include <linux/debugfs.h>
>> +#endif
>> +
>>  #include <asm/ptrace.h>
>>  #include <asm/string.h>
>>  #include <asm/prom.h>
>> @@ -3275,6 +3279,33 @@ static int __init setup_xmon_sysrq(void)
>>  device_initcall(setup_xmon_sysrq);
>>  #endif /* CONFIG_MAGIC_SYSRQ */
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +static int xmon_dbgfs_set(void *data, u64 val)
>> +{
>> +	xmon_off = !val;
> xmon_off is really 'off' :)
> There is xmon_on
> 

OK, this is *really* odd.
I sent the wrong version of the patch ={

I'm _sorry_, thanks for noticing Xinhui!

@Michael, my complete fault. I tested the real "v3" of this patch, but
for some reason (aka my disorganization) I sent the old v2. In the v3, I
used "xmon_on = !!val".

How about if I resend the whole series tomorrow, correcting this and
changing patch 2 in order to keep the automatic show of backtrace
always? Or do you prefer to fix it yourself?

Thanks, and again, I apologize for the mess.


Guilherme



>> +	xmon_init(!xmon_off);
>> +
>> +	return 0;
>> +}
>> +
>> +static int xmon_dbgfs_get(void *data, u64 *val)
>> +{
>> +	*val = !xmon_off;
>> +	return 0;
>> +}
>> +
>> +DEFINE_SIMPLE_ATTRIBUTE(xmon_dbgfs_ops, xmon_dbgfs_get,
>> +			xmon_dbgfs_set, "%llu\n");
>> +
>> +static int __init setup_xmon_dbgfs(void)
>> +{
>> +	debugfs_create_file("xmon", 0600, powerpc_debugfs_root, NULL,
>> +				&xmon_dbgfs_ops);
>> +	return 0;
>> +}
>> +device_initcall(setup_xmon_dbgfs);
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>>  static int xmon_early __initdata;
>>
>>  static int __init early_parse_xmon(char *p)
>>
