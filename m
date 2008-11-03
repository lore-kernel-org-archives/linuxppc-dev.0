Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 3C75FDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 08:57:19 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so2800922qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Nov 2008 13:57:18 -0800 (PST)
Message-ID: <490F73B5.6010004@genesi-usa.com>
Date: Mon, 03 Nov 2008 15:57:09 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
In-Reply-To: <fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Grant Likely wrote:
> On Mon, Nov 3, 2008 at 12:32 PM, René Bürgel <r.buergel@unicontrol.de> wrote:
>> Hi
>>
>> This patch is a workaround for bug #364 found in the MPC52xx processor.
>> The errata document can be found under
>> http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=1&WT_TYPE=Errata&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
>>
> 
> This is an MPC5200 errata.  It doesn't exist on the MPC5200B.  The
> bugfix code should be enabled at runtime only if running on the
> original MPC5200.  You can use the value of the compatible property to
> determine whether or not to enable it.

I would hope not since the Efika uses mpc5200-psc and mpc5200-serial
as it's compatible properties (this is from before mpc5200-psc-uart
was defined), which would enable this bugfix across the board.

Until we have a decent update for the device tree here (it's starting
to cause some real trouble lately when people update stuff like this
and want to compare) the best way to check for the MPC5200 or MPC5200B
is to look at the PVR - you don't need the device tree for this, at
all.

Sometime this week I am going to go through the 5200b device tree in
the kernel source and make sure efika.forth follows it as best as I
can, and then make a release.. that won't fix anything for people who
don't run the script, however.

 > Optionally you can further
> reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.

I would much prefer this.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
