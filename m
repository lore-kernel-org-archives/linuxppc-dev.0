Date: Thu, 05 Apr 2001 12:09:05 +0100
Subject: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing, ibook,
	 Tumbler)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org,
	Paul Mackerras <paulus@linuxcare.com.au>
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010405110853.8CFD5DB9DD@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi List, Paul, Ben,

Here is the (long promised) rev 6 patch for dmasound:

-----

To build it you need to apply:

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3-final/dmasnd-2.4.3-fi
nal.diff.bz2

*and*

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3-final/dmasnd-2.4.3-to
-rev-6.diff.bz2

to a BK, Paulus (and prob. Benh) kernel later than 2.4.3-pre3.

----

binaries/SystemMaps/Modules:
ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3-final/

the binaries are identified by -i138 and -i138-blt-in for module and
built-in respectively.

Please include the "i138" in any bug report -it's my local BK cset
identifier for the patch.

the BK baseline for these was 1.137 (IIRC).

-----

what's been changed (and who might be interested ;-) :

 - fix bug: where sample rates higher than maximum were
   being reported as OK.
   (xine, Paulus)

 - fix bug: open() now returns -EBUSY as per OSS doc. when
   audio is in use - this is independent of O_NOBLOCK.
   [this is ifdef'd at the moment in case anyone thinks that
    OSS is wrong - and it *should* block ;-)]
   (MoL, Paulus)

 - fix bug: where SNDCTL_DSP_POST was blocking.
   (MoL, Paulus). [untested]

 - incorporate mixer changes from 2.2.x back-port.
 - take out passthru as a rec input (it isn't).
 - make Input Gain slider work the 'right way up'.
 - try to make the mixer sliders more logical - so now the
   input selectors are just two-state (>50% == ON) and the
   Input Gain slider handles the rest of the gain issues.
 - try to pick slider representations that most closely match
   the actual use - e.g. IGain for input gain...
   (anyone with Screamer or AWACS based machines)

 - first stab at over/under-run detection.
    (everyone - reported in /dev/sndstat)

 - minor cosmetic changes to IRQ identification.
   (everyone)
 - make use of i2c for mixer settings conditional on perch
   rather than cuda (some machines without perch have cuda).
    (machines with cuda but without perch ;-)

 - fix bug where TX stops when dbdma status comes up "DEAD"
   so far only reported on PowerComputing clones ... but.
   (PowerComputing clones - NOT TESTED - please let me know what happens).

 - put in AWACS/Screamer register write timeouts.
 - part way to partitioning the init() stuff
   (just tidying up + cater for move to separate files for each codec)

 - make more attempt not to write anything where we shouldn't for DACA
   (ibook owners).

 - first pass at 'tumbler' stuff (not support - just an attempt
   to allow the driver to load on new G4s).
   (New G4 owners - *don't* try the built in until you've tried the module..
   it may still lock up - UNTESTED - let me know what happens)

====
It's been tested on G3/Beige, Lombard & 9600/233 --- it might *break* on
anything else.... let me know.
=====

If this is OK, I will start to integrate the iBook i2c mixer control code...
and (as soon as I get *any* info on it) similar stuff for "tumbler" (new
G4s).  BUT... this is quite a big change...

next on the TODO: implement SNDCTL_DSP_GETXPTR and friends (xine, MoL).

I'm still keen to get hold of something burgundy-based so that I can make
similar changes to the burgundy mixer code.  Any offers?

happy testing,
ciao,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
