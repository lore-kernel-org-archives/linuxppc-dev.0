Return-Path: <bbrv@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BBA7DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jan 2007 20:37:52 +1100 (EST)
In-Reply-To: <45A0610E.60307@246tNt.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A0610E.60307@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44901FD6-0F07-453A-934A-FF95EA1B8906@genesi-usa.com>
From: Raquel Velasco and Bill Buck <bbrv@genesi-usa.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
Date: Sun, 7 Jan 2007 03:11:25 -0600
To: Sylvain Munaut <tnt@246tNt.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
	Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Syvain, Ben, and the others here on this list...

In the next 45-60 days we will offer new firmware for the EFIKA (and  
the Pegasos/ODW).  We will define a new hardware specification  
outside of CHRP.  In the meanwhile and afterwards, feel free to  
proceed as you determine best.  We appreciate the support we have  
received in the past and the effort made more recently on the EFIKA.

The long term objective for Genesi is to provide a low cost, low  
power, highly reliable computing platform that can be flexibly  
applied to many uses.  We hope to be selling the EFIKA at $99 by  
April (and sooner if possible).  The 5200B is to be followed by  
another SoC with integrated graphic support at the same price (for  
the SoC).  The new firmware will be inexorably linked to this new SoC  
in form and function.  The EFIKA is a development platform that  
targets the system we will offer with the new SoC.  We expect to be  
shipping the next version of the EFIKA before the end of 2007.  The  
first diagram shown in the link that follows (the second image is  
what we hope for after that):

http://bbrv.blogspot.com/2006/10/wanting-what-you-have.html

Thanks again.  Happy New Year. :)

Best regards,
R&B


On Jan 6, 2007, at 8:55 PM, Sylvain Munaut wrote:

>
>>> What if NetBSD, FreeBSD, QNX and WindRiver disagree with you guys?
> Note that the "compatible" modification we ask could simply be to add
> the one
> we require at the start of your compatible list, so linux will work  
> and
> the os using
> the efika original will work as well.
>
>>> Specifically for the "sound" and "ac97" discrepency, the "sound"  
>>> device
>>> type has some special implications for Open Firmware firmwares. It's
>>> set to ac97 as it is NOT an OF or CHRP standard "sound" node and  
>>> should
>>> NOT be found as such in my personal opinion.
> This "sound" <> "ac97" thing is not fixed in the patch I posted  
> recently nor
> in the nvramrc I sent to gentoo before that. The only visible thing  
> was a
> a small comment buried in a very experimental driver.
> As soon as nicolas told me "sound" was the standard, I said OK so  
> be it.
>
> But for example the "memory" type you give to the SRAM node is imho
> wrong. Because memory seems to be the standard type for "real" memory,
> the one that's gonna be used for the system ...
>
>> There are two issues here:
> I'd say you can even split a little more :
>
>  * Compatible / Type of nodes :
>    We need a naming schema that's coherent across nodes and will  
> allow to
>    support coherently different boards. Your naming scheme just  
> doesn't
>    provide that. The one proposed by Grant does. Now it's possible  
> you can
>    find even better and we're open to suggestion.
>
>  * Missing bits :
>   - The interrupts property of the ac97 node are just not there. This
> interrupt
>      exist, it's hw and you can't just decide the driver can do  
> without
> it ...
>
>  * Bugs : I see three,
>   -  The one dwmv2 mentionned
>   -  I noticed the compatible properties had double \0 at the end  
> instead
>      of single ones.
>   -  Incorrect init of the PSC2 for AC97 and in the tree since the  
> "gpio"
>      node is not present, the address for port config is not found  
> in the
>      device tree. The current work around is a ugly hardcoded stuff in
>      the driver itself that will never be merged upstream.
>
>
> Regards,
>
>      Sylvain
>
>
> PS: In the end, a long nvramrc will do the trick ... so I don't care
> much for me,
> I'll always know what I need to put in it.
>
