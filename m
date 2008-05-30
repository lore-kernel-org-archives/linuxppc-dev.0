Return-Path: <wg@grandegger.com>
Message-ID: <483FA8F6.30605@grandegger.com>
Date: Fri, 30 May 2008 09:12:54 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080530170153.45a763b6.sfr@canb.auug.org.au>
In-Reply-To: <20080530170153.45a763b6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Wolfgang,
> 
> On Fri, 30 May 2008 08:49:45 +0200 Wolfgang Grandegger <wg@grandegger.com> wrote:
>> +++ b/arch/powerpc/platforms/85xx/tqm85xx.c
>> @@ -120,8 +120,17 @@ static void __init tqm85xx_setup_arch(void)
>>  #endif
>>  
>>  #ifdef CONFIG_PCI
>> -	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
>> -		fsl_add_bridge(np, 1);
>> +	for_each_node_by_type(np, "pci") {
>> +		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
>> +		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
>> +			struct resource rsrc;
>> +			of_address_to_resource(np, 0, &rsrc);
> 
> What happens if of_address_to_resource fails?

Checking the return code is missing, of course. Obviously a cut & paste
from a bad source (sbc8548.c).

Will fix.

Wolfgang.
