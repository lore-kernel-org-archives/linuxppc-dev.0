Date: Thu, 28 Sep 2000 20:14:46 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <39D28B5B.838C4FC8@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0009281937470.7326-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, Michel [iso-8859-1] Dänzer wrote:

>
> Michael Schmitz wrote:
>
> > Nope, the syntax should be OK. Question is does the ati driver parse that
> > option if fb_open_pci is used.
>
> I just rsynced Ani's tree, and the ati driver doesn't. Ani, why not?
>

Only the fbdev and glint drivers use this option, all the others get the
fbdev device from the BusID option, unfortunately fbdev_open_pci() will open
the *first* device that matches the device so if you have more than 2
devices it will map the first one again with bad results.
Geert posted recently a patch recently for fbdev_open_pci so it will do the
right thing (i never tested it though) give it a try.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
