Message-ID: <3678D608.D37B7D6E@siemens.at>
Date: Thu, 17 Dec 1998 10:59:36 +0100
From: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
MIME-Version: 1.0
To: dmalek@jlc.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems starting up system on a MPC823FADS
References: <H0000b360900f795@MHS>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


dmalek@jlc.net wrote:
> 
> Message-Id: <367833C4.60C22371@jlc.net>
> Date: Wed, 16 Dec 1998 17:27:16 -0500
> Subject: Re: Problems starting up system on a MPC823FADS
> References: <36750901.A3E0E6D1@siemens.at>
> Sender: dmalek@jlc.net
> FROM: dmalek@jlc.net
> TO: helmut.buchsbaum@siemens.at
> CC: linuxppc-dev@lists.linuxppc.org
> Encoding: 49 text
> 
> Helmut Buchsbaum wrote:
> 
> > 3) Setting up MMU works fine, the kernel initializes SMC1 (my console)
> > and SMC2 for UART and SCC2 for ethernet (I adopted Dan's drivers for the
> > MPC823, wasn't a big deal ;-)
> 
> Sorry about that.  I have recently finished an 821, 823, and 850
> port to several boards.  I am sitting on lots of configuration changes
> like this.  It was easy to just hack the files, but now I have to
> make the config process work.  That is going to take longer
> than the other changes :-(.  I hope to have it done as a new year
> treat for everyone!
> 

I've done some configuration changes, too. I adopted arch/ppc/config.in
to support MPC823 (CONFIG_823) and added  CONFIG_FADS (wich I found in
your sources) to the machine types. I admit I didn't care about any
other 8xx variants :-( but I tried to bring in all modifications and
additions with appropriate #define's. So I'd be interested in your
configurational changes!


> > Now the kernel tries to load & exec /sbin/init and /lib/ld.so.1. Loading
> > via nfs seems to work fine (haven't had any trouble with this part) but
> > when the kernel sets up the memory for this process I realized a strange
> 
> Yes.  I and others have seen this on the FADS boards.  I don't
> yet understand it since the same software will run on other boards.
>

I tracked down some strange behaviour regarding my dear fried 'printk'
and discovered erratic behaviour when using the data cache of my MPC823.
Since I think I had even problems using the instruction cache -
unfortunately not reproducable - I turned off any cache and - wow - my
data were consistent again! Nevertheless my MPC823FADS refuses to
execute /sbin/init, but since my confidence in MPC823 Rev.0 (!!!)
vanished completely, I ordered an upgrade to the latest processor
revision at Motorola (since there are troubles with the built in
video-controller, too!). Hopefully I get the samples before Xmas to be
able to start my investigations again ;-) 
 

BTW, to load my compressed kernel image, the Makefile (make zImage) in
arch/ppc/boot adds a section containing the image to the boot code. My
MPC8BUG refuses to download that section, it just silently ignores it. I
circumvented this problem by compiling in the image via 'od' and 'sed'
magic.  Do you know any possibility to get MPC8BUG to load the
additional section?


--  Helmut


*********************************************************
* Helmut Buchsbaum               * Siemens AG Austria   *
* Tel:   ++43-1-1707-36686       * EZE PN 5             *
* Fax:   ++43-1-1707-55169       * Erdberger Laende 26  *
*                                * A-1030 Vienna/Europe *
*********************************************************
* mailto:Helmut.Buchsbaum@siemens.at                    *
*        buc@eze22.siemens.co.at                        *
*********************************************************

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
