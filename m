From: jtm@smoothsmoothie.com
Date: Thu, 22 Feb 2001 14:42:53 -0600
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems
Message-ID: <20010222144252.E21811@shamus.smoothsmoothie.com>
References: <20010222082318.71ACE281D9@denx.denx.de> <3A9564BC.D8C08CA5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A9564BC.D8C08CA5@mvista.com>; from dan@mvista.com on Thu, Feb 22, 2001 at 02:13:00PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 22, 2001 at 02:13:00PM -0500, Dan Malek wrote:
> ...and you will have to modify arch/ppc/mbxboot/embed_config.c because
> the 8260 may not expect a boot rom to hand it a bd_info.  I don't
> remember how I left it......it may just fill in some hard coded values.

I didn't have to do it. If this is the code you were talking about:
#if 0
        /* This is actually provided by my boot rom.  I have it
         * here for those people that may load the kernel with
         * a JTAG/COP tool and not the rom monitor.
         */
        bd->bi_baudrate = 115200;
        bd->bi_intfreq = 200;
        bd->bi_busfreq = 66;
        bd->bi_cpmfreq = 66;
        bd->bi_brgfreq = 33;
        bd->bi_memsize = 16 * 1024 * 1024;
#endif

It's ifdeffed out, as you can see.

Once I fixed my problem with the bd_info struct, it worked
great.


--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
