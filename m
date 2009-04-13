Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7DAE2DDF93
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 03:34:16 +1000 (EST)
Message-ID: <49E3720C.8060008@mvista.com>
Date: Mon, 13 Apr 2009 10:10:36 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Jeff Haran <jharan@Brocade.COM>
Subject: Re: bug in drivers/edac/mpc85xx_edac.c:mpc85xx_mc_check() ?
References: <57AC2FA1761300418C7AB8F3EA493C9702C5F200@HQ-EXCH-5.corp.brocade.com>
	<20090410144715.0fa5939e.akpm@linux-foundation.org>
In-Reply-To: <20090410144715.0fa5939e.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff, you are correct. I will submit a patch to correct that.

Andrew Morton wrote:
> (cc's added)
> 
> On Wed, 8 Apr 2009 14:57:42 -0700
> "Jeff Haran" <jharan@Brocade.COM> wrote:
> 
>> Hi,
>>
>> Recent versions of this function start off with:
>>
>> static void mpc85xx_mc_check(struct mem_ctl_info *mci)
>> {
>>     struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
>>     ...
>>
>>     err_detect = in_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DETECT);
>>     if (err_detect)
>>         return;
>>
>>     ...
>> }
>>
>> My reading of the Freescale 8548E Manual leads me to conclude that the
>> Memory Error Detect register (ERR_DETECT) will have various bits set if
>> the memory controller has detected an error since the last time it was
>> cleared. If no memory error has occurred, the register will contain 0.
>>
>> Perhaps I am missing something very basic, but it seem to me that the
>> above "if" should be:
>>
>>     if (!err_detect)
>>         return;
>>
>> as the existing code would seem to read "if any errors have occurred,
>> ignore them", though perhaps testing has demonstrated that the Freescale
>> manual is in error.
>>
>> Please include this email address in responses as I do not subscribe.
>>
>> Thanks,
>>
>> Jeff Haran
>> Brocade
> 


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
