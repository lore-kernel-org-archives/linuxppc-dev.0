Date: Thu, 11 Mar 1999 09:37:05 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Hubert Figuiere <hub@point-barre.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB Reset
In-Reply-To: <19990311085536.A1755@giordino.point-barre.fr>
Message-ID: <Pine.LNX.3.96.990311092940.6932D-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 11 Mar 1999, Hubert Figuiere wrote:

> According to Benjamin Herrenschmidt <bh40@calva.net>:
> > 
> > After the bus reset, the mouse must be re-initialised to handler 4. In
> > fact, the whole device probing and init must be redone (mac_keyb.c). I'm
> > working on a simple design that allow ADB peripherial drivers to register
> > to the ADB core in order to be notified of bus resets. Stay tuned.
> 
> This is really ugly. Why the hell is mouse related code in the keyboard
> driver ? I may understand that since it is ADB they are related, but
> I find this not really clean.

They're more than related.  With ADB, most mice (anything with more than
one button) act as both a mouse and keyboard.  That was presumably the
only way they could send the extra button information.  Because of this,
the only way to get all of the mouse code out of the keyboard driver would
be to literally have two keyboard drivers, one for real keyboards and one
for the fake mouse-keyboards.  The best you could do would be to have the
keyboard code only contain the code for detecting the fake keyboards and
then switch their handler, but that would basically result in two complete
keyboard drivers with little or no difference between them....

On the other hand, basic device probing and initialization should probably
be in a separate file, since it's not specific to any given device flavor,
maybe adb.c or something, if it isn't already.  Just MHO.  With the added
note that my experience with LinuxPPC's adb drivers is limited to using it
to try to find some bugs in MkLinux's pmu driver.  ;-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
