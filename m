Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id CFBBEDDE41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 15:23:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLALV-0002b4-J4
	for linuxppc-embedded@ozlabs.org; Mon, 21 Jul 2008 22:23:33 -0700
Message-ID: <18582612.post@talk.nabble.com>
Date: Mon, 21 Jul 2008 22:23:33 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <200807181739.10268.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I am getting kernel panic while trying these as suggested by you ,the
following points will elaborate my concern :-

My circular buffer defination is this :-
/* Frame */
typedef struct
{
	char buffer[SIZE_FRAME];
	unsigned int count;
}frame_S;

/* Circular Buffer Structured */
/* Mmaped area Structure */
typedef struct
{

	frame_S  fluke[NO_FRAMES];
	unsigned int count_index;
	unsigned int read_index;
	unsigned int write_index;

}circularbuffer_S;

circularbuffer_S   *buf_area=NULL;

i am allocating memory using vmalloc and remaping to the SDRAM area as :-

buf_area = vmalloc(sizeof(circularbuffer_S));
	if(!buf_area)
	{
		printk(KERN_ALERT"vmalloc failed \n");
		return -1;
	}

	buf_area = (circularbuffer_S *)ioremap(7700000,900000);
	if(!buf_area)
	{
		printk(KERN_ALERT"ioremap failed \n");
		return -1;
	}


mmap Implimentation is this :-

unsigned long start = vma->vm_start;
	unsigned long size = vma->vm_end - vma->vm_start; //0x900000;
	unsigned long phy_add = virt_to_phys(buf_area); //0x7700000;
	int ret = 0;

	/* Make the mmaped area noncacheable */
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

	/* Set the Flags to give permissions to Mmaped area */
	vma->vm_flags |=VM_RESERVED;
	vma->vm_flags |=VM_READ;
	vma->vm_flags |=VM_WRITE;
	vma->vm_flags |=VM_IO;
	//vma->vm_flags |=VM_SHARED;
	//vma->vm_flags |=VM_LOCKED;

	printk(KERN_DEBUG"In mmap function\n");

	if(remap_vmalloc_range(vma,buf_area,(phy_add >> PAGE_SHIFT)))
	{
		printk(KERN_ALERT"remap_vmalloc_range failed\n");
		goto mmap_exit;

   	}

I am getting mmap failed .....

some times i am getting this error .......


/***************************************************/

insmod fluke_driver.ko
 Ioremap mapped to virtual 0x0c7900e20
Unable to handle kernel paging request at virtual address c8200e34
pgd = c0444000
[c8200e34] *pgd=85c80011, *pte=00000000, *ppte=00000000
Internal error: Oops: 807 [#1]
Modules linked in: fluke_driver tstamp sig_router mvci_spi mvci_sf_pcd
mvci_sci_unidir_s1 mvci_sci_diff mvci_sci_bidir_s
1 g_ether mvci_rtmd_s1 mvci_kwiso_s1 mvci_kw1281_s1 mvci_kh_s1 mvci_j1850
mvci_gm_sbc mvci_diagh_s1 mvci_dcl mvci_can1 f
pga_conf arcotg_udc adc_dac keypad(F) splc501_lcd(F) cpld
CPU: 0
PC is at FlukeDriverInit+0xe4/0x140 [fluke_driver]
LR is at preempt_schedule+0x48/0x58
pc : [<bf01c0e4>]    lr : [<c0241e98>]    Tainted: GF
sp : c69b9ed0  ip : c69b9e28  fp : c69b9eec
r10: c7862000  r9 : 00000015  r8 : 00000016
r7 : bf01aaa0  r6 : c682a5f0  r5 : bf01ac24  r4 : 00000000
r3 : 00900014  r2 : c7900e20  r1 : c69b8000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: C5387F
Table: 80444000  DAC: 00000015
Process insmod (pid: 1089, stack limit = 0xc69b8250)
Stack: (0xc69b9ed0 to 0xc69ba000)
9ec0:                                     00000000 c682a5c4 c682a5c4
c682a400
9ee0: c69b9fa4 c69b9ef0 c005ec78 bf01c00c 00000000 00000000 00011008
00000000
9f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9f20: 00000000 00000000 00000000 00000000 c78642e8 c6aad200 c7863820
c7863730
9f40: c7863848 00000000 0000006a 0000006a bf01aaac c00485d8 0000000a
c69b8000
9f60: bf01aae8 c7863474 c7863870 00000013 00000000 c0282764 c69b9f9c
00008608
9f80: 00000003 00011018 00000080 c0020f64 c69b8000 00011008 00000000
c69b9fa8
9fa0: c0020de0 c005d7d4 00008608 00000003 00011018 000025e8 00011008
0000002d
9fc0: 00008608 00000003 00011018 00000080 bec38f5e 00000000 00011008
00000000
9fe0: 00004000 bec38d14 000088dc 400db334 60000010 00011018 48010000
00000000
Backtrace:
[<bf01c000>] (FlukeDriverInit+0x0/0x140 [fluke_driver]) from [<c005ec78>]
(sys_init_module+0x14b0/0x1698)
 r5 = C682A400  r4 = C682A5C4
[<c005d7c8>] (sys_init_module+0x0/0x1698) from [<c0020de0>]
(ret_fast_syscall+0x0/0x2c)
Code: eb408e00 e5952000 e59f3058 e1a00004 (e7824003)
 Segmentation fault

/****************************************************/

Please suggest me what could be the problem and how to overcome this and do
my implimentation ....


------Misbah <><

Arnd Bergmann wrote:
> 
> On Friday 18 July 2008, Misbah khan wrote:
> 
>> Now my concern is How can i map SDRAM one to one to circular buffer of
>> such
>> a huge size ???? 
> 
> As I mentioned, use vmalloc to get the memory, and provide an mmap
> function
> that uses remap_vmalloc_range to put it into the user address space.
> 
>> My idea is that i will ioreamp SDRAM and do memcpy_toio() when ever i am
>> writing to the the circular buffer which is dma allocated and pages are
>> set
>> reserved . and read the frame from user space .
> 
> ioremap and memcpy_toio style accesses only make sense for stuff that is
> *not* your main memory. Memory is alrady directly accessible in the kernel
> after allocating with get_free_pages, kmalloc or vmalloc. No need to
> play with __iomem pointers for this.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18582612.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
