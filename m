From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
Date: Wed, 2 Aug 2000 23:15:35 +0200
Message-Id: <20000802211535.26758@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.10.10008021351010.427-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10008021351010.427-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>BTW, ADB code should be in driverd/adb/, cfr. all other bus types. It
>should be
>protected using CONFIG_ADB, which should be configurable depending on
>either of
>CONFIG_MAC, CONFIG_PMAC, CONFIG_CHRP or CONFIG_NEXT in
>arch/{m68k,ppc}/config.in. That way you can leave out ADB support if you
don't
>need it (e.g. for server PowerMac boxes, and for CHRP boxes that use the PS/2
>port only).

I don't think there's real need anymore for an adb directory. The only
file in it would be adb.c. The mouse and kbd drivers are moving to input,
the controller drivers (Cuda,PMU) do not only ADB but all sort of other
machine admin tasks (like power control, I2C, ...) and so are needed even
whithout ADB support as part of "PowerMac" support. Cuda can be shared
with m68k, maybe PMU too, so drivers/macintosh is not a so bad place for it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
