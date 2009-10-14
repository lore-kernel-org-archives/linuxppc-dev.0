Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B82BB7043
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 08:14:58 +1100 (EST)
Message-ID: <4AD63F48.8030301@freescale.com>
Date: Wed, 14 Oct 2009 16:14:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>
	<OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
	<4AD62516.6090301@freescale.com>
	<OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
	<4AD63301.6090307@freescale.com>
	<OF459A0F65.D3201748-ONC125764F.00738958-C125764F.00744CF0@transmode.se>
In-Reply-To: <OF459A0F65.D3201748-ONC125764F.00738958-C125764F.00744CF0@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
>> With that, I don't see the hard lockup, but things get stuck during
> 
> You needed both to loose the hard lockup? I would think
> it should be enough to revert the "various copy routines" stuff?

No, but when I just reverted the patch and didn't change the TLB error handler, 
I got some other weirdness (assertion failure in some userspace program).  It 
may have been coincidental, though.

>> I think there's something else going on in the 2.6 8xx code that needs
>> to be fixed before we can tell what the impact of these patches is.
>> I'll look into it.
> 
> Great because I am really out of ideas. Perhaps back down to 2.6.30 and test
> from there?

I think the last working version was a little older than that -- and it's quite 
possible that there was underlying badness even earlier that just recently got 
exposed.  I think I want to just debug it and find out what's really going on.

-Scott
