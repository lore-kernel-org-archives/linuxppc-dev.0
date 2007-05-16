Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA4DDDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 02:34:53 +1000 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4GGYew5010026
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 May 2007 18:34:41 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <464B329E.8030600@246tNt.com>
Date: Wed, 16 May 2007 18:34:38 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
	<200705160911.55867.david-b@pacbell.net>
In-Reply-To: <200705160911.55867.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Dragos Carp <dragos.carp@toptica.com>,
	Domen Puncer <domen@coderock.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Wednesday 16 May 2007, Sylvain Munaut wrote:
>   
>> Well, this comment is not about the patch but about the driver it self,
>> I didn't see it before today.
>>     
>
> It merged earlier in the 2.6.22 cycle.  If you don't have criticisms
> about the patch itself, I'll forward it for merging after I get at
> least an ack from Dragos.
>   
Yes, I saw when looking at the spi-devl archive. Would have been nice if the
author though of cc-ing the ppc-embedded list ;)

The patch looks ok to me (and needed actually since as Domen pointed
out, 52xx
has been replaced by 5200 in the device tree).
And cell-index has been added to know the psc id without dirty tricks.

>>  - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
>> resource of the platform_device. This macro is just there for early
>> console stuff.
>>     
>
> That PPC_MERGE stuff does look messy.
>   
Yes, trying to support both in a driver is really not pretty.
Once we can finally get rid of it I'll submit a patch to clear that out.

>>  - You do read/write/modify operation on CDM shared register
>> (clk_enables) from a driver, you should have added something in common
>> 52xx code to do theses with proper locking.
>>  - You can get f_system from the device tree instead of just assuming
>> it's 512 MHz. It probably need to be done the same way it's done to find
>> ipb_freq.
>>  - Would have been nice to be able to somehow configure MCLK rather than
>> #define it
>>     
>
> Best to use <linux/clk.h> for all of those, but it seems powerpc/ppc
> don't support those interfaces yet ... is there maybe a plan for
> resolving that issue?
>   
Mmm, I wasn't aware of that interface, I'll look into that. Thanks.


    Sylvain
