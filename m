Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4D131DDF51
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 08:47:46 +1000 (EST)
Message-ID: <46770B8A.40109@am.sony.com>
Date: Mon, 18 Jun 2007 15:47:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
References: <951969d2021fe6e78917ef8bdb47cf6f@bga.com>
In-Reply-To: <951969d2021fe6e78917ef8bdb47cf6f@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> On Sat Jun 16 08:07:06 EST 2007, Geoff Levand wrote:

>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -41,11 +41,13 @@ zliblinuxheader := zlib.h zconf.h zutil.
>>  $(addprefix $(obj)/,$(zlib) gunzip_util.o main.o): \
>>         $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix 
>> $(obj)/,$(zlibheader))
>>
>> +src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
>> +
>>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c 
>> flatdevtree_misc.c \
>>                 ns16550.c serial.c simple_alloc.c div64.S util.S \
>>                 gunzip_util.c elf_util.c $(zlib) devtree.c \
>>                 44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c
>> -src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>> +src-plat := $(src-plat-y) of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>>                 cuboot-ebony.c treeboot-ebony.c prpmc2800.c
>>  src-boot := $(src-wlib) $(src-plat) empty.c
> 
> The policy so far has been code for all platforms is compiled for all 
> invocations of make in the boot directory.  Therefore just add your 
> files directly to src-plat.  If needed, add a flags override to set the 
> cpu type.


OK, I can do that.  I don't think it is a good way, but I will do it.


