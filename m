Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
Date: Thu, 21 May 2009 14:52:32 -0400
Message-ID: <9e4733910905211152x6ded5c9tadc085bc4bc800e3@mail.gmail.com>
Subject: Audio and mpc5200 bestcomm tasks
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ALSA really wants to dynamically know the address of the current DMA
location while transfers are active. This is an important piece of
implementing pause/resume. Pause doesn't work too well if there is 2s
of music already queued. The work around is to know the sample rate
and use the jiffy count to estimate how far into the buffer DMA has
progressed. But that's not as accurate as just asking the DMA
hardware.

I poked around in the SRAM data and couldn't find the address. Is it
there or can the Bestcomm tasks be modified to leave it somewhere
visible?

-- 
Jon Smirl
jonsmirl@gmail.com
