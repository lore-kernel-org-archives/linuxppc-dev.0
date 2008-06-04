Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 3FBD9DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 02:32:14 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K3vu6-00016r-LQ
	for linuxppc-embedded@ozlabs.org; Wed, 04 Jun 2008 16:32:02 +0000
Received: from p5497cf09.dip.t-dialin.net ([84.151.207.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 04 Jun 2008 16:32:02 +0000
Received: from dzu by p5497cf09.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 04 Jun 2008 16:32:02 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: No console output when booting linux from uboot
Date: Wed, 04 Jun 2008 18:30:50 +0200
Message-ID: <m2hcc988n9.fsf@ohwell.denx.de>
References: <A9D89E0D76AFF24B9441851F2AC72D7203B7D468@BANMLVEM05.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mike,

> I am trying to boot linux kernel (2.6.23) from uboot (1.3.2) for my custom
> board. The uboot works well, the kernel booting hit the start_kernel(). But
> there is nothing output from console.

Do you provide a correct "console=..." parameter?

> With debugger, I saw that the printk() functions were called many times without
> any console output. Tracing into the source code, I found that the printk()
> called "con->write" operation...
>
> Can anyone guide me to solve this?

I have a hint concerning an incorrect conjecture from your side.
Usually when start_kernel starts, the kernel knows nothing about
consoles to output printk messages to, so in the early phases the
printk's (like printk(KERN_NOTICE)) only end up in the internal ring
buffer.  Its only later when the console is associated with a real
device that everything gets sent there.

So you shouldn't really wonder why early printk's do not output
anything, this is a red herring.  Debug the code responsible for the hw
acting as your console according to the kernel command line.

Cheers
  Detlev

-- 
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
