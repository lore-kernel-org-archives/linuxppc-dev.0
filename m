Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 93196DDFB6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 14:55:32 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1196725anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 21:55:31 -0700 (PDT)
Message-ID: <fa686aa40807252155l4f785920qdb14d117067b30f4@mail.gmail.com>
Date: Sat, 26 Jul 2008 00:55:31 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
In-Reply-To: <200807250108.m6P18f4B099179@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 24, 2008 at 9:08 PM, Milton Miller <miltonm@bga.com> wrote:
>
>> Currently, tarball builds for powerpc kernels don't have any boot
>> images (other than vmlinux) present.
>>
>> Add support for powerpc builds in the buildtar script, to include
>> a few default images.
>>
>> Signed-off-by: Jeremy Kerr <jk at ozlabs.org>
>>
>> ---
>> RFC: any requests for more/less boot images?
>>
> ..
>> +             for img in zImage zImage.pseries zImage.iseries \
>> +                             dtbImage dtbImage.ps3
>
> Yes.  How about all dtbImage, zImage, cuboot, treeboot, etc
> that are newer than vmlinux?

dtbImage is not a buildable image.  Neither is cuImage, treeImage or
simpleImage.  All of those targets embed a device tree which is
specified by adding the .dts filename to the target name.

so, for example, 'make cuImage' fails.  Instead you do 'make
cuImage.lite5200b' which pulls in dts/lite5200b.dts.

Also, zImage is a 'meta' target that builds all the default image
targets (the $image-y list).  The zImage is actually just a symlink to
the first file in the list of default images.  So zImage can actually
point to any kind of kernel image depending on how the kernel is
configured.  I wonder if we should just remove the zImage file
entirely, or at least make it always linked to one particular image
type.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
