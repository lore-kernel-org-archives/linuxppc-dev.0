Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 5B557B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 19:33:44 +1100 (EST)
Received: by pxi7 with SMTP id 7so1163111pxi.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 00:33:43 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/6] Fixups to MPC5200 ASoC drivers
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com
Date: Sat, 07 Nov 2009 01:33:40 -0700
Message-ID: <20091107081631.18908.82921.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi everyone,

Jon, as we talked about earlier today, I've spent some time working
on the MPC5200 AC97 driver to try and get rid of some of the nagging
bugs.  The two big changes that I ended up making were to remove the
tracking of appl_ptr (and all the race conditions that went with it),
and to fix the handling of AC97 slot enables/disables so that a
stream can be stopped and started again without going through the
hw_params() step.

I know that you had the appl_ptr tracking in to try and solve the
problem of audible noise at the end of playback.  After discussing
the data flow model on #alsa-soc this morning, I learned that
the driver is really supposed to be free-running, and the ALSA layer
is supposed to be able to keep up.  It is also responsible to ensure
that buffer is filled with silence at the end of playback to eliminate
noise before the trigger can properly turn everything off.  Only a
couple of other drivers use appl_ptr, so I'm pretty sure this driver
shouldn't be doing it either.

Instead, from a recommendation this morning, I added a 'fudge' factor
to the value reported by the .pointer() callback of 1/4 the period
size.  At first I thought this helped, but after more testing I find
that the driver seems to work correctly with aplay both with and
without the fudge factor applied.

However, I was able to reproduce the noise problem when using aplay
if I have DEBUG #defined at the top of the mpc5200_dma.c file with
debug console logs being spit out the serial port.  In that situation,
the STOP trigger calls printk(), and a stale sample can be heard at
the end of playback.  However, I believe this is a bug with the serial
console driver (in that it disables IRQs for a long time) causing
unbounded latencies, so the trigger doesn't get processed fast enough.
It doesn't help that aplay doesn't flush the buffers with silence
before triggering STOP.  Other programs (like gstreamer) do seem to
flush out stale data before stopping the stream.  I'm sure someone
will correct me if I'm making some bad assumptions here.

So, please test.  Let me know if these work or not.  I've don't know
if the last patch (Add fudge factor...) is needed or not.

Cheers,
g.

---

Grant Likely (6):
      ASoC/mpc5200: Add fudge factor to value reported by .pointer()
      ASoC/mpc5200: fix enable/disable of AC97 slots
      ASoC/mpc5200: add to_psc_dma_stream() helper
      ASoC/mpc5200: Improve printk debug output for trigger
      ASoC/mpc5200: get rid of the appl_ptr tracking nonsense
      ASoC/mpc5200: Track DMA position by period number instead of bytes


 sound/soc/fsl/mpc5200_dma.c      |   98 ++++++++++----------------------------
 sound/soc/fsl/mpc5200_dma.h      |   24 ++++++---
 sound/soc/fsl/mpc5200_psc_ac97.c |   39 ++++++++-------
 3 files changed, 63 insertions(+), 98 deletions(-)

-- 
Signature
