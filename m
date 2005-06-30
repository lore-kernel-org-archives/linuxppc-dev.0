Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2CFE967BC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 03:54:03 +1000 (EST)
Date: Thu, 30 Jun 2005 10:54:00 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: David Grab <d.grab@hima.com>
Message-ID: <20050630175400.GC5086@gate.ebshome.net>
References: <003101c57d66$9de20a20$f201a8c0@SN7606>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003101c57d66$9de20a20$f201a8c0@SN7606>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCC440GX custom board configuration
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 30, 2005 at 01:26:52PM +0200, David Grab wrote:
> Hello,
> 
> i have a custom PPC 440 GX board which should run linux 2.6.11.6 kernel. I
> initialized the board with u-boot getting boot console on UART1 to start the
> kernel with bootm command.
> 
> Hardware details:
> PPC 440 GX CPU
> 2 * 256 MB RAM
> 2 * 8 MB Flash
> EM Marvin RTC V3020 (seems not supported by linux?)
> 
> Now i want to configure Linux to match my custom board. I ported my board
> based on ocotea board configuration files and excluded all the stuff i don?t
> need. My kernel seems to load but get stuck on calibrating delay loop and
> loops between update_proces_times and __delay (at address 0xC0003400) until
> it reboots. Seems like i didn?t match the BogoMips calculation. Actually i
> don?t use the RTC (i comment out all TODC functions). I think this cause the
> problem. So what i have to do to boot without RTC or has someone my RTC
> running with linux?

Most likely, you have incorrectly setup serial console, so you don't 
see any messages. Then some other error happens and kernel panics, 
it'll wait for 3min and then reboots. Try accessing printk buffer 
through BDI or other hw debugger.

Also, RTC isn't required for Linux ti run.

-- 
Eugene
