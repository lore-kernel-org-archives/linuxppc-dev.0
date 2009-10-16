Return-Path: <Kari.Davidsson@marel.com>
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 3BE48B7BC0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 00:53:48 +1100 (EST)
Message-ID: <4AD87AE9.7050505@marel.com>
Date: Fri, 16 Oct 2009 13:53:45 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121 CAN and USB
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
	<4AD6FD4E.9060507@marel.com> <4AD70585.40302@gmail.com>
	<4AD70927.3030401@marel.com>
	<20091015183039.A577EECA6BE@gemini.denx.de>
In-Reply-To: <20091015183039.A577EECA6BE@gemini.denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paul.gibson2074@gmail.com" <paul.gibson2074@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Wolfgang Denk wrote:
> Dear =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?=,
> 
> In message <4AD70927.3030401@marel.com> you wrote:
>> The kernel from the BSP on Freescale site is crashing on the CAN in my case
>>  (might be a hardware bug).
> 
> I don;t think so. There are some problems in this code, for example
> the clocks seem to be wrong. Not toi menthin that the whole code is
> hoplessly old and without chance of ever being merged into mainline.

Indeed. I had to disable the follwing clock stuff to prevent crashing. I am
running on Rev 3 chip.

diff --git a/drivers/net/can/mscan/mpc52xx_can.c b/drivers/net/can/mscan/mpc52xx_can.c
index e1d78b9..55def57 100644
--- a/drivers/net/can/mscan/mpc52xx_can.c
+++ b/drivers/net/can/mscan/mpc52xx_can.c
@@ -104,8 +104,8 @@ static int __devinit mpc52xx_can_probe(struct platform_device *pdev)
                 port_clk = clk_get(NULL, clk_name);

                 /* update clock rate for mpc5121e rev2 chip */
-               if (port_clk)
-                       pdata->clock_frq = clk_get_rate(port_clk);
+//             if (port_clk)
+//                     pdata->clock_frq = clk_get_rate(port_clk);

                 /* enable clock for mscan module */
                 clk_enable(mscan_clk);

> 
>> I could not find the source for the kernel in the BSP or on the freescale site.
> 
> Extracting just the sources from LTIB (without actually building all
> of it) is indeed not exactly easy.
> 
>> I had not looked at http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/ltib-mpc5121ads-20090602
> 
> Be careful. There are several branches that are intended for reference
> only, or reflect work in progress. These are usually not intended for
> use real use in a project:
> 
> The "ltib-mpc5121ads-20090602" branch reflects the exact state of the
> kernel contained in the LTIB with this name (dated July 2009, despite
> the name; based at 2.6.24.6, i. e. 7+ kernel versions behind).

Yes this I found it odd that the mpc5121 work is so far behind.
We have two other mpc5200 based boards that I am running with 2.6.29.
They are running well.

> 
> The "mpc512x" branch contains a much smaller subset of drivers, but is
> based on a more recent kernel tree (2.6.31-rc5) and is the base of our
> (currently dozing) attempts to push this code into mainline.
> 
>> I am now in the progress of cloning the linux-mpc512x git from denx and building from it.
>> Hopefully that will help me.
> 
> Do not do this. This old repository was intended for co-operation
> with John Rigby, when he was still working for Freescale. It is a
> dead end and totally unsupported. Guess I should remove it. Indeed.
> Removed now. Sorry for the confusion.

Already done it and I got it to compile but as you hint I am having other problems.
Serial ports and ethernet works though :)

> 
> Best regards,
> 
> Wolfgang Denk
> 

rg
kd
