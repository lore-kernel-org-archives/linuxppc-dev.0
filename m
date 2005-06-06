Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD6B8679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 04:59:37 +1000 (EST)
Message-ID: <42A49D13.6020605@am.sony.com>
Date: Mon, 06 Jun 2005 11:59:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <20050604005106.GB12513@gate.ebshome.net>
	<42A49084.3070002@am.sony.com>
	<20050606182501.GA10988@gate.ebshome.net>
In-Reply-To: <20050606182501.GA10988@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Mon, Jun 06, 2005 at 11:05:56AM -0700, Geoff Levand wrote:
> 
>>I was thinking to add a static variable in ppc4xx_pic.c to hold the 
>>state, that way the arch pm code doesn't need to take care of it, 
>>which will make suspend to disk easier since the value will be 
>>saved in the system image.  I'm not sure which way to go.  Any 
>>comments?
> 
> 
> I don't have a problem with having static variables for PM in 
> ppc4xx_pic.c. However, why only one for UIC0? What about UIC1? What 
> about UIC2 (for 440GX) ?
> 
> Also, function, you just added, uses resume_bits are for UIC0, it's 
> not clear from the function prototype why just UIC0. Shouldn't it be 
> more generic?

Well, I guess I was originally only interested in waking up from 
things connected to UIC0...  I'll look at the other interrupts. 

> 
> Another note, code in ebony_pm_enter doesn't look very Ebony specific, 
> maybe it's would be a good idea to move most of it into ibm440gp_sleep.
> 

My thoughts also, but I'll wait until I see BenH's new design before 
deciding what to do.

-Geoff
