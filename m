Message-ID: <3840DD4D.E3B73A3E@wanadoo.fr>
Date: Sun, 28 Nov 1999 08:44:13 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Dan Bethe <dan_bethe@yahoo.com>
CC: linuxppc-dev@lists.linuxppc.org, Michael <michael.fenske@arcormail.de>
Subject: Re: missing atyfb option in kernel 2.2.14pre9
References: <19991127233137.24145.rocketmail@web1004.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Bethe wrote:
> 
>         I would appreciate it if the members of the list
> would answer the following issue in detail, because
> I'm intending to organize all Powerbook documentation
> for www.linuxppc.org.  Thanks!
> 
> --- Michael <michael.fenske@arcormail.de> wrote:
> >
> > If I do 'make menuconfig' with the source from
> > linuxcare.com.au version
> > 2.2.14pre9, I can't select the atyfb driver, because
> > there is no option
> > for this driver. Who has stolen this option ;-)

It is there. It used to be there twice, once in the list of standard PPC
video cards, and once in the list of experimental FB drivers. It is now
classified "experimental", so you see the option only if you choose
"Prompt for development and/or incomplete code/drivers" in the "General
setup" menu.
 
>         I second that question, from a slightly different
> angle.  I have been collecting the kernel source from
> mirrors of the official kernel.org.  I get mine from
> the SunSITE mirror on ftp.cdrom.com.  When I do either
> 'make menuconfig' or 'make xconfig', I notice that
> under the "console" section, there are two entries for
> "ATI Mach 64".  They are both identical, they're both
> selected, and I cannot change their selections!

This is a different story from the above. In fact, I think in 'make
menuconfig' you *can* change the selections, only in 'make xconfig' it
doesn't work. But then I may not have the same kernel version as you. 

In any case, this has been a long-standing bug in the script files in
/usr/src/linux/scripts. It is fixed in the most recent kernels. If you
want to fix it in an older kernel version, either get the
/usr/src/linux/scripts directory from a more recent kernel or go to the
file drivers/video/Config.in and comment out all but one occurrence of
CONFIG_FB_ATY, in particular the one in an  'if [ "$ARCH" = "sparc64" ]'
clause. The latter one is responsible (together with the script bug)
that the selections are not changeable.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
