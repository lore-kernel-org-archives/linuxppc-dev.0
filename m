Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D14792C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2013 20:51:55 +1100 (EST)
Date: Sun, 31 Mar 2013 11:51:51 +0200
From: Anatolij Gustschin <agust@denx.de>
To: CF Studelec <cfoissac@studelec-sa.com>
Subject: Re: MPC5121e, Linux, simple IO ports
Message-ID: <20130331115151.50cdac0b@crub>
In-Reply-To: <514ACAD6.6010909@studelec-sa.com>
References: <514ACAD6.6010909@studelec-sa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, 21 Mar 2013 09:54:46 +0100
CF Studelec <cfoissac@studelec-sa.com> wrote:

> Hello,
> 
> This is a simple board base on mpc5121e MCU.
> 
> 
> Gpio is detected: kernel is compiled with its support - i got
> gpiochip_find_base: found new base @224 in dmesg - on kernel 3.0.4.
> 
>  
> But i'm unable to access it through /sys/class/gpio. I can successfully
> export a pin (ie, if i type cat 224 > export, gpio224 is created), but i
> can't successfully control it:
> 
>  
> 
> echo "out" > /sys/class/gpio/gpio224/direction
> 
> cat /sys/class/gpio/gpio224/value
> 
> 0
> 
> echo 1 > /sys/class/gpio/gpio224/value
> 
> cat /sys/class/gpio/gpio224/value
> 
> 0
>
> My need is a simple chipselect (well, 3 chipselect exactly ), for a
> custom design. Running linux is mandatory. I suspect the MPC5121e to be
> in the bad function mode, so:
> 
> - does anyone knows how to change mode ? What register can i acces and
> how ? does it worths a try ?

For GPIO0 - GPIO7 pins you additionally need to configure the pin mux
for GPIO mode, see IO_CONTROL_GP register description in the manual.

> - does anyone successfully performed simple IO control ?

We use it all the time, i.e. as SD-Card detect and/or
write-protect GPIOs, as SPI Chips-Select GPIOs, etc. It works.

> Last thing, i have tryed to access internal registers through /dev/mem,
> but no success. There are very few ressources available for this
> microcontroler, but i'm stick to it. Perhaps anybody knows how to access
> (read) internal registers with /proc or sys-fs ?

Accessing registers using /dev/mem should work (tested using
devmem2.c tool with recent v3.9-rc4 kernel. Should work with
older kernels too).

Alternatively (as a quick test) you could configure the registers
under U-Boot using "mw" command, assuming you are using U-Boot as
a bootloader.

HTH,

Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0  Fax: +49-8142-66989-80 Email: office@denx.de
