Date: Sun, 23 May 2004 20:34:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Module Compiling Problem
Message-ID: <20040523183459.GA2335@mars.ravnborg.org>
References: <20040522072520.67684.qmail@web15206.mail.bjs.yahoo.com> <20040523020029.65329.qmail@web15212.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040523020029.65329.qmail@web15212.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, May 23, 2004 at 10:00:29AM +0800, Song Sam wrote:
>
> Song Sam <samlinuxppc@yahoo.com.cn> wrote
>
> > A error happened when I compiled a module.Could any warmhearted person
> > figure it out for me?
>
> OK,I did it by myself.:-)
> It turned out to be the fact that I enabled
> CONFIG_MODVERSIONS=y in kernel configuration
> and MODVERSIONS option in my module like
> #if defined(CONFIG_MODVERSIONS)
> #define MODVERSIONS
> #include <linux/modversions.h>
> #endif
> at the same time.They conflicted against each other.Is
> that so?A newbie error on module...

Looks wrong.
When compiling an external module use:
for 2.4:
make -C $ERNELSRC SUBDIRS=$PWD modules

for 2.6: (2.6.6 onwards)
make -C $KERNELSRC M=$PWD

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
