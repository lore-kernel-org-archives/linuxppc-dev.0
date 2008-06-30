Return-Path: <john.williams@petalogix.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 0B0DEDDFAB
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 13:59:55 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so702159fga.39
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 20:59:54 -0700 (PDT)
Message-ID: <1d3f23370806292059qe407693h500d7e562b214e9a@mail.gmail.com>
Date: Mon, 30 Jun 2008 13:59:53 +1000
From: "John Williams" <john.williams@petalogix.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
In-Reply-To: <20080630033943.332471860046@mail171-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
	<1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
	<20080630033943.332471860046@mail171-va3.bigfish.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, monstr@seznam.cz,
	drepper@redhat.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Steve,

> In my opionion, we should only include dts files for reference designs, and
> it must be documented how to get the design that the dts corresponds to.

I'm not sure you (or Xilinx) are quite ready for the pain this implies
- have you tried browsing reference designs on Xilinx.com recently?
It's a total mishmash of tool versions, boards, you name it.  If
Xilinx is ready to declare a gold standard "ML401" design, and commit
to maintaining it tool version after tool version, lots of people will
be very happy, but I don't see it just yet!

I'm not having a go at you here, just questioning the notion that
there is really any such thing as a persistent 'reference design' for
these platforms.  These are not physical boards that get manufactured
and persist as real objects.

> MD5 hashing might be one way to prevent people from getting the dts file
> wrong, however without some way of checking it automatically, I don't think
> anyone will have the patience to checksum the design they have (even worse,
> with whitespace changes, the md5 sum will change, so this is pretty fragile.

Actually I was only joking about the md5 hashing - just to prove my point :)

> Having a device tree in the kernel for documentation *shouldn't* be
> necessary,

Well, yes and no.  A vanilla DTS that shows what a valid one might
look like - "oh, here's where I declare my main memory parameters,
..." has some value IMO.

> since noone should ever write their dts by hand. (right?)

I'm not certain you can guarantee that.

> Hence, I'd prefer to not put the dts file in the kernel at all, and but to
> automatically generate the dts and store it in the blockram of the design.
> This inextricably associates the dts with the design.

Whether the DTS lives in block ram or is pulled over the net by uboot
or whatever is not our call to make in the kernel - that's a
deployment issue.

> As for the copyright, I haven't been able to find much information on
> whether or not generated files are even copyrightable.  One might argue that
> they
> don't have sufficient 'creative value' to be copyrightable.  Or arguably,
> they are as copyrightable by the generator author as by the author or the
> .mhs file.

The DTS is a mechanical translation from one file format to another
(more or less).  Auto-inserting a copyright Xilinx (or anyone else) in
there would be unenforceable, and therefore should probably just go
away.

How would you feel if the FSF claimed copyright over object code
derived from your source files simply because you ran them through
gcc? :)  I believe there's a special clause in the GCC license to
explicitly cover this kind of situation.

Cheers,

John
