Date: Tue, 29 Jan 2002 11:01:36 -0600 (CST)
Message-Id: <200201291701.g0TH1a318829@pacific.somerset.sps.mot.com>
From: Edward Swarthout <Ed.Swarthout@Motorola.com>
To: hobold@Informatik.Uni-Bremen.DE
Cc: christopher.murtagh@mcgill.ca, linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-reply-to: <8xn0yxyzez.fsf@s61.informatik.uni-bremen.de> (message from
	Holger Bettag on 29 Jan 2002 16:01:08 +0100)
Subject: Re: Support for new Dual G4 1 Gig machines?
References: <Pine.LNX.4.33.0201290949451.12240-100000@blues.wcg.mcgill.ca> <8xn0yxyzez.fsf@s61.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Holger wrote:
> 4 additional DBATs and 4 additional IBATs. I am not sure if those
> require initialization at early startup to not interfere with later
> operation.

They are not used until enabled in HID0.

See HID0[HIGH_BAT_EN] on page 49 of
  http://e-www.motorola.com/brdata/PDFDB/docs/MPC7450TS.pdf

An debug hint for early users:

The 7455 uses bit 8 for HIGH_BAT_EN.  On the 7400/7410, bit 8 is DOZE
Enable and on the 7450 it is ignored.  So, code ported from the 7400
which happens to set bit 8 will work fine on the 7450 but cause great
grief on the 7455.  Random translations whose side effects don't get
detected until much later tend to make system debug difficult...

Ed.Swarthout@Motorola.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
