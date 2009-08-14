Return-Path: <Paul.Gortmaker@windriver.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BCE76B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 00:43:42 +1000 (EST)
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 53D76DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 00:43:41 +1000 (EST)
Message-ID: <4A857814.5080209@windriver.com>
Date: Fri, 14 Aug 2009 10:43:32 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] sbc8560: Fix warm reboot with board specific reset
	function
References: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
	<B86B0653-311C-49EA-B27F-F5AB98D49401@kernel.crashing.org>
In-Reply-To: <B86B0653-311C-49EA-B27F-F5AB98D49401@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Aug 13, 2009, at 6:06 PM, Paul Gortmaker wrote:
> 
>> From: Liang Li <Liang.Li@windriver.com>
>>
>> The existing fsl_rstcr_restart function fails to reset the sbc8560
>> board. This implements a board specific reset function that uses
>> the RCR(Reset Control Register) of the board's EPLD to do a reset.
>>
>> Signed-off-by: Liang Li <Liang.Li@windriver.com>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>> arch/powerpc/platforms/85xx/sbc8560.c |   39 
>> ++++++++++++++++++++++++++++++++-
>> 1 files changed, 38 insertions(+), 1 deletions(-)
> 
> The reason it didn't was that feature doesnt exist on the mpc8560 :)

I could see how that might have an impact on the
functionality.... :-)

So, what should the guts block of the 8560 dts look
like? It currently has the standard:

------------
global-utilities@e0000 {
   compatible = "fsl,mpc8560-guts";
   reg = <0xe0000 0x1000>;
   fsl,has-rstcr;
};
------------

MPC8560 has a guts block, but saying "has-rstcr", as
you've pointed out, is a bit of a lie. If we remove that
tag, then we'll trip the:

 printk(KERN_INFO "rstcr compatible register does not exist!\n");

which isn't the end of the world, but at the moment it
reads more like an error message, vs. an informative one.

Paul.

> 
> - k
