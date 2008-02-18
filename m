Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 72417DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 05:28:32 +1100 (EST)
Message-ID: <47B9CE4D.1020303@pikatech.com>
Date: Mon, 18 Feb 2008 13:28:29 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: arch_initcall time
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I need to call i2c_register_board_info for the new i2c style ad7414 
driver. This needs to be called at arch initcall time. Currently I just 
do this:

static int __init warp_arch_init(void)
{
	i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
	return 0;
}
arch_initcall(warp_arch_init);


It works, but is there a "better" place to put this? None of the other 
powerpc platforms make this call and I want to get it right, so that 
others don't blindly follow my example ;)

I kept the name vague rather than specific in case more drivers need to 
be setup this way in the future.

Cheers,
   Sean
