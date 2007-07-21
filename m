Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 0CFA6DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 06:17:22 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1530576wag
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 13:17:21 -0700 (PDT)
Message-ID: <fa686aa40707211317q47b12a38jbe05e4d2c89767f4@mail.gmail.com>
Date: Sat, 21 Jul 2007 14:17:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Joachim_F=F6rster?=" <mls.JOFT@gmx.de>
Subject: Re: ML403 / ALSA driver for AC97 Controller
In-Reply-To: <1185047879.15040.34.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1185047879.15040.34.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/21/07, Joachim F=F6rster <mls.JOFT@gmx.de> wrote:
> Hi all,

Thanks Joachim, this is interesting work.  I'd like to see this get
into mainline.

A few initial comments:
1. You should post this code as a patch against the kernel tree.
Links to tarballs are not the best way to get code reviewed.  Post
your patches to both the ALSA and linuxppc-dev mailing lists.
2. (get this out of the way quickly) Coding standard doesn't match the
kernel (indent w/ tabs, keep lines < 80 chars, etc).  You should run
your code through 'scripts/Lindent' in the kernel tree.  That will
sort out many of the whitespace issues.
3. In the same vein, c++ style comments need to be scrubbed.
4. Do not directly include xparameters.h in your driver.  The driver
should get it's data from the platform bus registration (of the
of_device registration when we move to arch/powerpc).
5. struct 'platform_device devices[]' needs to be moved to
arch/ppc/sysdev/virtex_devices.c
6. Have you looked into the new ALSA infrastructure which separates
Codecs from controllers (in sound/soc)?  It might be a good idea to go
that route for this driver.

That being said, it looks like good work.  Please cc me when you send
the next version.

Thanks,
g.

---
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
