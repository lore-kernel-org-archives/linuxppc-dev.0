Return-Path: <tnt@246tNt.com>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.3.51]) by ozlabs.org (Postfix) with ESMTP id 0616567A88
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 08:33:24 +1100 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j0QLXDwx007945
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 22:33:13 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41F80CA2.2080603@246tNt.com>
Date: Wed, 26 Jan 2005 22:33:22 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>	<1106441036.5387.41.camel@gaston>
	<1106529935.5587.9.camel@gaston>
In-Reply-To: <1106529935.5587.9.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
>
>  
>
>>I know about this problem, I'm working on a proper fix. Thanks for your
>>report.
>>    
>>
>
>Can you send me the PVR value for both of these CPUs
>(cat /proc/cpuinfo) ? I can't find right now why they would lock up
>unless the default idle loop is _not_ run properly, that is for some
>reason, NAP or DOZE mode end up not beeing enabled. Can you send me
>your .config as well ?
>  
>
Note that when CONFIG_BDI_SWITCH is set, they both end up disabled
because nap & doze seems to perturb the BDI on some cores.

So there is a problem in that case ....

>Finally, try that patch and tell me if it makes a difference. 
>
Yup
 - Without it hangs (not really, it's still half running but serial 
output is stuck
due to no interrupts)
 - With it it works


    Sylvain
