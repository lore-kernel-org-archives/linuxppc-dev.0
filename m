Date: Thu, 14 Aug 2003 19:44:06 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 CONFIG_BOOT_LOAD undefined
Message-ID: <20030814174406.GB5270@suse.de>
References: <20030813075108.GA25714@suse.de> <20030814160526.GS807@ip68-0-152-218.tc.ph.cox.net> <20030814164518.GA24671@suse.de> <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20030814165403.GT807@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Thu, Aug 14, Tom Rini wrote:

> The problem is that PPC_MULTIPLATFORM does not go into
> arch/ppc/boot/simple/, except for one file.  The log you posted shows it
> trying to link a zvmlinuz in there.
>
> By chance do all of your tools meet the requirements in
> Documentation/Changes  ?  Assuming that's been kept up to date.

Yes, it is uptodate, SuSE 8.2.

I found that it goes into /simple/ only once, and that fails.

  208  cp -av .config ../config.foo
  209  make distclean
  210  l
  211  cp ../config.foo .config
  212  /usr/bin/time make oldconfig zImage modules modules_install INSTALL_MOD_PATH=`pwd` &>log
fails
  213  w
  214  o log
  215  make zImage
succeeds
  216  rm -fv arch/ppc/boot/simple/*.o
  217  make zImage
succeeds
  218  history

That makes we wonder, 'make oldconfig zImage' is different from 'make zImage'?
Must be some dependency problem.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
