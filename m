Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5418E67A5C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 11:08:53 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060517215412.GA4504@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost>
Content-Type: text/plain
Date: Thu, 18 May 2006 11:08:42 +1000
Message-Id: <1147914523.10703.73.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> /var/log/boot.2.gz:Wed May 17 16:14:04 2006: ^[[9;0]^[[14;0]Setting up
> ALSA...warning: 'alsactl restore' failed with error message 'alsactl:
> set_control:894: warning: name mismatch (Line-out Switch/Headphone
> Switch) for control #2
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:896:
> warning: index mismatch (0/0) for control #2
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:894:
> warning: name mismatch (Master Playback Volume/Capture Source) for
> control #3
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:896:
> warning: index mismatch (0/0) for control #3

That's Alsa being stupid. It stores the values of the control by number
and screws up when the driver is updated and adds/removes controls.
Storing the settings with the new driver should cure that
