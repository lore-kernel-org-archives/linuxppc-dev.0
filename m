Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net [204.127.192.81])
	by ozlabs.org (Postfix) with ESMTP id CC519DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 12:26:23 +1100 (EST)
Message-ID: <45E77B1B.5060509@comcast.net>
Date: Thu, 01 Mar 2007 20:17:15 -0500
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [U-Boot-Users] RFA & Update: Using libfdt in u-boot for
	fdt	command
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070301234951.GC8177@mag.az.mvista.com>
In-Reply-To: <20070301234951.GC8177@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> On Thu, Mar 01, 2007 at 09:01:24AM -0500, Jerry Van Baren wrote:
>> Hi all,
>>
>> This is a Request for Advice.
> 
> Hi Jerry.
> 
> One minor thing.  I'd just want to remind you that we shouldn't stray
> too far from the OF interface.  The bootwrapper code sits on top of
> either the FDT access interface or the true OF DT access interface.  
> The closer we keep the two, the cleaner & easier the we can keep
> the bootwrapper code.
> 
> Mark

Hi Mark,

Understood, but that isn't really my battle.  David Gibson created the 
libfdt interface so any linux/bootwrapper changes are really his battle. 
  I'm working in u-boot land so linux/bootwrapper aren't in my problem 
domain - using libfdt in u-boot doesn't affect the bootwrapper code. 
Having said that, I'm hoping for shared code synergy, which would 
require the linux kernel to adopt libfdt as a replacement for 
flatdevtree.[ch].  David has also talked about using libfdt in the dtc 
suite, so there is potentially a three way synergy.

The flattened device tree which is passed from u-boot to linux is 
unchanged*, so the interface is the same at that level (to state the 
obvious).

David's libfdt is a potential replacement for flatdevtree.c.  I have 
pursued using libfdt rather than flatdevtree (in u-boot) because the 
interface is much cleaner (IMHO, and, I'm sure, IDHO).  Of course "much 
cleaner" is the fancy way of saying "not compatible." :-/  On the other 
hand, I looked at arch/powerpc/boot/of.c, ops.h, and flatdevtree_misc.c. 
  It looks like it would be relatively easy to redo flatdevtree_misc.c 
to glue to libfdt instead of flatdevtree.c (he says blithely).

* ...other than a backwards compatible version 16 -> 17 upgrade.

Best regards,
gvb
