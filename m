From: Benjamin Herrenschmidt <bh40@calva.net>
To: Henry Worth <haworth@ncal.verio.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CDDA playback on Pismo (and other newer models)
Date: Fri, 4 Aug 2000 14:57:50 +0200
Message-Id: <20000804125750.16864@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Using the ATAPI CD drivers there are underruns with significant
>dropouts every couple of seconds. Various hdparms and cdparanoia
>parms were tried with no significant change. These include various
>transfers modes and cdparanoia's buffer (-n) and speed (-S)
>parms and various data formats. Piping cdparanoia out to /dev/null
>showed data rates of 46 sectors/sec at -S1, 65sps at -S8, and
>133sps at -S12 and above (also the default and no significant
>changes with different transfer modes and -n values). At the higher
>speeds (>-S11) there is a high-level of continuous head-seek noise,
>suggesting a lot of overruns and reseeks on the CD i/f side.
>
>Rebuilding the kernel to use SCSI generic devices with IDE SCSI
>emulation produced much better, even usable, results. At startup
>there are still a couple of dropouts in the first few seconds,
>but after that the playback is clean across multiple tracks (even
>with a concurrent kernel compile). Piping cdparanoia to /dev/null
>shows data rates of 187sectors/sec at all -S settings (and default).
>From the the drive's spin-up sounds it seems to always be in
>high-speed mode, but unlike the ATAPI driver, there is little
>head movement noise.

I think the problem is more with cdparanoia. I think it's more or less
synchronous, it doesn't have a thread that collects datas while another
outputs sounds. I've looked at cdparanoia sources some time ago, and I
think and intermediate step of buffering is necessary.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