>> -$(obj)/zImage.ps3: vmlinux
>> -       $(STRIP) -s -R .comment $< -o $@
>> +$(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) 
>> $(srctree)/$(src)/dts/ps3.dts
>> +       $(STRIP) -s -R .comment $< -o vmlinux.strip
>> +       $(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
>>
>> -$(obj)/zImage.initrd.ps3: vmlinux
>> -       @echo "  WARNING zImage.initrd.ps3 not supported (yet)"
>> +$(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits) 
>> $(srctree)/$(src)/dts/ps3.dts $(obj)/ramdisk.image.gz
>> +       $(call 
>> cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)
> 
> The separate rule here is to pick up ps3.dts, correct?
> 
> After Marc's 3 patch series this would be handled by the config file.
 

Yes, these rules will need to be re-worked, but the current form 
will continue to work with those changes.


>> + * __system_reset_overlay - The PS3 first stage entry.
>> + *
>> + * The bootwraper build script copies the 0x100 bytes at symbol
>> + * __system_reset_overlay to offset 0x100 of the rom image.
>> + */
>> +
>> +       .globl __system_reset_overlay
>> +__system_reset_overlay:
>> +
>> +       /* Switch to 32-bit mode. */
>> +
>> +       mfmsr   r9
>> +       clrldi  r9,r9,1
>> +       mtmsrd  r9
>> +       nop
>> +
>> +       /* Get thread number in r3 and branch. */
>> +
>> +       mfspr   r3, 0x88
>> +       cntlzw. r3, r3
>> +       li      r4, 0
>> +       li      r5, 0
>> +       beq     1f
>> +
>> +       /* Secondary goes to __secondary_hold in kernel. */
>> +
>> +       li      r4, 0x60
>> +       mtctr   r4
>> +       bctr
>> +
>> +       /* Primary waits for __secondary_hold_acknowledge. */
>> +1:
>> +       li      r5, 0x10 /* __secondary_hold_acknowledge */
>> +       or      28, 28, 28 /* db8cyc */
>> +
>> +       ld      r4, 0(r5)
>> +       cmpdi   r4, 0
>> +       beq     1b
> 
> (1) The address of __secondary_hold_acknowledge is not stable.  It has 
> changed in the past and may change in the future.  (2) This works 
> because you always have exactly 2 cpus, and your secondary cpu is not 
> id 0.


Yes, it is simplified and PS3 specific.


> Because this is part of the kernel source tree, I'm not opposed to this 
> usage, but I think some checking would be in order.   A comment that 
> this only works for two cpus with the slave id not being 0, and some 
> check that nm on the kernel image results in the expected symbol and 
> value.


I can make it work without using __secondary_hold_acknowledge by just
using a delay, but it is not as precise.


> Since I'm here, I'll mention that the li to r5 doesn't need to be in 
> the loop.  In fact, the load to r4 could be expressed as 0x10(0) or 
> better create a symbol and use secondary_ack@l(0) eliminating the need 
> for r5 and easing the above check.


Seems like a cleaner way, but I don't think it is a good idea to use 
__secondary_hold_acknowledge if it is not well known, so I will avoid
its use.


>> +
>> +       /* Primary goes to _zimage_start in wrapper. */
>> +
>> +       lis     r4, _zimage_start at ha
>> +       addi    r4, r4, _zimage_start at l
>> +       mtctr   r4
>> +       bctr
>> +
>> +/*
>> + * __system_reset_kernel - Place holder for the kernel reset vector.
>> + *
>> + * The bootwrapper build script copies 0x100 bytes from offset 0x100
>> + * of the rom image to the symbol __system_reset_kernel.  At runtime
>> + * the bootwrapper program copies the 0x100 bytes at 
>> __system_reset_kernel
>> + * to ram address 0x100.  This symbol must occupy 0x100 bytes.
>> + */
>> +
>> +       .globl __system_reset_kernel
>> +__system_reset_kernel:
>> +
>> +       . = __system_reset_kernel + 0x100
> 
> Not bad.   Since this code doesn't have to be at any particular 
> location when it is built (you have no .org or similar, its all PIC), I 
> don't see anything that couldn't be done from an asm block in the 
> platform .c file, like the entry point in prpmc2800.c file; that would 
> save a file in the boot directory.  


For me that would be a significant effort, and I don't think I can
consolidate them for 2.6.23.  I will consider it for 2.6.24.


>> +BSS_STACK(4096);
>> +
>> +/* A buffer that may be edited by tools operating on a zImage binary 
>> so as to
>> + * edit the command line passed to vmlinux (by setting 
>> /chosen/bootargs).
>> + * The buffer is put in it's own section so that tools may locate it 
>> easier.
>> + */
>> +static char cmdline[COMMAND_LINE_SIZE]
>> +       __attribute__((__section__("__builtin_cmdline")));
>> +
>> +static void prep_cmdline(void *chosen)
>> +{
>> +       if (cmdline[0] == '\0')
>> +               getprop(chosen, "bootargs", cmdline, 
>> COMMAND_LINE_SIZE-1);
>> +       else
>> +               setprop_str(chosen, "bootargs", cmdline);
>> +
>> +       printf("cmdline: '%s'\n", cmdline);
>> +}
>> +
>> +static void ps3_console_write(const char *buf, int len)
>> +{
>> +}
> 
> I'm guessing your testing was done with some non-empty function that 
> you are not prepared to release.  Otherwise you would not have added 
> all the printf code.   I'm not complaining, just noting for my 
> observations below.


Someone might be interested in making ps3_console_write() save the
messages to memory and print them later, so I thought it wold be
good to leave the printf's in.


>> +
>> +static void ps3_exit(void)
>> +{
>> +       printf("ps3_exit\n");
>> +       lv1_panic(0); /* zero = no reboot */
>> +       while (1);
>> +}
> 
> Does the hypervisor give some kind of indication that the code paniced? 
>   A comment telling us users what to expect might be nice.


The lpar will be shutdown.  Non-zero will make it reboot.  That is the
documented behavior.  If I get a better idea of what it will do I will
put in a better comment.


>> +void platform_init(void)
>> +{
>> +       extern char _end[];
>> +       extern char _dtb_start[];
>> +       extern char _initrd_start[];
>> +       extern char _initrd_end[];
>> +       const u32 heapsize = 0x1000000 - (u32)_end; /* 16MiB */
> 
> Ok your heap is from (wrapper) _end to 16MiB.
> 
>> +       void *chosen;
>> +       unsigned long ft_addr;
>> +       u64 rm_size;
>> +
>> +       console_ops.write = ps3_console_write;
>> +       platform_ops.exit = ps3_exit;
>> +
>> +       printf("\n-- PS3 bootwrapper --\n");
>> +
>> +       simple_alloc_init(_end, heapsize, 32, 64);
>> +       ft_init(_dtb_start, 0, 4);
> 
> Ok this is the end of platform_init for most platforms.
> 
>> +
>> +       chosen = finddevice("/chosen");
>> +
>> +       ps3_repository_read_rm_size(&rm_size);
>> +       dt_fixup_memory(0, rm_size);
> 
> this is dt_fixups.
> 
>> +
>> +       if (_initrd_end > _initrd_start) {
>> +               setprop_val(chosen, "linux,initrd-start", 
>> (u32)(_initrd_start));
>> +               setprop_val(chosen, "linux,initrd-end", 
>> (u32)(_initrd_end));
>> +       }
> 
> This is part of prep_initrd.
> 
>> +
>> +       prep_cmdline(chosen);
>> +
>> +       ft_addr = dt_ops.finalize();
>> +
>> +       ps3_copy_vectors();
>> +
>> +       printf(" flat tree at 0x%lx\n\r", ft_addr);
>> +
>> +       ((kernel_entry_t)0)(ft_addr, 0, NULL);
>> +
>> +       ps3_exit();
>> +}
> 
> Based on past comments, I belive that you are not calling the normal 
> _start() specifically to avoid dragging in zlib.  Oh, but you call 
> prep_cmdline, which means you still get main.c and it drags zlib.  I 
> guess we should move prep_initrd and prep_cmdline.  Were you just 
> skipping prep_kernel?


I was hoping to eventually get rid of most of the unused stuff that 
is now linked in, but for now I just need something working.


> This code and the concept in your .lds file looks like it could be used 
> by other platforms in a generic way
> (except for the call to ps3_exit which should be exit, and the call to 
> ps3_copy_vectors, which can be moved earlier.  While its likely similar 
> functionality would be needed, the details of what to patch and copy 
> may vary).


I did try to make it generic in my initial RFC's but it wasn't well
received, so I just went with a platform specific approach and tried
to simplify it.


>> --- /dev/null
>> +++ b/arch/powerpc/boot/zImage.ps3.lds.S
>> @@ -0,0 +1,50 @@
>> +OUTPUT_ARCH(powerpc:common)
>> +ENTRY(_zimage_start)
>> +EXTERN(_zimage_start)
>> +SECTIONS
>> +{
>> +  _vmlinux_start =  .;
>> +  .kernel:vmlinux.bin : { *(.kernel:vmlinux.bin) }
>> +  _vmlinux_end =  .;
>> +
>> +  . = ALIGN(8);
>> +  _dtb_start = .;
>> +  .kernel:dtb : { *(.kernel:dtb) }
>> +  _dtb_end = .;
>> +
>> +  . = ALIGN(4096);
>> +  _initrd_start =  .;
>> +  .kernel:initrd : { *(.kernel:initrd) }
>> +  _initrd_end =  .;
>> +
>> +  _start = .;
>> +  .text      :
>> +  {
>> +    *(.text)
>> +    *(.fixup)
>> +  }
>> +  _etext = .;
>> +  . = ALIGN(4096);
>> +  .data    :
>> +  {
>> +    *(.rodata*)
>> +    *(.data*)
>> +    *(.sdata*)
>> +    __got2_start = .;
>> +    *(.got2)
>> +    __got2_end = .;
>> +  }
>> +
>> +  . = ALIGN(4096);
>> +  _edata  =  .;
>> +
>> +  . = ALIGN(4096);
>> +  __bss_start = .;
>> +  .bss       :
>> +  {
>> +   *(.sbss)
>> +   *(.bss)
>> +  }
>> +  . = ALIGN(4096);
>> +  _end = . ;
>> +}
> 
> You don't seem to relocate the initrd.  Your lds file has the initrd on 
> the 4k page boundary after the dtb, which is after the kernel as copied 
> by objcopy -O binary.  As far as I know, objcopy only copies the load 
> sections; it doesn't create space in the output binary image for alloc 
> only sections.  What prevents the initrd from being in the kernel bss, 
> which it clears before even looking at the device tree?  For that 
> matter, what prevents the device tree from being allocated in this bss 
> range?


Yes, a point I missed.  I think it is easier to just make objcopy output
the bss, so that is what I'll do for now.  

    objflags="-O binary --set-section-flags=.bss=contents,alloc,load,readonly,data"

I'll consider doing a relocation later.


> I'm guessing that you tested with some additional code to display the 
> console output, which made _end be above the kernel _end, or close 
> enough that the finalized bss was above the kernel _end?  Did you test 
> an initrd?  I guess an attached initrd would also solve the problem of 
> the final dtb being overwritten, but not the start of the initrd.


No, I did not test initrd, so it is still todo.


> I think your approach to the image layout has promise but still needs 
> some refinement.  To solve the problem of where is the kernel end, I 
> would create a section to hold the kernel elf header and use the 
> elf_parse routines that are now conveniently in a separate file.  The 
> wrapper script would dd off the header and then it would be linked into 
> the wrapper like the other sections.  At that point the initrd could be 
> moved before creating the malloc pool above it.


OK, I'll consider it.

 
> This approach can be used whenever there is something capable of 
> installing an image at address 0 in ram before starting its execution, 
> and is useful when the time to install that image is less than the time 
> to decompress the kernel (and copy either it or the zImage, for the 
> case where the entry point is fixed in low memory).  I can think of 
> other platforms where this holds true.  In your case, this is true 
> because the hypervisor decompresses the image.
> 
> What should this type of image be called?  Its not really a zImage, 
> since there is nothing compressed (well, maybe the initrd/initramfs).  
> uImage is already taken (u would have stood for uncompressed).  
> Something like wrapped image?  flat image?  combined image?  We'd still 
> do make zImage to invoke make for it.


At this point I just want to get my platform code included so distros
can start to use it.  I don't want to turn this patch into an effort to
provide a new generic kernel infrastructure.  That should be a different
effort, then when that is ready we can switch this code over.


> One more point.  You indicated that this image had a standard entry 
> point.  Were you thinking it will be used for kexec?  Or were you just 
> trying to state you used the library _zimage_start?  


I was thinking kexec.  My initial work was to add zImage support to
kexec, but I dropped that to focus on getting the bootwrapper and
kexec of vmlinux working.  I have no plan to restart that work
so will drop that part of the comment.
 

I'll send out an updated patch.

-Geoff
