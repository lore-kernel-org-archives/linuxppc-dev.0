Message-ID: <5725AF6EE9FAD51195DC009027E377020B6561BF@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: "'nebuphilips@eudoramail.com'" <nebuphilips@eudoramail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: 64-bit Data Flash Access Problem [MPC8245]
Date: Wed, 24 Sep 2003 11:07:39 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Augustine Nebu Philips [mailto:nebuphilips@eudoramail.com]
>...
> I have a set of 8 1GB data flash chips (Samsung) on an MPC8245 Ref.
> Board. These are on a 64-bit bus-mode.
>
> -------DBUS_SIZ[0-1]:DBUS_SIZ[2] = 110b -------
>
> All 8 chips are selected by a single chip select (RCS1). Trying a
> 32-bit read from the Data Address Location after giving the Command
> to Access the flash IDs, only 4 flashes on a common byte lane seem to
> be responding. 32-bit writes appear only on the DH[0-31] and not on
> DL[0-31].

  Is this under Linux, or something else?

> I am not very clear as to:
>
> (a) How do we perform writes to send out data out on all 64-bits of
> the bus..?

   stfd is the only way to do that.  You'll need floating
   point enabled on the code generation.  stfd works regardless
   of general FP emulation support, but if code is interrupted
   and the FPRs are not restored, it breaks.

> (b) How would we ideally access 64-bit data through 32-bit reads..?

  For reads?  Any way you want.  The 8245 will gather the
  data for you.  You could load 64 bits with lfd, but
  transferring data from the FPRs to the GPRS would lose
  any advantage over just doing two 32-bit reads.

> (c) Or must we *have* 64- bit read/write instructions..?

  Since there is a common WE* line, you must write all
  the flash commands at the same time.  Attempting to
  write two 32-bit command sets (i.e UNLOCK to flashaddr[0]
  and flashaddr[4]) would result in a second write of the CFI
  pattern, resetting it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
