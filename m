Date: Wed, 6 Mar 2002 21:59:56 -0800 (PST)
From: Paul White <pwhite@bivio.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455
In-Reply-To: <20020306194635.11178@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0203062152510.30207-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Mar 2002, Benjamin Herrenschmidt wrote:

> Please, send them to me. I have some 7455 support in my rsync tree
> that I am about to push to bk. However, some of the registers, like
> HID1 or MSSCR0, I consider have to be setup by the firmware or by
> machine specific code.

Yes - It seems this is what Linux expects for the 7450 as well,
as it requests the firmware setup the CPU.

In my 7455 setup, I setup the CPU in linux, assuming the firmware
hasn't done anything yet.  Things such as Address Broadcast Enable
bits are now in HID1 instead of HID0 as on other processors.  As
for cache snooping, the 7455 defaults to a different method of
External Data Intervention.  Maybe this is something firmware
usually sets up?  Using the Galileo system controller, we had to
disable this mode to make it compatable to the MPC7410.

> >Store Instruction
> >Load Instruction
> > - This is not guarenteed in order, even if its Guarded
>
> Ah ? I missed that in the doc. It's pretty bad though so far, all
> drivers are supposed to eieio on any IO access anyway.

See section 3.3.3.5, page 3-29 of the 7450/7455 Users manual..  Its
good that everything already does eieio's between IO accesses.  We
(being our driver engineers here) are kicking ourselves for not
adding these into our custom drivers.  We've added them now, and
things seem to work great!

> My current tree boots and appear to work on Apple dual G4 1Ghz which is
> 7455 based.
>
> I'm still interested in your patches as I may have missed something.

Great!  It sounds like the firmware is doing everyhting.  It might be
nice to add an option to have linux configure the CPU registers or not,
as for us embedded guys thats easier than implimenting it all in the
firmware.  We can do it either way now that we know what the registers
should be, though.

I'll have a cleaned up patch file by tomorrow evening.  What tree
would you prefer the patch be against?

Paul W.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
