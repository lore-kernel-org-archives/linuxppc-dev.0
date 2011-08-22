Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FDE5B6F64
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 02:01:12 +1000 (EST)
Message-ID: <4E527C91.6080009@freescale.com>
Date: Mon, 22 Aug 2011 10:58:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <dedekind1@gmail.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>		<4E4D452C.7050805@parrot.com>
	<4E4DD661.5080006@freescale.com>	 <4E4E2571.20409@parrot.com>
	<4E4EA70B.9050203@freescale.com> <1314010719.2644.114.camel@sauron>
In-Reply-To: <1314010719.2644.114.camel@sauron>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	LiuShuo <b35362@freescale.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Matthieu CASTET <matthieu.castet@parrot.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2011 05:58 AM, Artem Bityutskiy wrote:
> On Fri, 2011-08-19 at 13:10 -0500, Scott Wood wrote:
>> On 08/19/2011 03:57 AM, Matthieu CASTET wrote:
>>> How the bad block marker are handled with this remapping ?
>>
>> It has to be migrated prior to first use (this needs to be documented,
>> and ideally a U-Boot command provided do do this), or else special
>> handling would be needed when building the BBT.  The only way around
>> this would be to do ECC in software, and do the buffering needed to let
>> MTD treat it as a 4K chip.
> 
> It really feels like a special hack which would better not go to
> mainline - am I the only one with such feeling? If yes, probably I am
> wrong...

While the implementation is (of necessity) a hack, the feature is
something that multiple people have been asking for (it's not a special
case for a specific user).  They say 2K chips are getting more difficult
to obtain.  It doesn't change anything for people using 512/2K chips,
and (in its current form) doesn't introduce significant complexity to
the driver.  I'm not sure how maintaining it out of tree would be a
better situation for anyone.

-Scott
