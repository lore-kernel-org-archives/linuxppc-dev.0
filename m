To: Conn Clark <clark@esteem.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx fpu support and compiling glib. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Apr 2002 15:28:35 PDT."
             <3CB60E13.BA0A4A6@esteem.com>
Date: Fri, 12 Apr 2002 15:37:09 +0200
Message-Id: <20020412133714.1AD7C11258@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CB60E13.BA0A4A6@esteem.com> you wrote:
>
> 	I was wondering a few things about MPC8xx FPU support. If
> I build a kernel with fpu-emulation do I have to pass the CFLAGS

That makes only sense when your application AND libraies DO  NOT  use
soft-float.

> "-msoft-float -D_SOFT_FLOAT" when compiling glibc? Does it save me

You cannot mix FPU-code and  soft-float  in  one  application/library
setup.

> any ram if I don't? I know if I don't my performance will drop but
> our aplication doesn't use floating point except for ping mabey.

Ummm... why should soft-float result in _smaller_ code? On contrary -
the code will be bigger, but run faster since you don;t have to  trap
into the kernel for each FP instruction.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To know how another being, another creature feels -  that  is  impos-
sible.                  - Terry Pratchett, _The Dark Side of the Sun_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
