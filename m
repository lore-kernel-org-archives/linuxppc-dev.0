Return-Path: <Kevin.Holland@daktronics.com>
Received: from smtp.daktronics.com (smtp.daktronics.com [63.85.214.24])
	by ozlabs.org (Postfix) with SMTP id 4E771DDF8F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 03:19:18 +1000 (EST)
From: Kevin Holland <Kevin.Holland@daktronics.com>
To: John Bonesio <john.bonesio@xilinx.com>
Date: Thu, 9 Apr 2009 12:04:08 -0500
Subject: RE: Xilinx board and NPTL support lockup
Message-ID: <E7BCBE4FF97239429BC88917868371F427168CE2@MB-EXC-01.daktronics.lan>
References: <22960621.post@talk.nabble.com>,
	<20090409165055.AC7A31A78051@mail50-sin.bigfish.com>
In-Reply-To: <20090409165055.AC7A31A78051@mail50-sin.bigfish.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for your help.

This was a kernel setup issue, I had forgotten to strip the debug informati=
on out of my new libraries and my initramfs was too large.
I believe the zImage was decompressing onto itself, thats why it was stuck =
at the "now booting."  I probably could have fixed it by changing my boot l=
ink/load address in the kernel config but I just stripped the files and it =
booted fine after it was smaller.

Hope this helps out anybody else with similar problems.

Kevin
________________________________________
From: John Bonesio [john.bonesio@xilinx.com]
Sent: Thursday, April 09, 2009 11:50 AM
To: Kevin Holland
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Xilinx board and NPTL support lockup

Hi Kevin,

This doesn't look like an NPTL problem to me. It appears you have
rebuilt the kernel, and your new kernel has a problem booting on the
board. I would check the configuration options you have enabled in the
kernel, and I would check that xparameters.h (older kernel) or the
device-tree (newer kernel) is right for your hardware design.

If you haven't rebuilt the kernel, then I would check your setup.

- John

khollan wrote:
> Hi everyone,
>
> I have a board similar to the ml410, its been running a linux kernel happ=
ily
> for about a year now, but now the firmware guys want NPTL threading inste=
ad
> of the linuxthread library.
> I recompiled my gcc 4.0.2 and glibc 2.3.6 library with the NPTL support, =
and
> recompiled my kernel with the new tools.
>
> Now my kernel gets stuck at the infamous "Now Booting the Kernel" message=
.
>
> Any thoughts on why this might be happening, or how to verify that my gli=
bc
> and gcc are functional other than trying to compile things with them (I k=
now
> this works).
>
> Thanks
> Kevin
>

--
------------------------------------------------------------------------

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
