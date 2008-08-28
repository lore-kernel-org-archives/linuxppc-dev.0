Return-Path: <vancasperz@yahoo.com.cn>
Received: from n1.bullet.mail.re3.yahoo.com (n1.bullet.mail.re3.yahoo.com
	[68.142.237.108]) by ozlabs.org (Postfix) with SMTP id BAE2EDE227
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 01:25:22 +1000 (EST)
Subject: Re: Why does one "stw" fail with address translation disabled in
	PPC405EP?
From: Zhou Rui <vancasperz@yahoo.com.cn>
To: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
In-Reply-To: <1219691805.6735.63.camel@zr.gii.upv.es>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
	<20080824185547.94A0724899@gemini.denx.de>
	<1219691805.6735.63.camel@zr.gii.upv.es>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2008 17:53:43 +0200
Message-Id: <1219938823.7588.74.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, all:
Well, as described before, the problem happens at "0xc0000434
<InstructionAccess+52>:      stw     r12,64(r11)". At this moment,
address translation is disabled and physical addresses are used, but r11
contains 0x03072da0 which is a physical address out of the range of 0x0
and 0x01ffffff. I check backward and see that value of r11 is from r1 by
tophys(r11,r1). r1 should hold the stack pointer, whose value is in the
form of 0xc3xxxxxx when the problem happens.
In this project, we make use of the concept of domain for high level
OSes above XtratuM kernel. Here Linux is the root domain and the problem
happens when we tries to load and transfer to a testing domain which
just prints some sentences, and 0x100000a0 is the entry point of the
testing domain, so we need to execute this address. We define a struct
domain_t for the domain and the stack pointer is achieved by:
....
  d->sstack_st = vmalloc (DEFAULT_SSTACK_SIZE); /* DEFAULT_SSTACK_SIZE
is 0x1000 */

  if (!d->sstack_st) {
    destroy_domain (d);
    id = -OUT_OF_MEMORY;
    goto exit_load_domain;
  }

  d->sstack = (unsigned long *)((unsigned long)d->sstack_st +
DEFAULT_SSTACK_SIZE); /* sstack is the new domain's stack pointer that
will be moved to r1 */

After doing this, sstack will get the value of 0xc3xxxxxx.

Shouln't I use vmalloc here? Or are there any other solution?

Thanks in advance for any advice!

Best Wishes

Zhou Rui
2008-08-28

Âú® 2008-08-25‰∏ÄÁöÑ 21:16 +0200ÔºåZhou RuiÂÜôÈÅìÔºö
> Hi,
> I think maybe you have known this project named XtratuM
> (http://www.xtratum.org). I'm porting it from x86 to PPC405. The
> implementation on PPC440 has been basically finished
> (ftp://dslab.lzu.edu.cn/pub/xtratum/xtratum-ppc/snapshots/xtratum-ppc-20071205.tar.bz2) and I know there was discussion about it in this mail list before. XtratuM is an ADEOS based nano kernel. It aims for realtime and is designed to provide virtual timer, virtual interrupt and memory space sperations for domains. Each domain is loaded by a userspace program (instead of the root domain as a kernel module) and the loader will load the domain's (ELF staticly excutable) PT_LOAD section into memory, and then raise a properly system call (passing the structurized loaded data as arguments) to load the domain via load_domain_sys() of XtratuM, and at the last step of loading the domain, xtratum will jump to the entry code of the new domain(asm wrappered start() routine) and then everything should be fine. 0x100000a0 is the entry point of the test domain, and that is why I need to start execution from it.
> 
> I think I can say something of my analysis so far for the cause of my
> problem. Thanks for the mention of memory size. Once the kernel module
> of XtratuM is loaded, the symbols of it are placed to virtual addresses
> like 0xc3xxxxxx. Because in normal state, address translation is enabled
> (MSR[IR, DR] = [1, 1]), these addresses are okay. However, when loading
> the domain, because the entry point 0x100000a0 is not in TLB and it
> should be reloaded, Data TLB Miss Exception arises and DTLBMiss is
> called. The exception clears MSR[IR, DR], so address translation is
> disabled and physical address should be used at this moment. If we want
> something at the virtual address of 0xc3xxxxxx, we must access the
> physical addresses like 0x03xxxxxx. Nevertheless, the limitation of 32MB
> memory makes the valid physical address range from 0x0 to 0x1ffffff.
> Therefore, during the exception handling, the addresses out of range
> should not be accessed, but the instructions cannot know the memory
> limitation in advance and tries to do something in addresses such as
> 0x03072da0 based on the address translation mechanism, which leads to
> machine check.
> I haved tried to append "mem=32M" to kernel command line but no help. I
> think it is because when loading the kernel in normal state, address
> translation is enabled and the virtual addresses are okay. Kernel cannot
> foresee that there is going to be a TLB miss exception and the illegal
> physical addresses like 0x03xxxxxx may be accessed.
> 
> So any ideas for this problem are welcome.
> 
> Thank you very much for taking care.
> 
> Best Wishes
> 
> Zhou Rui
> 2008-08-25
> 
> Âú® 2008-08-24Êó•ÁöÑ 20:55 +0200ÔºåWolfgang DenkÂÜôÈÅìÔºö
> > Dear Zhou Rui,
> > 
> > In message <1219479992.7565.17.camel@localhost> you wrote:
> > >
> > > > >    I am running a kernel module which will execute a user space
> > > > >application. The entry point of the application is 0x100000a0. At the
> > > > 
> > > > That should be the first clue that you are doing it wrong.  Don't do
> > > > stuff like that in modules...
> > > 
> > > Oh, but our project needs a function like that ...
> > 
> > You should really think about this. Why do you think you  need  this?
> > What  exactly  are  you  trying  to  do?  [Probably  there are better
> > approaches to solve your problem...]
> 
> > > It is physical address at this moment. Address translation is disabled
> > > automatically (MSR[IR, DR] = [0, 0]) because of TLB Miss Exception and
> > > Instrunction Storage Exception.
> > 
> > Hm.. are you absolutely sure that the 0x100000a0 mentioned above is a
> > physical address?
> > 
> > > > Do you have enough DRAM to cover that?  Some of those boards only come
> > > > with 32MiB of DRAM.
> > > 
> > > My board only has 32MB DRAM. Do you mean 32MB is not enough for that?
> > 
> > Well, 0x1000'00A0 is above 256 MB, while you  have  only  32  MB  RAM
> > which is most probably mapped from 0x0000'0000...0x01FF'FFFF... So
> > what you claim to be a physical address (and I think your claim is
> > wrong) is far outside available physical memory.
> > 
> > > The same codes can run well in a PPC440EP (Yosemite Board) which owns
> > > 256MB DRAM. At the beginning of my work, I thought memory size may be
> > > the cause of failure. But I did not know how to demonstrate it. So if
> > > the limitation of 32MB DRAM leads to the failure, are there any methods
> > > for the codes to solve it?
> > 
> > I think you got lost on the wrong track. Please describe  which  task
> > you  want  to  implement, and there might be another, better approach
> > for it.
> > 
> > Best regards,
> > 
> > Wolfgang Denk

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
