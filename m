Return-Path: <dan@embeddededge.com>
Received: from smtp001.bizmail.yahoo.com (smtp001.bizmail.yahoo.com
	[216.136.172.125]) by ozlabs.org (Postfix) with SMTP id 68C1267A2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 02:41:28 +1100 (EST)
In-Reply-To: <41FFBC9A@webmail>
References: <41FFBC9A@webmail>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33d0c0212a6e30e381aeb4a14caea56d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 3 Feb 2005 10:34:44 -0500
To: Per Hallsmark <per.hallsmark@t2data.se>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Question about cpm reset on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 3, 2005, at 10:02 AM, Per Hallsmark wrote:

> Yes, probably the 8260 code evolved from the 8xx code?

Yeah, sorta.

> Of course, there could be a reason why it is like it is
> and that's why I sent out the question...

It seems to be the personal preference of the last person that
make changes and checked in a patch.

Years ago, we used to always reset the cpm to eliminate
any microcode patches that may have been installed by the
boot rom.  We never knew what may be there, so drivers
would fail.

Later, I added a bunch of kgdb/xmon support for early kernel
debugging.  Due to this, we didn't want to reset the cpm because
we would rely on the boot rom initialization of the serial port
for communication.  The early serial functions just track down
the BDs and use them, regardless of how they were set up.
Lots of kernel code is run prior to the Linux configuration of the
serial ports, and we wanted to debug before that.

Now, I see this microcode patch again.  This is an old piece
of code, or perhaps a recent update to it.

So, the configuration issue is whether you want to run kdgb
or xmon for early kernel debugging.  If so, you don't want to
reset the cpm.  If there are microcode patches loaded by by
a boot rom, we probably want to reset the cpm.  If you are
loading your own patches, you must reset the cpm.  If you
want to run kgdb or xmon and load your own microcode
patches ... well, you have a challenge :-)

There may be some configuration logic that meets most
requirements, but it isn't going to be proper for everyone.
You may have to locally edit the files for your purpose,
which is true of several cpm related drivers.  You have the
source, use it! ;-)

Thanks.

	-- Dan
