Return-Path: <cristian.axenie@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 2DA40DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Nov 2008 01:21:54 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1818908fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Nov 2008 06:21:52 -0800 (PST)
Message-ID: <9c789a000811160621o2ffb9051qff57d006a3af60f@mail.gmail.com>
Date: Sun, 16 Nov 2008 16:21:52 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: "Nicholas Mc Guire" <hofrat@hofr.at>, linuxppc-embedded@ozlabs.org,
	"Joachim Foerster" <mls.JOFT@gmx.de>
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <Pine.LNX.4.58.0811150700530.5061@vlab.hofr.at>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29294_18305269.1226845312294"
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
	<Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
	<9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
	<Pine.LNX.4.58.0811150138440.4494@vlab.hofr.at>
	<9c789a000811150315u3e390a49gf8fa16c16adfbf51@mail.gmail.com>
	<Pine.LNX.4.58.0811150700530.5061@vlab.hofr.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_29294_18305269.1226845312294
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Nov 15, 2008 at 6:02 PM, Nicholas Mc Guire <hofrat@hofr.at> wrote:

> > >
> >
> > I mount my ext2.img and run ls -l and I get
> >
> > crw-r----- 1 root root   5,   1 2008-11-15 02:24 console
> >
> > I think is not ok ?!
> >
> >
>
> thats fine - so that should not be your problem.
>
> what is the console device set to ? can you pass it an explicid
>
> console=/dev/ttyS0 or the like to map it to a device that exists for sure
> and is in /dev/ ? off course you also have to check that the driver
> support is in the kernel.
>
> hofrat


I've managed to solve my problem. I took a clean ramdisk (that came with the
ELDK) mount it , added my needed libs, devs and test apps , then generated
an ramdisk.img (using genext2fs) , compressed it and then created an uBoot
image file. The modified rootfs is now on my USB Flash stick and it works.
My USB Flash rootfs is loaded properly by the kernel and related to my
initial problem, to be more specific,  I've created a root filesystem on my
USB Flash stick where I added the xenomai dir (including /bin /lib
/include...) generated during the Xenomai (from the trunk) install and also
the devices rtheap rtp0... in the /dev directory of my FS. I also used the
proper libc-2.6 standard shared libraries so the dynamic linker does't send
a SIGSEGV anymore and  I am able now to run ./latency or ./cyclictest). I
don't receive SegFault anymore.

Thanks to all,
Cristian

------=_Part_29294_18305269.1226845312294
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Nov 15, 2008 at 6:02 PM, Nicholas Mc Guire <span dir="ltr">&lt;<a href="mailto:hofrat@hofr.at" target="_blank">hofrat@hofr.at</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>&gt; &gt;<br>
&gt;<br>
&gt; I mount my ext2.img and run ls -l and I get<br>
&gt;<br>
&gt; crw-r----- 1 root root &nbsp; 5, &nbsp; 1 2008-11-15 02:24 console<br>
&gt;<br>
&gt; I think is not ok ?!<br>
&gt;<br>
&gt;<br>
<br>
</div>thats fine - so that should not be your problem.<br>
<br>
what is the console device set to ? can you pass it an explicid<br>
<br>
console=/dev/ttyS0 or the like to map it to a device that exists for sure<br>
and is in /dev/ ? off course you also have to check that the driver<br>
support is in the kernel.<br>
<br>
hofrat</blockquote><div>&nbsp;</div><div>I&#39;ve managed to solve my problem. I took a clean ramdisk (that came with the ELDK) mount it , added my needed libs, devs and test apps , then generated an ramdisk.img (using genext2fs) , compressed it and then created an uBoot image file. The modified rootfs is now on my USB Flash stick and it works.<br>
My USB Flash rootfs is loaded properly by the kernel and related to my initial problem, to be more specific,&nbsp; I&#39;ve created a root filesystem on my USB Flash stick where I added the
xenomai dir (including /bin /lib /include...) generated during the
Xenomai (from the trunk) install and also the devices rtheap rtp0... in
the /dev directory of my FS. I also used the proper libc-2.6 standard
shared libraries so the dynamic linker does&#39;t send a SIGSEGV anymore
and&nbsp; I am able now to run ./latency or ./cyclictest). I don&#39;t receive SegFault
anymore. <br><br>Thanks to all,<br>Cristian<br></div></div>

------=_Part_29294_18305269.1226845312294--
