Message-ID: <4097F32F.6090504@ntlworld.com>
Date: Tue, 04 May 2004 20:46:55 +0100
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Simple module, but won't build
References: <20040504191010.98E50C109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

Wolfgang Denk wrote:
>
> Seems you are missing to include some necessary header  files  and/or
> to provide the necessary compiler options.

I am taking a driver I wrote for a 2.4.2 kernel, built with 2.95.x
compiler and trying to port it to 82xx from 8xx and use the new ELDK.

Since it is so simple, it just writes to a mem mapped I/O port to set
some LED's on/off, I assumed it would be pretty simple. But alas, that
was probably a bad assumption on my part.

The main module includes the following:

   linux/module.h
   linux/fs.h
   asm/io.h
   asm/uaccess.h

in that order.

I have grep'ed for CONFIG_KERNEL_START and CONFIG_TASK_SIZE and the only
place I can find them defined is in the kernel source .config (and
default config files for each board). Not in any of the header files.

Maybe I am sposed to #define them myself - I tried that and it worked -
but would like a more automagic solution if there is one!

Command line options are:

   -D__KERNEL__ -DMODULE -Wall -fno-builtins -O -c


>
> It's difficult to guess what  exactly  is  missing  given  so  little
> information.

Sorry, yes.

Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
