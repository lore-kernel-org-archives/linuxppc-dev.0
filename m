Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2636D679EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 04:25:04 +1000 (EST)
Date: Mon, 6 Jun 2005 11:25:01 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Message-ID: <20050606182501.GA10988@gate.ebshome.net>
References: <20050604005106.GB12513@gate.ebshome.net>
	<42A49084.3070002@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A49084.3070002@am.sony.com>
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

On Mon, Jun 06, 2005 at 11:05:56AM -0700, Geoff Levand wrote:
> I was thinking to add a static variable in ppc4xx_pic.c to hold the 
> state, that way the arch pm code doesn't need to take care of it, 
> which will make suspend to disk easier since the value will be 
> saved in the system image.  I'm not sure which way to go.  Any 
> comments?

I don't have a problem with having static variables for PM in 
ppc4xx_pic.c. However, why only one for UIC0? What about UIC1? What 
about UIC2 (for 440GX) ?

Also, function, you just added, uses resume_bits are for UIC0, it's 
not clear from the function prototype why just UIC0. Shouldn't it be 
more generic?

Another note, code in ebony_pm_enter doesn't look very Ebony specific, 
maybe it's would be a good idea to move most of it into ibm440gp_sleep.

-- 
Eugene
