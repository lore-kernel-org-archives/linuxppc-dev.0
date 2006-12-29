Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by ozlabs.org (Postfix) with ESMTP id CDBF1DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Dec 2006 11:34:41 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so2241231nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Dec 2006 16:34:39 -0800 (PST)
Message-ID: <198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>
Date: Fri, 29 Dec 2006 00:34:39 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: regarding kgdb in ppc
In-Reply-To: <458E384A.108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>
	<12c9fc1a0611292033p1c0ae010iadcf6afdd4a549ce@mail.gmail.com>
	<d16b1c80611300036x36ec0009r2eb20ebbc6966a97@mail.gmail.com>
	<12c9fc1a0611300924r406e95acie5c2053c1433ab33@mail.gmail.com>
	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>
	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>
	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>
	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>
	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>
	<458E384A.108@gmail.com>
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm facing the same problem for almost two weeks and still don't have
a clue. Please keep me in the thread. Thanks!

- Reeve

On 12/24/06, sudheer <urwithsudheer@gmail.com> wrote:
>
>  Hello All
>
>
> Hi Shakti
>
>
>
> > > Then executed the command mkinird and copied and added  initrd in the
> > > grub.conf - situation is same.
> > > I changed the root parameter to LABEL=/ - situation is same.
> >
> > Basically, block device, initrd support for ramdisk should be enabled:
> >   CONFIG_BLK_DEV_RAM
> >   CONFIG_BLK_DEV_INITRD
> >
> > Double check your .config file.
> >
>
>  I have checked all the above and are enabled in the config.  I have tried
> changing the kernel command line argumnets.
>
>  I get the same error saying:  (All from init/main.c)
>  ----
>  unable to open an initial console
>  No init found.  Try passing init= option to kernel.
>  -----
>  I am able to debug the kernel on x86 systems. Thanks for all the support.
>
>  Now I am working with  kgdb on mpc8540 board.
>  target kernel version - linux-2.6.13
>  KGDB version - linux-2.6.13-kgdb-2.3
>
>  I am getting the following error:
>
>  root@localhost sudheer]# /opt/eldk-3.1.1/usr/bin/ppc_85xx-gdb vmlinux
>  GNU gdb Red Hat Linux (6.3.0.0-1.21_1rh)
>  ...
>  This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux"...
>  (gdb) set remotebaud 115200
>  (gdb) target remote /dev/ttyS0
>  Remote debugging using /dev/ttyS0
>  Ignoring packet error, continuing...
>
>  On the target side, i could see that the target kernel kgdb waiting for
> host communication.
>
>  On the target board with  kernel version - linux-2.6.13 , I could boot it
> only after applying the patches:
>  1. Gain_Phy_update
>  2.patch-2.6.14-rc5
>  3.Phy_Platform_Update
>  The patch-2.6.14-rc5  when applied , deleted the file
> arch/ppc/platforms/pcore.c and
>  pcore.h but the kernel boots well.
>
>  In the KGDB version - linux-2.6.13-kgdb-2.3
>  The ppc-lite.patch tries to modify the pcore.c which is not available.
>
>  I am not sure wether this affects the serial communication establishment.
>
>  Please help me to solve this.
>
>  Thanks
>  Sudheer
>
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
