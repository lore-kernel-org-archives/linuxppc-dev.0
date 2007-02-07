Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53FCDDDDE4
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 14:53:36 +1100 (EST)
Message-ID: <45C94D39.8000305@am.sony.com>
Date: Tue, 06 Feb 2007 19:53:29 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 3/3] PS3: System manager support
References: <45C8FFF7.7090805@am.sony.com>	
	<1170806435.4640.3.camel@concordia.ozlabs.ibm.com>	
	<45C92856.4080107@am.sony.com>
	<1170819694.4640.5.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1170819694.4640.5.camel@concordia.ozlabs.ibm.com>
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
>> >> +static void ps3_restart(char *cmd)
>> >> +{
>> >> +	DBG("%s:%d cmd '%s'\n", __func__, __LINE__, cmd);
>> >> +
>> >> +	smp_send_stop();
>> >> +	ps3_sys_manager_restart(); /* never returns */
>> >> +}
>> >> +
>> >> +static void ps3_power_off(void)
>> >> +{
>> >> +	DBG("%s:%d\n", __func__, __LINE__);
>> >> +
>> >> +	smp_send_stop();
>> >> +	ps3_sys_manager_power_off(); /* never returns */
>> >> +}
>> > 
>> > What happens here when the sys manager stuff is built as a module ?
>> 
>> I don't support it as a module yet.  I'll change the Kconfig.
> 
> Yeah OK.
> 
> I don't think it really makes sense for it to be a module. 

Well, I was thinking that for multi-platform binaries it would only be
loaded when running on ps3.  I don't need to support unloading though,
since it is needed for proper shutdown.  Anyway, for now I'll just make
it a static module.

-Geoff
