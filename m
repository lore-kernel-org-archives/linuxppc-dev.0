Date: Thu, 8 Nov 2001 10:04:38 -0500
Subject: Re: [PATCH]: Make radeonfb work alot better with new powerbooks
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: <ajoshi@unixbox.com>, <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Daniel Berlin <dan@cgsoftware.com>
In-Reply-To: <20011108102237.11596@smtp.adsl.oleane.com>
Message-Id: <EDBD773A-D459-11D5-9D29-0030657B5340@cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday, November 8, 2001, at 05:22  AM, Benjamin Herrenschmidt
wrote:

>>
>> This patch makes the radeonfb work a lot better on the rev b
>> powerbooks.
>> It's against benh's latest, as of last night.
>
> Heh, Great ! I ordered a new TiPb but didn't get it yet :)
:)
They are very nice.
In case you were wondering, here's a rundown of how things work:
Firewire is an LSI FW500 chip (AFAICT), and works with ohci1394 in your
tree without any changes.
The ethernet phy is something i've never seen before (It works, being
detected as a generic PHY). It's got an ID number that doesn't seem to
be like any of the others we can detect, but i could be wrong.
Sound seems the same as the ibook2 (TAS chip).
>
> Could you send me a tarball of /proc/device-tree ?
>
Sure, i'll do it when i get home today.
>> Fixed/added:
>> 1. Any other mode besides 640x480 was absurdly slow. Unusable, in fact.
>> It now is pretty darn quick, and completely usable.
>> 2. It would default to 640x480, rather than 1152x768, on rev b
>> powerbooks.
>> 3. It would also determine that we had no monitor, and no display
>> panel,
>> because it couldn't read the video bios that doesn't exist in the
>> powerbooks.
>> In reality, the LCD is on the DVI port.
>> So for rev b powerbooks, we go ahead and say so, and let it detect
>> the flat panel size/stretching/etc.
>
> We need to fix this for DVI LCDs as well, for both radeon and aty128fb.
> "Mac" radeons will put the monitor EDID in the device-tree, so we could
> probably just parse that, but r128's firmware won't. I'd rather
> implement
> the proper i2c code for reading that and add a generic fbdev ioctl for
> retreiveing it (as it's not card specific) so userland tools can use it
> to generate proper XF86Config as well.

The code to do i2c on the radeon and aty128fb doesn't seem that tricky
to implement ( At least, from reading the xfree86 drivers), so i might
take a whack at it.
>
>> 4. It would assume blanking meant blanking the crt. It will now turn
>> off
>> the lcd as well.
>> 5. It now supports the backlevel lighting control. It's the same on the
>> rage128 and the radeon, so i copied and renamed the routines from
>> aty128fb.c
>
> Beware with blanking of the CRT/LCD. The current code I have for r128
> seem to have problems. I've user reports on r128 of "burned" lines after
> keeping the LCD off a long timech fortunately disappeared, but only
> after
> several hours of normal use. I suspect a different shutdown sequence
> should
> be used to properly turn off the LVDS and the panel itself, but I don't
> know
> what for sure, the docs I have from ATI aren't very precise.
>
> I want to remove part of that code and let only LVDS_DIS and backlight
> off.
>
>> It *shouldn't* have any problems on a normal radeon powermac, but i
>> don't
>> have one to try it out on.
>
> I'll try it on the radeon AGP card I have at work, if it still works,
> I'll
> include it in my tree and bk _devel.
>
>> Hopefully, this is useful for someone besides me.
>
> Yup ;)
>
> Regards,
> Ben./
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
