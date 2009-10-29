Return-Path: <jal2@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8DA90B7C20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Oct 2009 08:36:26 +1100 (EST)
Message-ID: <4AEA0AD5.2040209@gmx.de>
Date: Thu, 29 Oct 2009 22:36:21 +0100
From: Joerg Albert <jal2@gmx.de>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Accessing flash directly from User Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>	<4AE7545F.80805@billgatliff.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>	<4AE75859.5050108@billgatliff.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>	<4AE774ED.8050502@freescale.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>	<4AE7775D.8080502@freescale.com>	<BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>	<1256723805.32158.241.camel@kenjo-laptop>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D36A50@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D36A50@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Kenneth Johansson <kenneth@southpole.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan,

On 10/28/2009 03:45 PM, Jonathan Haws wrote:
> Looking through our notes and talking with the engineer 
> who was performing the tests, it was exactly that - MTD was waiting
> for a signal that was produced differently than the hardware 
> ready signal.  By simply polling the flash until the hardware
> ready signal toggled we were able to get a much faster read and write speed.
> Granted, most of our signals are being sent through a CPLD,
> so that may be why MTD did not work as well.

even if your problem is solved I'd like to understand this performance issue.
I had a look into the datasheet of the S29GL Mirrorbit flash by Spansion as an example. They provide a dedicated pin RY/BY#, which signals the end of an embedded algorithm (erase or programming). While figure 11.9 shows no timing advance of RY/BY# against Dout on the data line, figure 11.12 has one of unspecified length between RY/BY# and the end of data toggling.

If you had a 10-fold slowdown with MTD, either the CPLD really slows down the read access to the flash or maybe your custom driver uses some acceleration (write buffer programming,
unlock bypass, accelerated program with 12V on the WP#/ACC pin) while MTD does not.

Which kernel version and flash device did you use in this comparsion?


Regards,
Jörg.
