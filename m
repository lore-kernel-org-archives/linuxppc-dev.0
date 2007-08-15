Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id C087BDDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 07:23:44 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id f5so30448rvb
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 14:23:43 -0700 (PDT)
Message-ID: <5c9cd53b0708151423r1c9748e5jbd460cd72585020c@mail.gmail.com>
Date: Wed, 15 Aug 2007 17:23:43 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: System crash on boot_e500.S
In-Reply-To: <46C368D1.7000403@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5936_21959735.1187213023642"
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
	<1187124014.32650.80.camel@ld0161-tx32>
	<5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>
	<20070815160254.GA9049@ld0162-tx32.am.freescale.net>
	<A9A39446-A8B0-44D7-ABF4-E9918FCC2843@kernel.crashing.org>
	<16A6A248-880E-483A-AFDD-2A225F4B6864@freescale.com>
	<5c9cd53b0708151353u67e10e03lf12c3971e4f3d63@mail.gmail.com>
	<46C368D1.7000403@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5936_21959735.1187213023642
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/15/07, Scott Wood <scottwood@freescale.com> wrote:
>
> mike zheng wrote:
> > Unfortunately, all the applications are running on 2.4 kernel. I can not
> > just throw the 2.4 kernel.
>
> And in what way does 2.6 break these applications?


All the device drivers are based on 2.4 kernel. We plan to upgrade to 2.6 in
the middle of next year.

> I took the some core specific code from
> > ppc.bkbits.net, such as head_e500.S and mpc85xx_cds_common.c. I assume
> the
> > image should work on the 8548 CDS board, or at least for the bootup. I
> shall
> > able to have the serial port working in platform_init(). However , the
> > code stops in the head_e500.S. This does not make any sense. Please
> correct
> > me if I am wrong.
>
> Of course it makes sense -- you can't just go around ripping random
> files from a codebase, sticking them in a version from several years
> earlier, and expecting it to "just work".


All those files are e500 core specific. When we use bootm from Uboot to
start the kernel, head_e500.S is first file being called, and then the
mpc85xx_cds_common.c. I also merged some BOOKE related include files into
our source tree as well.

Our 2.4 kernel version is different from ppc.bkbits.net. I did not expect it
"just work". However the serial console should come out when platform_init()
called. Everything before that is the same for any processor with e500 core.




> Any suggest or comment is welcome, I am struggling with this issue for
> > almost one week...... :-(
>
> How long would you have struggled with getting your applications running
> on a more recent kernel instead?


Don't know, maybe 16 weeks. That is out of my control. I only deal with the
kernel.....:-)

-Scott
>

------=_Part_5936_21959735.1187213023642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 8/15/07, <b class="gmail_sendername">Scott Wood</b> &lt;<a href="mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">mike zheng wrote:<br>&gt; Unfortunately, all the applications are running on 2.4 kernel. I can not<br>&gt; just throw the 
2.4 kernel.<br><br>And in what way does 2.6 break these applications?</blockquote>
<div>&nbsp;</div>
<div>All the device drivers are based on 2.4 kernel. We plan to upgrade to 2.6 in the middle of next year. </div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; I took the some core specific code from<br>&gt; <a href="http://ppc.bkbits.net">ppc.bkbits.net</a>, such as head_e500.S and mpc85xx_cds_common.c. I assume the
<br>&gt; image should work on the 8548 CDS board, or at least for the bootup. I shall<br>&gt; able to have the serial port working in platform_init(). However , the<br>&gt; code stops in the head_e500.S. This does not make any sense. Please correct
<br>&gt; me if I am wrong.<br><br>Of course it makes sense -- you can&#39;t just go around ripping random<br>files from a codebase, sticking them in a version from several years<br>earlier, and expecting it to &quot;just work&quot;.
</blockquote>
<div>&nbsp;</div>
<div>All those files are e500 core specific. When we use bootm from Uboot to start the kernel, head_e500.S is first file being called, and then the mpc85xx_cds_common.c. I also merged some BOOKE related include files into our source tree as well.
</div>
<div>&nbsp;</div>
<div>Our 2.4 kernel version is different from <a href="http://ppc.bkbits.net">ppc.bkbits.net</a>. I did not expect it &quot;just work&quot;. However the serial console should come out when platform_init() called. Everything before that is the same for any processor with e500 core. 
</div>
<div>&nbsp;</div>
<div>&nbsp;</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; Any suggest or comment is welcome, I am struggling with this issue for<br>&gt; almost one week...... :-(
<br><br>How long would you have struggled with getting your applications running<br>on a more recent kernel instead?</blockquote>
<div>&nbsp;</div>
<div>Don&#39;t know, maybe 16 weeks. That is out of my control. I only deal with the kernel.....:-)</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">-Scott<br></blockquote></div><br>

------=_Part_5936_21959735.1187213023642--
