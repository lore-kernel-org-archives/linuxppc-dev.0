Date: Thu, 10 Aug 2000 14:02:46 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Topi Kanerva <tkanerva@ees2.oulu.fi>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.LNX.4.10.10008101149110.1740-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.SOL.3.95.1000810133200.8052B-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 10 Aug 2000, Michael Schmitz wrote:

> > >Should be fixed in BenH's current tree, he said he was going to do it this
> > >past weekend. The pmu backlight controller didn't get registered on the
> > >Lombard (and possibly Wallstreet) because the backlight-control property
> > >is missing on these machines.
> >
> > Well, the backlight control surely doesn't work on Pismos... I just hate
>
> I was speaking about Lombard and related machines. On the Pismo, the
> backlight control is in the display driver IIRC.
>
And with the fix to pmac_setup.c it is indeed working on the Lombard,
thanks to everyone!

BenH did some research on the settings of the function keys, but that's
probably not exactly the problem with the Pismo...(?):

> I've done some hacking on MacOS today and found that the Fn key behaviour
> can apparently be triggered by setting an ADB register of the keyboard.
>
> If you write 0xc6 0x01 to register 1 of the keyboard, the Fx keys will be
> real function keys by default and Fn will trigger the control buttons.
> Write 0xc6 00 to revert the behaviour to default.
>
> So a userland tool can be easily hacked using the trackpad tool source as
> an example, you have to find the keyboard instead of the trackpad (device
> with default and current address 2 should always work on PowerBook and
> iBook ADB) and then do the register write of a 2 bytes message
> (0xc6 0x01). I can't try this now, but if someone wants to look at it...
>
I tried to make some sense of this, but unfortunately I wasn't able to tell
from trackpad.c where I'd try to find the keyboard and where exactly the
register write is done (one of the 'send(buf, n)', probably? Then
  buf[0] = 0xc6;
  buf[1] = 0x01;
  send(buf, 2);
would be the thing to do?). No experience with this, but maybe I'll get it
yet sorted out...
Would this work for setting the register:

void set_fnkey(int id, int mode)
{
	unsigned char buf[16];

	set_program_mode(id, 1);

#ifdef DEBUG
	printf("setting mode: %d\n", mode);
#endif

	buf[0] = 0xc6;
	buf[1] = (mode < 1) ? 00 : 0x01;
	send(buf, 2);
	listen(buf);

	set_program_mode(id, 0);

}

if called with (2, 1) to set the F keys to function keys, and with (2, 0)
to set it back to default? I'm afraid I've not fully grasped what
set_program_mode(id, n) does.


Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
