Return-Path: <miltonm@bga.com>
In-Reply-To: <fa686aa40807252155l4f785920qdb14d117067b30f4@mail.gmail.com>
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
	<fa686aa40807252155l4f785920qdb14d117067b30f4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <913573e2092839fbe37a0bfa37119eb6@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
Date: Sat, 26 Jul 2008 12:20:39 -0500
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jul 25, 2008, at 11:55 PM, Grant Likely wrote:
> On Thu, Jul 24, 2008 at 9:08 PM, Milton Miller <miltonm@bga.com> wrote:
>>> Add support for powerpc builds in the buildtar script, to include
>>> a few default images.
>>> ---
>>> RFC: any requests for more/less boot images?
>> ..
>>> +             for img in zImage zImage.pseries zImage.iseries \
>>> +                             dtbImage dtbImage.ps3
>>
>> Yes.  How about all dtbImage, zImage, cuboot, treeboot, etc
>> that are newer than vmlinux?
>
> dtbImage is not a buildable image.  Neither is cuImage, treeImage or
> simpleImage.  All of those targets embed a device tree which is
> specified by adding the .dts filename to the target name.

I intended "all dtbImage" as a wildcard for dtbImage.*, etc.

> so, for example, 'make cuImage' fails.  Instead you do 'make
> cuImage.lite5200b' which pulls in dts/lite5200b.dts.

The user does make zImage which makes cuImage.lite5200b based on 
Kconfig.   Or it was that way until your change in 2.6.25 to allow the 
later, but they can still do the former.

Hmm, we really need to fix our calls to make boot images with make -j.  
Something for my todo list.

> Also, zImage is a 'meta' target that builds all the default image
> targets (the $image-y list).  The zImage is actually just a symlink to
> the first file in the list of default images.  So zImage can actually
> point to any kind of kernel image depending on how the kernel is
> configured.  I wonder if we should just remove the zImage file
> entirely, or at least make it always linked to one particular image
> type.

I think its fine as it is.   It says "make what is configured" that 
lets cross-platform building scripts be dumb and not need to know 
specificially what image makes sense to make.  Perhaps we should make 
it default to our additional target in Kconfig if specified, this 
allowing the user to specify which version he gets.

milton
