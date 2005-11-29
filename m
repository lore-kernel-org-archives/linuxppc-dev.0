Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id D028E68802
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 01:17:20 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: David Ho <davidkwho@gmail.com>
Date: Tue, 29 Nov 2005 16:17:12 +0200
References: <200509201117.40454.david.jander@protonic.nl>
	<20050920180758.9020C353AB3@atlas.denx.de>
	<4dd15d180511281706q388def30r42d3452c392bc92@mail.gmail.com>
In-Reply-To: <4dd15d180511281706q388def30r42d3452c392bc92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511291517.13261.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

On Tuesday 29 November 2005 02:06, David Ho wrote:
> Hi, just catching up on this problem as I have another unit that
> showed the same symptom.
> My system looks like this
>
> MPC852T
> 128Mbytes SDRAM
> 64Mbytes Flash
>
> Flash partitions
> 2*1.25Mbytes partitions for Kernel
> 61.5Mbytes for rootfs and applications.
> Remaining 1Mbyte for U-boot, u-boot env and spare.
>
> I get that same problem as well.  kernel BUG at gc.c: 139
>
> I have compiled Perl, Openssl, Openssh, etc running NFS so SDRAM is
> definitely not the issue.

I have done almost the same (compiling Perl didn't succeed because of an 
out-of memory condition), and never had any other reason to suspect hardware 
problems.
After getting some advice from peoble at mtd-list, I switched to 2.6.14 for 
our new developments, and jffs2 seems a lot more stable now. I can only 
recommend you to consider switching. Besides consuming a little more RAM and 
Flash, 2.6.14 is miles ahead in terms of almost anything else, plus it's a 
bit faster on 8xx than 2.4.25!!
I have to warn you though, that it still seems not to be as rock-solid as one 
might want for an embedded system: We have a stress test running for a few 
weeks now simulating power-failures during writes to files on jffs2, and mtd 
has some occasional hick-ups. Those hick-ups seem to be far less serious than 
gc.c crashing, but we will have to take them into account in our application.
This is the situation: Sometimes the test application crashes giving a 
write-error on the mtd device, preceded by an error message from the 
mtd-driver (and jffs2, but the problem seems to come from mtd). The error 
message is like "MTD do_write_buffer(): software timeout", which normally 
means a flash programming error, most probably due to sector beeing worn out, 
but I don't think that is the case, since those problems began appearing 
quite early and went away all by them selves. Flash doesn't magically "fix" 
itself over time, does it?
Maybe it's a problem in the AMD flash driver (our device is a Spansion 
Mirror-bit S29GL256M11)

> David: have you gotten any new insights since?

Yes, see above.
Please keep me informed if you get to know something more about the 
problem ;-)
If you want more detail about what tests we are doing, and the problems we had 
so far, feel free to ask, or read my posts to the MTD list. Right now its 
46268 power-cycles and counting.

Greetings,

-- 
David Jander
Protonic Holland.
