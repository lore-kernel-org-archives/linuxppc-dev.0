Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0BAC2B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 01:02:58 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
References: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 13 Jul 2009 09:02:34 -0600
Message-ID: <fa686aa40907130802h3a6875f7gf21d41974974a7e4@mail.gmail.com>
Subject: Re: Soft Reset for PPC44x Virtex 5 hangs saying Restarting System
To: srikanth krishnakar <skrishnakar@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 13, 2009 at 1:16 AM, srikanth
krishnakar<skrishnakar@gmail.com> wrote:
> Hi all,
>
> Kernel : Linux-2.6.29
> Arch: Powerpc (ppc44x)
> Target: Xilinx ML507 Virtex5
>
> I have an issue in "Reset System" of Xilinx ML507 target board. I am using
> Compact Flash to boot the target ( using system ACE file to boot the
> target), during the process reset or reboot command on the target, I am not
> able to reboot the target completely, here is the snapshot:

Where is your boot code located?  In BRAM?  or SDRAM?  If it is in
RAM, then it is likely that your boot code gets overwritten when the
Linux kernel boots and so soft resetting the processor will result in
a hung system (because it doesn't have any boot code to run).

> -----------------------------------------------------------------------------------------------------
>
> The target again doesn't provide me the boot options as obtained when done
> hard reset :

What boot options are you referring to?  SystemACE boot configuration?
 The current system ace driver doesn't have any support for either
setting the boot options or using the systemace to reboot the system
by reconfiguring the FPGA.  It shouldn't be hard to do, it just hasn't
been written.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
