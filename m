Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 20:32:57 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg patches
Message-ID: <20060908033257.GA4351@mag.az.mvista.com>
References: <20060719225356.GA3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719225356.GA3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have respun all the patches in this series and will be submitting them
shortly.

Some things have changed from the previous patches.  In particular, the
guts of the flat dev tree code are now in
<file:arch/powerpc/boot/flatdevtree.[ch]>.  These files are only *copies*
of the files Hollis Blanchard is maintaining so please do not edit them
in the bootwrapper.  The code in those files is still being worked on
so I'm will not submit them in this patch series.  However, I will
start a separate email thread with the current copies so you can
build and so those changes don't hold up the acceptance of these patches.
Just don't surprised if the master code has changed by the time you read
this.

Also changed:
- The 'ops' struct & ptr are gone, now uses
  platform_ops/dt_ops/console_ops directly.
- There are a couple new files.  flatdevtree_env.h has header file
  glue so that flatdevtree.[ch] will compile/work.
  flatdevtree_misc.c contains interface glue between bootwrapper dt
  calls and the implementation in flatdevtree.c, and some functionality
  not provided by flatdevtree.c
- dink.c is renamed to simple_alloc.c because the code isn't dink specific.
- I'm submitting the kernel sandpoint code along with the dts (which I
  didn't do before) because people have asked for it.
- I changed the name of the section that holds the dtb from
  __builtin_fdt to __builtin_ft to match the prefixes used in the
  flatdevtree*.[ch] files.  If you made a script to attach a dtb to a
  zImage like what I emailed before, you'll have to edit it to change
  the section name.

Mark
