Date: Wed, 23 Jun 1999 13:14:29 -0700 (MST)
From: chris <chris@ns1.aepnet.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerBook sleep, first try
In-Reply-To: <Pine.LNX.3.96.990623091811.16972F-100000@mvista.com>
Message-ID: <Pine.LNX.4.04.9906231306510.25771-100000@ns1.aepnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Wed, 23 Jun 1999, David A. Gatwood wrote:

> 
> On Wed, 23 Jun 1999, Kevin Puetz wrote:
> 
> > Cool! Is there any hope of this working on the desktop machines that can 
> > sleep? (I like my machine getting quiet when not in use, though I can live
> > without.).
> 
> A desktop sleep is pretty different from a PowerBook sleep.  When a
> desktop machine is asleep, it can still services network requests, and is
> essentially still running, it just shuts a few things down.  The key there
> is to figure out how to spin down and spin up the hard drive without
> getting confused by the long delay on data access.  Then, when you do a
> desktop sleep, you just cut the video sync, spin down the drives, and set
> it up so that if there's any access to the drive, you spin it up long
> enough to do the access, then wait a few seconds for the access to finish,
> then spin back down.  Presumably, there's other stuff dealing with the
> ADB, as far as shutting down other unused hardware and putting the
> processor in a low speed setting or something, but I have no idea there.
> Somebody else with actual cuda knowledge could probably say more in that
> department.
> 
I've had good luck with using hdparm to set the timeout to spin down the
disk in my powerbook.  I imagine it should work for most other people with
ide drives.  also, I noticed a rather dramatic speed increase setting the
PIO mode to 4, and "set IDE 32-bit IO setting"..  namely:

hdparm -S 5 /dev/hda  # sets standby timeout to 25 seconds..
hdparm -c 1 /dev/hda  # 32-bit transfer mode
hdparm -p 4 /dev/hda  # PIO mode 4
  or
hdparm -S 5 -c 1 -p 4 /dev/hda

there's all sorts of other options in there too, but they didn't seem to
make that much of a difference to me..  and note that I stopped using the
standby option as I was getting tired of listening to the disk spin up and
down, but that's how to do it if anyone cares..

ttyl,
  chris

> 
> Later,
> David
> 



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
