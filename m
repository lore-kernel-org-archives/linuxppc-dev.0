Return-Path: <geoff@infradead.org>
Message-ID: <4E3AF1E4.90407@infradead.org>
Date: Thu, 4 Aug 2011 12:24:20 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH 02/15] [PS3] Get lv1 high memory region from devtree
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-3-git-send-email-a.heider@gmail.com>
	<4E39CBFC.2010501@infradead.org> <4E39F386.8020403@marcansoft.com>
In-Reply-To: <4E39F386.8020403@marcansoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
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

On 08/03/2011 06:19 PM, Hector Martin wrote:
> On 08/04/2011 12:30 AM, Geoff Levand wrote:
>> How would a kexec based bootloader work?  If it's kernel were to allocate
>> high mem and the bootloader program uses the high mem, how could it tell
>> that kernel not to destroy the region on shutdown?
> 
> The current code contemplates the case where a non-kexec based
> bootloader is the first stage and allocates highmem (and knows how to
> tell the kernel about it), possibly followed by kexec stages that just
> keep that allocation. To support a kexec bootloader as the first
> bootloader using this mechanism would indeed require extra support to
> tell that kernel to retain its allocation, preferably something that can
> be decided from userland. Of course the current kexec bootloader
> behavior where highmem isn't handed over to the child kernel will still
> work.
> 
>> If arch/powerpc/boot/ps3.c allocated the mem and added a DT entry
>> then other OSes that don't know about the Linux device tree won't
>> be able to use that allocated memory.  Other OSes could do a
>> test to see if the allocation was already done.  Another option
>> that might work is to write info into the LV1 repository then
>> have boot code look there for allocated hig mem.
> 
> If you're booting another OS that isn't Linux then it also has no use
> for a Linux-specific ramdisk (linux,initrd-start) and thus no use for
> preallocated highmem and should be booted as such (maybe make the
> userland tools tell the kernel to release highmem if there's no initrd
> defined).

This sounds complicated, user programs managing memory regions.

Also, it needs to be considered that a lot of kernels are out
there will be confused if started with high mem already allocated.

> Using the lv1 repo is an option, but does it make sense? It's even less
> standard than a FDT and we'd have to put both the region1 location and
> the initrd location in there (there's no point to maintaining highmem if
> you aren't going to use it).
> 
> FWIW, the lv1 repo writing hypercalls are unused and undocumented.

The hcalls to create, write, and delete nodes are known, but I don't
recall if I verified they work:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/include/asm/lv1call.h;hb=HEAD#l265

#92 should be named lv1_write_repository_node.

You can only modify the repo for your lpar, so:

  lv1_{create,write}_repository_node(n1, n2, n3, n4, v1, v2);
  lv1_delete_repository_node(n1, n2, n3, n4);

-Geoff
