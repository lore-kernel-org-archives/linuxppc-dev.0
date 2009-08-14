Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 21023B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 00:54:06 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FACDDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 00:54:04 +1000 (EST)
Message-Id: <B7866DD3-5047-4162-801F-FC89ADE1A17B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <4A857814.5080209@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] sbc8560: Fix warm reboot with board specific reset
	function
Date: Fri, 14 Aug 2009 09:53:59 -0500
References: <1250204775-5001-1-git-send-email-paul.gortmaker@windriver.com>
	<B86B0653-311C-49EA-B27F-F5AB98D49401@kernel.crashing.org>
	<4A857814.5080209@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 14, 2009, at 9:43 AM, Paul Gortmaker wrote:

> Kumar Gala wrote:
>> On Aug 13, 2009, at 6:06 PM, Paul Gortmaker wrote:
>>> From: Liang Li <Liang.Li@windriver.com>
>>>
>>> The existing fsl_rstcr_restart function fails to reset the sbc8560
>>> board. This implements a board specific reset function that uses
>>> the RCR(Reset Control Register) of the board's EPLD to do a reset.
>>>
>>> Signed-off-by: Liang Li <Liang.Li@windriver.com>
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> ---
>>> arch/powerpc/platforms/85xx/sbc8560.c |   39 ++++++++++++++++++++++ 
>>> ++++++++++-
>>> 1 files changed, 38 insertions(+), 1 deletions(-)
>> The reason it didn't was that feature doesnt exist on the mpc8560 :)
>
> I could see how that might have an impact on the
> functionality.... :-)
>
> So, what should the guts block of the 8560 dts look
> like? It currently has the standard:
>
> ------------
> global-utilities@e0000 {
>  compatible = "fsl,mpc8560-guts";
>  reg = <0xe0000 0x1000>;
>  fsl,has-rstcr;
> };
> ------------
>
> MPC8560 has a guts block, but saying "has-rstcr", as
> you've pointed out, is a bit of a lie. If we remove that
> tag, then we'll trip the:
>
> printk(KERN_INFO "rstcr compatible register does not exist!\n");
>
> which isn't the end of the world, but at the moment it
> reads more like an error message, vs. an informative one.

we should probably remove 'fsl,has-rstcr' from the .dts since that's  
just wrong.  I've got no issue w/either removing the warning or  
changing its wording.

- k
