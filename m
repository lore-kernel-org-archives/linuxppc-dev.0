Message-ID: <3C0E65A1.C860C834@chinook.com>
Date: Wed, 05 Dec 2001 13:21:21 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Ricardo Scop'" <scop@digitel.com.br>,
	linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, andy_lowe@mvista.com
Subject: Re: Kernel oops while routing
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E7F@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Could this be related to a problem we've been seeing on the 860T,
resulting in the following messages?

    NETDEV WATCHDOG: eth0: transmit timed out
    eth0: transmit timed out.
    Ring data dump: cur_tx c02f7130, dirty_tx c02f7130 cur_rx: c02f70d8
     tx: 16 buffers
      c02f7100: 1c00 004e 02a69442
      c02f7108: 1c00 004e 02a69542
      c02f7110: 1c00 004e 02a69642
      c02f7118: 1c00 004e 02a69742
      c02f7120: 1c00 004e 02a69842
      c02f7128: 1c00 004e 02a69942
      c02f7130: 1c00 0049 02a2e05e
      c02f7138: 1c00 0042 02a69c4e
      c02f7140: 1c04 0042 02aa2b3e
      c02f7148: 1c00 0036 02c8f6b2
      c02f7150: 1c00 0042 02aaaf2e
      c02f7158: 1c00 0042 02aa213e
      c02f7160: 1c00 0042 02aa223e
      c02f7168: 1c00 0042 02aa233e
      c02f7170: 1c00 0042 02a6914e
      c02f7178: 3c00 004e 02a69342
     rx: 32 buffers
      c02f7000: 8880 0040 002f6000
      [...]

This only seems to occur when receiving bulk data on a TCP connection -
we never saw it ftp-ing onto a system when we used an NFS filesystem,
but now that we're booting a ramdisk, an FTP get of more than 10-20k
results in a guaranteed transmitter timeout.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
