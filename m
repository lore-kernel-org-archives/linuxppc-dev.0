Date: Sat, 17 Nov 2001 13:51:40 -0500
Subject: Re: X works somewhat on DFP with latest radeonfb.c
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	<linuxppc-dev@lists.linuxppc.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
From: Daniel Berlin <dan@cgsoftware.com>
In-Reply-To: <20011117162042.FDYX11528.tomts16-srv.bellnexxia.net@there>
Message-Id: <22FAEDD6-DB8C-11D5-A4FB-000393575BCC@cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At least for poweroboks, the problem is that they rely on the bios being
there to detect the DFP/LCD.
Thus, it detects a size of 65535x65535, and things get screwy.
Also, DDC is disabled for PPC, because some can't handle int10 properly.
However, my powerbook seems to deal with it fine.
Comment out the part disabling int10 on powerpc, and see if ddc detects
your DFP properly.

Forcing the Panel size to the right size, I can use the CVS XFree86 on
my tibook2, without the UseFBDev option.

In fact, I almost have DRI working, too.
We just get the wrong address for the location of agp on the uninorth
(It says 16 meg @ 0x0), and thus, screw up.  But it inits the engine
okay, etc.

--Dan
On Saturday, November 17, 2001, at 11:23  AM, Kevin B. Hendricks wrote:

>
> Hi Ani,
>
> Ben mentioned below that you might have some patches to handle BigEndian
> issues for radeon.
>
> Any help would be greatly appreciated.
>
> Thanks,
>
> Kevin
>
>
> On November 17, 2001 11:07, Benjamin Herrenschmidt wrote:
>>> Hi Ben,
>>>
>>> Thought you might like to know.  I took a look at the XF410
>>> radeon_driver.c and compared it to the latest versions of
>>> radeon_driver.c in XFreee86 CVS HEAD and they are quite different.
>>>
>>> CVS HEAD has a *lot* more support for DFP but since I had the radeonfb
>>> working on the DFP I thought what the hell, and started to try to use
>>> XF 4.1.0 radeon_driver.c with only a few small tweaks (ignoring all of
>>> the Flat Panel code which is old and not-working in XF410) with the
>>> UseFBDev Option so all the DFP register stuff is handled by the
>>> radeonfb.c driver.
>>>
>>> X actually starts up with depths of 8 and depths of 24 (32bpp), and
>>> works but the colors are all wrong:  too many pinks in the 8 bit
>>> version and seemingly random colors in the 24 depth.
>>>
>>> So I am going to try and play around with the pallette setting.
>>
>> Ask Ani for his patches. I think the engine must be properly configured
>> for big endian.
>>
>> Ben.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
