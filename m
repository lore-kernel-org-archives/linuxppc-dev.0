To: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: printk logbuf relocation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Feb 2004 23:33:31 +0530."
             <903E17B6FF22A24C96B4E28C2C0214D7012BB481@sr-bng-exc01.int.tsbu.net>
Date: Thu, 12 Feb 2004 22:34:29 +0100
Message-Id: <20040212213434.59335C1098@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <903E17B6FF22A24C96B4E28C2C0214D7012BB481@sr-bng-exc01.int.tsbu.net> you wrote:
>
> Hi ,
>
>   On our MPC7447+MV64360 board running Linux {both 2.4.18_mvl30 MontaVista
> PE3.0 & 2.4.20 from kernel.org} we need to carry out an experimentation.
> This  is when the board does not have any serial interface and Linux may
> hang at boot-up. The contents of printk that are logged in the log-buf are
> adequate to provide the required information. This section of memory can be
> read on next boot up. {Though this is in RAM , by turning off ECC &
> Scrubbing , we could see the contents on a reboot in the firmware which has
> a way to provide this memory dump over a PCI connection}. We could do up
> till this but the real problem starts now.
>
>   The log-buf lies in the region of memory where our firmware {a proprietary
> one } sits , so even if scrubbing is off , this overrides the logbuf
> contents. Relocating the firmware is ruled out due to other restrictions. So

We did this with U-Boot and Linux. U-Boot will pre-allocate  the  log
buffer at the very end of the RAm, and both U-Boot and Linux will use
the  same  logbuf  area.  See  the  CONFIG_LOGBUFFER  option  in  the
linux-2.4 kernel tree on our CVS server.

This  allows  to  pass  information  (hardware  diagnostics,  startup
messages)  from  the  firmware  to Linux (which will pick it up using
standard syslog tools), or to read or reset the Linux log  buffer  in
U-Boot.

If running U-Boot on your board is not an option you might be able to
copy the mechanism (if your proprietary firmware is GPL, that is).

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you believe that feeling bad or worrying long enough will change a
past or future event, then you are residing on another planet with  a
different reality system.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
