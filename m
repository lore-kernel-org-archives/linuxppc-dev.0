Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 758ECDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 12:16:14 +1100 (EST)
Message-ID: <45C92856.4080107@am.sony.com>
Date: Tue, 06 Feb 2007 17:16:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 3/3] PS3: System manager support
References: <45C8FFF7.7090805@am.sony.com>
	<1170806435.4640.3.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1170806435.4640.3.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2007-02-06 at 14:23 -0800, Geoff Levand wrote:
>> Add PS3 system manager support and the ppc_md routines restart() and
>> power_off().
>> 
>> The system manager provides an event notification mechanism for reporting
>> events like thermal alert and button presses.  It also provides support to
>> control system shutdown and startup.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> ---
>>  arch/powerpc/platforms/ps3/Kconfig |   10 
>>  arch/powerpc/platforms/ps3/setup.c |   27 +
>>  drivers/ps3/Makefile               |    1 
>>  drivers/ps3/sys-manager.c          |  621 +++++++++++++++++++++++++++++++++++++
>>  include/asm-powerpc/ps3.h          |    5 
>>  5 files changed, 660 insertions(+), 4 deletions(-)
>> 
>> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/Kconfig
>> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/Kconfig
>> @@ -61,4 +61,14 @@ config PS3_PS3AV
>>  	  This support is required for graphics and sound. In
>>  	  general, all users will say Y or M.
>>  
>> +config PS3_SYS_MANAGER
>> +	tristate "PS3 System Manager driver"
>> +	select PS3_VUART
>> +	default y
>> +	help
>> +	  Include support for the PS3 System Manager.
>> +
>> +	  This support is required for system control.  In
>> +	  general, all users will say Y or M.
>> +
>>  endmenu
>> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
>> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
>> @@ -42,6 +42,10 @@
>>  #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
>>  #endif
>>  
>> +#if !defined(CONFIG_SMP)
>> +static void smp_send_stop(void) {}
>> +#endif
>> +
>>  int ps3_get_firmware_version(union ps3_firmware_version *v)
>>  {
>>  	int result = lv1_get_version_info(&v->raw);
>> @@ -66,22 +70,35 @@ static void ps3_power_save(void)
>>  	lv1_pause(0);
>>  }
>>  
>> +static void ps3_restart(char *cmd)
>> +{
>> +	DBG("%s:%d cmd '%s'\n", __func__, __LINE__, cmd);
>> +
>> +	smp_send_stop();
>> +	ps3_sys_manager_restart(); /* never returns */
>> +}
>> +
>> +static void ps3_power_off(void)
>> +{
>> +	DBG("%s:%d\n", __func__, __LINE__);
>> +
>> +	smp_send_stop();
>> +	ps3_sys_manager_power_off(); /* never returns */
>> +}
> 
> What happens here when the sys manager stuff is built as a module ?

I don't support it as a module yet.  I'll change the Kconfig.

-Geoff
