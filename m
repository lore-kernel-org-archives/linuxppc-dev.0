To: mpc@mail2000.com.tw
Cc: "=?big5?B?bGludXhwcGMtZW1iZWRkZWQ=?=" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: =?big5?B?RGVidWcgcHBjbGludXggd2l0aCBCREkyMDAw?= 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 May 2001 02:55:48 +0800."
             <989520948.8638.mpc@mail2000.com.tw>
Date: Thu, 10 May 2001 21:44:30 +0200
Message-Id: <20010510194435.5CB352814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <989520948.8638.mpc@mail2000.com.tw> you wrote:
>
>  I followed the procedure mentioned in BDI's manual
>  (Sec3.3.4, P29).
>  I just type 'load' on BDI's telnet terminal to load
>  target zImage file(arch/ppc/mbxboot/zImage).
>  After that BDI shows:
>  "File offset 0x00010000 to address 0x00210000 size
>   514200"
>  Then I type "go 0x00210000" on BDI's telnet terminal.
>  However, nothing happened!!

Of course something happened: your kernel crashed.

>  I can not get any responce from serial console.
>  Did I lose something?

Yes.  The  Linux  kernel,  even  with  the  mbxboot  bootstrap  stuff
attached,   is  not  a  standalone  program.  It  expects  a  lot  of
initialization to be done  by  the  firmware,  and  some  information
passed, too.

I don't see why you go such a difficult route.

Both PPCboot and Linux are running out of the  box  on  the  TQM8xxL.
Just install and run.

If you want to debug your own kernel modifications, you can still use
PPCBoot to load and start the kernel - but remember that PPCBoot does
not use zImage files, it uses it's own image format instead.

A simple but efficient way to enter the debugger  _after_  Linux  has
started  and  the  MMU  has  been  turned on is to set an instruction
breakpoint for the address range 0xC0000000 ... 0xC1000000  (use  the
"BI" command at the telnet prompt to do so).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
