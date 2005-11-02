Return-Path: <wd@denx.de>
To: "KylongMu" <mqy@263.net.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Nov 2005 21:49:57 +0800."
	<20051102135009.27C46102A@smtp.263.net>
Date: Wed, 02 Nov 2005 17:46:44 +0100
Sender: wd@denx.de
Message-Id: <20051102164644.6D167353A2C@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: About 2.6.14 on AMCC Yosemite board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Kylong Mu,

in message <20051102135009.27C46102A@smtp.263.net> you wrote:
> 
> 	I've got my Yosemite board today, it's shows very good by default test.
> I downloaded the 2.6.14 according the repository from your website by cogito.
> with default configure, I boot with the uImage, but the system halt, attachment
> is the message.
> 	I don't know what happen with it, pls help me.
...
> DRAM:  256 MB
> FLASH: 32 MB
---------^^^^^

That's the problem. The board we got from AMCC for the port  and  for
testing  all had 64 MB flash, and there was no information that other
configurations are available too. The MTD mapping driver  ist  a  bit
braindead at the moment and assumes 64 MB. This fails on your board.

The quick and dirty fix is to edit "drivers/mtd/maps/yosemite.c" and
replace the lines:

    ...
     31
     32 #define WINDOW_ADDR 0xfc000000
     33 #define WINDOW_SIZE 0x04000000
     34
    ...

with:

	#define WINDOW_ADDR 0xFE000000
	#define WINDOW_SIZE 0x02000000

We will implement a better fix (automatically adjust values according
to the values pased by the boot loader) later today / early tomorrow.

Sorry for the inconvenience.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If you want strict real-time behavior, run in the real  time  schedu-
ling class.  But there are no seatbelts or airbags;  main(){for(;;);}
can hard hang your system.                          -- Bart Smaalders
