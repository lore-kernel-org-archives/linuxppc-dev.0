From: acmay@acmay.homeip.net
Date: Tue, 24 Jul 2001 00:38:52 -0700
To: Gwyn Judd <b.judd@xtra.co.nz>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: make dep fails at acpi
Message-ID: <20010724003852.B28401@sink.san.rr.com>
References: <20010724151400.A25666@thislove>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010724151400.A25666@thislove>; from b.judd@xtra.co.nz on Tue, Jul 24, 2001 at 03:14:00PM +1200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 24, 2001 at 03:14:00PM +1200, Gwyn Judd wrote:
>
> This is from the kernel source recently rsync'd from mvista. 'make dep'
> fails like this about 10 seconds in:
>
>
> make -C acpi fastdep
> make[4]: Entering directory `/home/gwyn/Projects/kernel/drivers/acpi'
> gcc -D__KERNEL__ -I/home/gwyn/Projects/kernel/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
> -D_LINUX -I/include -E -D__GENKSYMS__ acpi_ksyms.c
> | /sbin/genksyms  -k 2.4.7 >
> /home/gwyn/Projects/kernel/include/linux/modules/acpi_ksyms.ver.tmp
> acpi_ksyms.c:27: acpi.h: No such file or directory
> acpi_ksyms.c:28: acdebug.h: No such file or directory

Short answer update your version of make.

Notice the -I/include and the fact the headers are missing.
The acpi stuff uses -I$(CURDIR)/include. I don't think older versions of make
don't support this. You could hack the make files to not use this
if you don't want to update make.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
