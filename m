Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 9E68EDEF30
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Aug 2008 00:52:38 +1000 (EST)
Received: by gxk14 with SMTP id 14so123200gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 07:52:36 -0700 (PDT)
Message-ID: <fa686aa40808210752w6fab2adfgdaa39503db460a03@mail.gmail.com>
Date: Thu, 21 Aug 2008 08:52:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david.jander@protonic.nl>, devicetree-discuss@ozlabs.org
Subject: Re: porting linux 2.6.27 to embedded powerpc board
In-Reply-To: <200808211143.45782.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <424724.49343.qm@web46312.mail.sp1.yahoo.com>
	<200808211143.45782.david.jander@protonic.nl>
Cc: Laxmikant Rashinkar <lk.atwork@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 3:43 AM, David Jander <david.jander@protonic.nl> wrote:
> On Thursday 21 August 2008 01:24:46 Laxmikant Rashinkar wrote:
>> Hi,
>>
>> I have an embedded PowerPC (MPC8347) board that works fine with uboot and
>> Linux 2.6.15.
>>
>> I am trying to upgrade the kernel so that it runs on the latest release -
>> Linux 2.6.27. So far, I have gotten the kernel to compile on my platform,
>> but of course it does not boot.
>
> Well, honestly I don't know where to look for information either (other than
> the source-code and examples from others), but here is a list with points to
> look out for (I have just done the same thing as you for a MPC5200B-based
> board):
>
> 1. Upgrade to latest u-boot first (recent git seems to be fine). There have
> been a lot of changes in u-boot lately about OF and device-tree related
> things. I suspect you need a fairly recent version of u-boot to go well with
> the latest kernel. It's also generally a good idea IMHO.

You don't *have* to do this though.  There is a target called
'cuImage.<myboard>' which will embed the device tree blob in the
kernel image and is backwards compatible with older u-boot versions.
See arch/powerpc/boot/Makefile and arch/powerpc/boot/wrapper to see
how this is generated.

There is a new document that might help in Documentation/powerpc/bootwrapper.txt

> 2. I assume you are porting to arch/powerpc (the old arch/ppc you used back in
> 2.6.15 is obsolete and broken now).

Not just broken; completely removed!  :-)

> 3. Look at other platforms that use the same processor, and pick a simple one
> as starting point. Look out for the dts (device-tree-source file in
> arch/powerpc/boot/dts), copy and modify one to reflect your hardware.
> Recently a lot of changes happend in the kernel, changing device names,
> obsoleting "device-type" tags, etc..., so some of the current DTS sources
> included in the kernel might not even work (wrong device name, missing
> information, wrong use of "device-type", etc...), so watch out for these kind
> of issues too.

The goal is *not* to break existing device trees because we do not
know what has been deployed already and it some cases it is not
feasible to update the device tree on a device.  So, even though
conventions have been refined and changed, backwards compatibility
with older trees is supposed to be preserved.

3b. Once you've written your device tree, post it to the
devicetree-discuss@ozlabs.org mailing list and ask for review.

> 4. Be sure that the device(s) necessary to produce output on your console are
> correctly placed in the DT. Also make sure that u-boot knows about it
> (#define OF_STDOUT_PATH... in your u-boot board config file)
>
> 5. When compiling the device tree, it may be necessary to add some extra
> reserved entries to the compiled tree (I am using dtc -p 10240 -R 20, which
> might be slightly exaggerated), because u-boot may add something to it, and
> if it can't, linux won't boot.
>
> 6. Remember to always specify the "rootfstype=" option on the commandline if
> booting from anything other than NFS. This was not necessary back in the
> 2.6.15-times AFAICR.
>
> 7. Boot with a device-tree (in u-boot: "bootm $addrofkernel - $addrofdtb",
> don't forget the dash if you are not using an initrd). If you don't do this,
> u-boot can't fix your DT, and the kernel probably won't find it either.
>
> 8. Be sure to use the correct version of the DTC (DT compiler) for your kernel
> (the sources are included nowadays, somewhere in arch/powerpc/boot IIRC). The
> command used to compile, should probably be something like this:
>
> $ ./dtc -p 10240 -R 20 -I dts -o myplatform.dtb -O dtb -b 0 dts/myplatform.dts

There is a makefile target now to help you with this and pass the
right options for reserving entries:

$ make myplatform.dtb

The dtb image will appear in arch/powerpc/boot

> Load the resulting .dtb file directly with u-boot (don't make an u-image out
> of it).
>
> That's all I remember right now... hope it helps.
>
> Regards,
>
> --
> David Jander
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
