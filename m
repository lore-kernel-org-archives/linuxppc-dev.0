Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECA2C67B8D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 19:01:03 +1000 (EST)
Message-ID: <448FD041.203@cambridgebroadband.com>
Date: Wed, 14 Jun 2006 10:00:49 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: No ttyS device at I/O port 0xfe004500 for console
References: <IIEEICKJLNEPBBDJICNGCEFHLDAA.chuckmeade@mindspring.com>
	<4E69849F-EC8B-48C0-9036-74EDCD14B2F5@kernel.crashing.org>
In-Reply-To: <4E69849F-EC8B-48C0-9036-74EDCD14B2F5@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> Here you go:
> 
> Let me know if this fixes the issues you guys are seeing with your 83xx 
> boards.  If so, I'll clean up this patch and push it upstream.
> 
> - k


Great, thank you!

Your patch and the params "console=uart,io,0xfe004500 console=ttyS0" in
the kernel command line do the trick.

Alex



> 
>> --- mpc83xx_sys.c-ORIG    2006-06-13 17:54:36.577339832 -0400
>> +++ mpc83xx_sys.c    2006-06-13 17:56:02.394293672 -0400
>> @@ -136,6 +136,23 @@ struct ppc_sys_spec ppc_sys_specs[] = {
>>  #endif
>>          },
>>      },
>> +    {
>> +        .ppc_sys_name    = "8323E",
>> +        .mask        = 0xFFFF0000,
>> +        .value        = 0x80620000,
>> +#ifdef CONFIG_QE
>> +        .num_devices    = 4,
>> +#else
>> +        .num_devices    = 2,
>> +#endif
>> +        .device_list    = (enum ppc_sys_devices[])
>> +        {
>> +            MPC83xx_IIC1, MPC83xx_DUART,
>> +#ifdef CONFIG_QE
>> +            MPC83xx_QE_UCC3, MPC83xx_QE_UCC4,
>> +#endif
>> +        },
>> +    },
>>      {    /* default match */
>>          .ppc_sys_name    = "",
>>          .mask         = 0x00000000,
>>
>>
>> Regards,
>> Chuck
>>
> 
