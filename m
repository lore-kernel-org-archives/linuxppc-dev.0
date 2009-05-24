Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A5DCDDFE7
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 05:15:01 +1000 (EST)
Date: Sun, 24 May 2009 20:14:49 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20090524191448.GD4525@sirena.org.uk>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231257.17919.4483.stgit@terra>
	<20090524111118.GC4933@sirena.org.uk>
	<9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 1/9] Register the wm9712 DAIs on module
	load
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 24, 2009 at 11:28:15AM -0400, Jon Smirl wrote:
> On Sun, May 24, 2009 at 7:11 AM, Mark Brown

> > Why do you wish to do this - ASoC does not require or use DAI registration
> > for AC97 CODECs?

> Then what is wrong with my binding code? If I take out the
> registration my bind fails.

It appears that the problem here is that your CPU DAI isn't marked as an
ac97 DAI by having ac97_control set so the core expects the codec to
instantiate prior to the card.  Setting ac97_control ought to fix the
problem, but obviously I can't test.

When looking at problems like this it's worth taking a step back and
looking at why the existing code is the way that it is when considering
if you've found the right fix.  In this case AC97 is fairly widely used
and there are also a number of WM9712 users but neither WM9712 or any of
the other AC97 CODEC drivers ever register their DAIs.  That should be
an indication that either things probably should work without a change
to existing code or things are completely broken and something wider
than a change in a single driver is required in order to get things
working.
