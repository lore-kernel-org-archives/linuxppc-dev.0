Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BFE167A7C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 11:02:15 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <41F0449C.5020603@mvista.com>
References: <41EC29A8.1040703@mvista.com> <1106259956.18397.10.camel@gaston>
	<41F0449C.5020603@mvista.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 11:01:12 +1100
Message-Id: <1106265672.5387.14.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-20 at 16:54 -0700, Mark A. Greer wrote:

> Choosing a) give you more flexibility within PPC but is PPC only; 
> choosing b) is generic but assumes its the only rtc chip that will be 
> used by whatever kernel binary its put in.
> 
> I chose b) and to reuse the genrtc code.  In a sane world, reusing code 
> is considered a good thing...
> 
> Its obvious that you and Tom prefer a).  That's fine but if I switch to 
> a), I know the first comment I'll get when I post the driver to lmkl 
> will be, "Why would you make this ppc-specific when you could have made 
> it generic?"  Will you and Tom then defend that decision for me?
> 
> Also, this is not board-specific as you and Tom have tried to suggest.  
> Assuming I change the #ifdef in rtc.h to remove the option as I think 
> Tom and I are agreeing upon, you select the i2c algo/adapter, the 
> i2c/rtc client and its there.  Where are the "gross hacks for every board"?

Because it makes things like CONFIG_PPC_MULTIPLATFORM impossible, which
means you end up with a CONFIG_* mess.

I consider that more important than re-using code.

In any case, as I wrote, the proper solution is to update genrtc to
define rtc_ops so that you get both a) and b), it shouldn't be hard to
update the archs using it.

Ben.
