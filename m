Return-Path: <dtor@insightbb.com>
Received: from asav07.manage.insightbb.com (gateway.insightbb.com
	[74.128.0.19]) by ozlabs.org (Postfix) with ESMTP id 44F21679E0
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 06:19:46 +1000 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sound connector detection
Date: Sat, 1 Jul 2006 16:09:58 -0400
References: <1151671786.13412.6.camel@localhost>
In-Reply-To: <1151671786.13412.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607011609.59426.dtor@insightbb.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>,
	Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 30 June 2006 08:49, Johannes Berg wrote:
> Hi,
> 
> One Apple machines I have with snd-aoa the situation that the alsa
> driver can detect changes in in/output connector state ("is headphone
> plugged in" etc.) and currently surfaces it through a read-only alsa
> mixer element. That isn't really ideal since nothing is prepared to
> handle such events, hence I provide an additional control that allows an
> in-kernel toggle from speakers to headphone on headphone plug (and vice
> versa).
> 
> I'd really like to see this handled in userspace (additionally or
> possibly event instead), since there are complications especially with
> input (line-in) detection and user preferences of what should happen
> then. The number of cases can become large, especially when throwing in
> digital and combo connectors that aren't handled yet.
> 
> Now, is it appropriate to create an input device for the state of these
> things and add new constants like SW_LINEIN_INSERTED,
> SW_LINEOUT_INSERTED, SW_OPTICALOUT_INSERTED, SW_OPTICALIN_INSERTED and
> if so, how do I reflect the fact that on some machines optical and
> analog input/output is mutually exclusive, while on others it isn't?
> That would probably require another SW_COMBO_IN/OUT set...
> 
> Or should I simply stick with (a) read-only mixer control(s), and for
> the mutually exclusive case create a tristate (none, optical, analog)
> one? But SW_HEADPHONE_INSERT already exists, so we may want to do this
> identically on different machines.
> 

Hi Johannes,

I am not too happy with putting this kind of switches into input layer,
it should be reserved for "real" buttons, ones that user can explicitely
push or toggle (lid switch is on the edge here but it and sleep button
are used for similar purposes so it makes sense to have it in input layer
too). But "cable X connected" kind of events is too much [for input layer,
there could well be a separate layer for it]. If we go this way we'd have
to move cable detection code from network to input layer as well ;)

-- 
Dmitry
