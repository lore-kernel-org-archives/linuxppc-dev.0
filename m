Return-Path: <hector@marcansoft.com>
Message-ID: <4E39F386.8020403@marcansoft.com>
Date: Thu, 04 Aug 2011 03:19:02 +0200
From: Hector Martin <hector@marcansoft.com>
MIME-Version: 1.0
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 02/15] [PS3] Get lv1 high memory region from devtree
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-3-git-send-email-a.heider@gmail.com>
	<4E39CBFC.2010501@infradead.org>
In-Reply-To: <4E39CBFC.2010501@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2011 12:30 AM, Geoff Levand wrote:
> With this mechanism how is the address of the initrd passed to the
> new kernel, in the DT?

Using the /chosen linux,initrd-{start,end} properties. The bootloader
knows about the Linux trick of sticking together bootmem and highmem and
precalculates the linux "physical" address. Yeah, that's a hack, it
should probably be done in the kernel so the bootloader doesn't have to
know or care about how Linux decides to lay out its physical address
space. Do you have any suggestion as to how we would do this sanely?
Right now early_init_dt_setup_initrd_arch in arch/powerpc/kernel/prom.c
is generic and doesn't know anything about platform specifics.

> How would a kexec based bootloader work?  If it's kernel were to allocate
> high mem and the bootloader program uses the high mem, how could it tell
> that kernel not to destroy the region on shutdown?

The current code contemplates the case where a non-kexec based
bootloader is the first stage and allocates highmem (and knows how to
tell the kernel about it), possibly followed by kexec stages that just
keep that allocation. To support a kexec bootloader as the first
bootloader using this mechanism would indeed require extra support to
tell that kernel to retain its allocation, preferably something that can
be decided from userland. Of course the current kexec bootloader
behavior where highmem isn't handed over to the child kernel will still
work.

> If arch/powerpc/boot/ps3.c allocated the mem and added a DT entry
> then other OSes that don't know about the Linux device tree won't
> be able to use that allocated memory.  Other OSes could do a
> test to see if the allocation was already done.  Another option
> that might work is to write info into the LV1 repository then
> have boot code look there for allocated hig mem.

If you're booting another OS that isn't Linux then it also has no use
for a Linux-specific ramdisk (linux,initrd-start) and thus no use for
preallocated highmem and should be booted as such (maybe make the
userland tools tell the kernel to release highmem if there's no initrd
defined).

Using the lv1 repo is an option, but does it make sense? It's even less
standard than a FDT and we'd have to put both the region1 location and
the initrd location in there (there's no point to maintaining highmem if
you aren't going to use it).

FWIW, the lv1 repo writing hypercalls are unused and undocumented.

>> +	if (!map.r1.size) {
>> +		DBG("%s:%d: no region 1, not adding memory\n",
>> +		    __func__, __LINE__);
>> +		return 0;
>> +	}
> 
> Did you find this to be hit?  Also, in the general case,
> there could be more than one high mem region, but I don't
> know of any current systems that do.

Probably only during debugging, but it doesn't sound like a bad idea
anyway (e.g. bootloader allocated highmem but didn't tell the kernel so
the kernel couldn't allocate it).

As for multiple regions, well, currently it only supports one and that
is hardcoded in the phys->lpar translation, so I see no point in
worrying about that now.

ACK on the other code comments.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
