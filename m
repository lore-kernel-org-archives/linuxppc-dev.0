Message-Id: <200110121647.f9CGlkY12389@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X 
In-Reply-To: Your message of "Fri, 12 Oct 2001 12:38:28 EDT."
             <20011012163608.GLTX14703.tomts20-srv.bellnexxia.net@there>
Date: Fri, 12 Oct 2001 10:47:46 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This card is the Adaptec PCI card that apples shipped (ships?) as part of
>it Build-To-Order process.  The card is identified as an Adaptec 2930CU
>and it has the following numbers (taken from Open Firmware)
>1686806-04
>Rom # 4.0
>rev. 3

We should have one somewhere around the office.  I'll go look.

>> From the messages file, it appears that the timing out device is
>> simply not bothering to complete commands it has accepted.  We
>> abort these stuck commands successfully and even try them again,
>> but the device won't cooperate.  This appears to be your Quantum
>> Fireball - a drive with a very spotty history.
>
>Never a day of trouble with it under Mac or Linux up till the point I used
>the new driver.  Still works fine under the old aic7xxx driver.

The old driver never issued more than 8 tags.  The new driver will attempt
to dynamically determine the capabilities of the drive and can issue as
much as 253 tags.  The algorithm used depends on the drive actually adhering
to the SCSI spec and might fail on a buggy drive.  If you set the tag depth
to 8 you may see similar behavior to the old driver.

BTW, does the old driver acurately detect that only the external cable
is attached?

>> Perhaps the drive
>> will function correctly if tagged queing is disabled for it.  You
>> can do this only for target 1 with the "tag_info" option.  There may
>> also be firmware updates for this drive.
>
>Can you be more specific about how to use the "tag_info" option.  Where is
>this option set (in the driver source code?) Or is it passed to the kernel
>liek the aic7xxx=verbose option.  If the latter, what syntax should I be
>using so that I can test that option.

It is like the verbose option.  A sample modules.conf line might look
like (assuming you are using a loadable module):

options aic7xxx aic7xxx='"verbose.tag_info:{{253.8.16.92.0.0.0.0}}"'

This sets the tag depth to 253, 8, 16, 92, and "don't do tags" for the
targets 0, 1, 2, 3, and all others on adapter 0, respectively.  There is
a comment section in the driver (I may have only updated it in 6.2.2 or 6.2.3)
that discusses all of the driver options in detail.  The latest driver
is 6.2.4.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
