Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B0B2EDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 06:42:39 +1000 (EST)
Subject: Re: ML403 AC97 ALSA Driver problem
From: Joachim Foerster <mls.JOFT@gmx.de>
To: Qin Lin <linkinge@gmail.com>
In-Reply-To: <12399427.post@talk.nabble.com>
References: <12399427.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 03 Sep 2007 22:42:35 +0200
Message-Id: <1188852155.5738.21.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Qin Lin,

On Wed, 2007-08-29 at 19:19 -0700, Qin Lin wrote:
> when i use the ac97driver posted by Joachim Förster  recently,there is a
> kernel stack overflow while testing .

> [   82.689668] Kernel stack overflow in process c02a6490, r1=c02f7f30
> [   82.763235] Oops: kernel access of bad area, sig: 11 [#1]
> [   82.827330] NIP: C001327C LR: C001666C CTR: 00000000
> [   82.886699] REGS: c01931f0 TRAP: 0300   Not tainted  (2.6.20)
> [   82.955428] MSR: 00021030 <ME,IR,DR>  CR: 28000028  XER: 00000000
> [   83.028333] DAR: 00000005, DSISR: 00000000
> [   83.077290] TASK = c02a6490[134] 'xsysace' THREAD: c02f8000
> [   83.141855] GPR00: 00000001 C01932A0 C02A6490 00000000 C01B3770 00000012
> 00000300 00000010
> [   83.241838] GPR08: FFFFFFFA 00000020 00000000 00000005 00000000 FFFF87B8
> 03FD0700 00000000
> [   83.341823] GPR16: 00000001 00800000 03FCF588 00000000 FFFFFFFF 007FFF00
> 03FC9FFC 00000002
> [   83.441806] GPR24: 03E667C0 C01B0000 C010600C C01B3770 00000012 00000000
> 00000000 C0193470
> [   83.543874] NIP [C001327C] xmon_write+0x38/0xbc
> [   83.598032] LR [C001666C] xmon_vfprintf+0x34/0x48
> [   83.654272] Call Trace:
> [   83.683435] Instruction dump:
> [   83.718848] bf61000c 90010024 3d20c01b 8009f1bc 7c9b2378 2f800000
> 7cbc2b78 40be0008
> [   83.811540] 4bfffe2d 3ba00000 3bc00000 48000054 <880b0000> 7c0a4839
> 4182fff8 7ffbf0ae

Do you get this overflow everytime you try aplay? Or, do you get it
sometimes, only?

What confuses me is, that in your kernel messages the "TASK = ...
'xsysace'" is mentioned. Perhaps there is some relation with the sysace
driver? Or do I miss something, here?
Did you try play a .wav file from a RAM disk or NFS-mounted location? I
have to note, that I am not using sysace and I haven't tried it jet -
especially together with my AC97 driver.

As a first step, no matter what, you could compile your kernel with
CONFIG_SND_DEBUG and additionally replace the line

#define PDEBUG_FACILITIES (UNKNOWN | INIT_FAILURE | WORK_FAILURE)

in ml403-ac97cr.c with

#define PDEBUG_FACILITIES (UNKNOWN | INIT_FAILURE | WORK_FAILURE |
WORK_INFO | INIT_INFO)

This will give you a, well, huge amount of debugging messages
(KERN_DEBUG). There we should see, how far my driver is getting (to some
extent).

 Joachim
