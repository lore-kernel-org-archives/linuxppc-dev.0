Date: Thu, 15 Nov 2001 13:44:17 -0500
Subject: Re: DFP support for kernel radeonfb.c added
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: linuxppc-dev@lists.linuxppc.org
To: ghannon@cspi.com
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
In-Reply-To: <85256B05.006454A7.00@pine.cspi.com>
Message-Id: <C5D0882F-D9F8-11D5-B99F-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

We have the same setup.  You must have the card installed and the
monitor plugged when your reboot into linux otherwise OF will not be
able to query the card and monitor and create the file.

Then go to /proc/device-tree/pci/ and start looking for an ATY,RADEONp
directory.

Mine was behind a pci bridge so my path looks like the following:

/proc/device-tree/pci/pci-bridge/ATY,RADEONp@4/

In this directory is a file called DFP,EDID and one called LCD,EDID

If either of those exist for you (or something similar with a EDID in
the name) you should be good to go.

If that file exists and is called any of the following:
LCD,EDID  or DFP,EDID, or EDID1, or EDID  then my version of the driver
should work for you with the added kernel parameters:

video=radeon:of_edid,dfp

If it is called something else, please let me know so that I can add it
to the list.

Hope this helps.

Kevin

ps. I am starting work to fix the XF86 CVS radeon_driver.c code to work
as well.
I'll let you know when I have something working.



> How do I get OF to produce the EDID file?
> I don't have a Radeon directory under /proc/device-tree.
>


> I'm also trying to get info on patching XFree86 4.1.0 which came with
> the
> distribution, with Ani Joshi's patch,
> but I'll do that on the Yellow Dog list.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
