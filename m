Date: Thu, 19 Jun 2003 23:53:41 -0600 (MDT)
From: Terry Greeniaus <tgree@phys.ualberta.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo upgraded to 750fx not detected correctly
In-Reply-To: <200306200459.XAA31217@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.10306192341590.5204-100000@pneuma.phys.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Jun 2003, Chris Studholme wrote:

> On Fri, 13 Jun 2003, Terry Greeniaus wrote:
>
> > The PowerLogix 900 MHz bluechips are 750FX CPUs, however they have been
> > strapped so that the PVR reports itself as 0x0008nnnn instead of
> > 0x7000nnnn, so that Apple's OpenFirmware can better support them (in
> > particular, to automatically enable the L2 cache).  The correct way (on
> > these boards, anyhow) to determine if this is a 750FX is by writing to
> > the HID1 register and seeing if it changed.  I have a code snippet to do
> > this if anyone wants it, although it isn't LinuxPPC-specific.  This is
> > backwards-compatible with normal 750 CPUs, they don't take an exception
> > if you try to write to the HID1 register.
>
> I would like to see the code snippet.  Do you know how the bluechip G4
> upgrade for the pismo works?  Is it also reported as 0x0008nnnn?  If so,
> how does your code snippet handle that case?

All of the G4 bluechips are either 7400 (in the older models, not
anymore though) or 7410 CPUs strapped normally (PVR = 0x000Cnnnn [7400]
or 0x800Cnnnn [7410]).  Since these are strapped normally, nothing
special needs to be done to handle that case.  Here's the code snippet
we use in our software to determine if you are on a 750 or 750FX:

UInt32 getRealPVR()
{
	UInt32	pvr = getSPR(287);
	UInt32	realPVR = pvr;
	if((pvr & 0xFFFF0000) == 0x00080000)
	{
		// This could be a 750FX strapped as a 750 PVR
		UInt32 hid1 = getHID1();
		if(hid1 & 0x00010000)
		{
			// PLL1 is in use, fiddle with PLL0
			setHID1(hid1 ^ 0x00000200);
			if(getHID1() != hid1)
			{
				// HID1 changed, this is a 750FX
				realPVR = (0x70000000 |
					(pvr & 0x0000FFFF));
				setHID1(hid1);
			}
		}
		else
		{
			// PLL0 is in use, fiddle with PLL1
			setHID1(hid1 ^ 0x00000002);
			if(getHID1() != hid1)
			{
				// HID1 changed, this is a 750FX
				realPVR = (0x70000000 |
					(pvr & 0x0000FFFF));
				setHID1(hid1);
			}
		}
	}
	return realPVR;
}

Basically this just checks to see if we have a 750 PVR, and if we do it
tries writing to the PLL bits of the PLL that isn't in use in HID1.  If
HID1 changes, then we have a 750FX rather than a 750.  Finally, we reset
HID1 back to whatever it was before we changed it.

This is a bit annoying because it means you can't always rely on a mfpvr
instruction in some assembly code.  We run this routine once when our
software starts up and store the result in a global variable which we
use in the rest of the code.  Also, note that the lower 16 bits of the
PVR remain unchanged regardless of how the CPU is strapped, so we mask
off the top 16 bits only and replace them with 0x7000nnnn.

BTW I am only subscribed to the list digest, so if you want more timely
replies (i.e. more than once a day :P ) CC me with the list message.

TG


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
