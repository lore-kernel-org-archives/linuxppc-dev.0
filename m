Return-Path: <vancasperz@yahoo.com.cn>
Received: from n10.bullet.re3.yahoo.com (n10.bullet.re3.yahoo.com
	[68.142.237.123]) by ozlabs.org (Postfix) with SMTP id CC2DADDF4A
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 16:53:02 +1000 (EST)
Subject: Re: [Evolves!] Why does one "stw" fail with address translation
	disabled in PPC405EP?
From: Zhou Rui <vancasperz@yahoo.com.cn>
To: benh@kernel.crashing.org
In-Reply-To: <1220247721.13010.33.camel@pasglop>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
	<20080824185547.94A0724899@gemini.denx.de>
	<1219691805.6735.63.camel@zr.gii.upv.es>
	<1220183410.6750.56.camel@zr.gii.upv.es>
	<1220247721.13010.33.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2008 09:22:01 +0200
Message-Id: <1220253721.6764.9.camel@zr.gii.upv.es>
Mime-Version: 1.0
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Âú® 2008-09-01‰∏ÄÁöÑ 15:42 +1000ÔºåBenjamin HerrenschmidtÂÜôÈÅìÔºö
> On Sun, 2008-08-31 at 13:50 +0200, Zhou Rui wrote:
> > Hi, all:
> >     My problem seems basically solved.
> >     We we used to call vmalloc() in the memory management part of our
> > source, but it seems to be the key unreliable point resulting in the
> > problem. vmalloc() always assigns some virtual addresses whose
> > corresponding physical addresses are out of memory size (there is only
> > 32MB DRAM in our 405 board). Once instructions try to access these
> > illegal physical address, machine check happens
> 
> That should -never- happen.
> 
> Have you verified, as I asked you a while ago, that you are actually
> passing the right amount of memory to your kernel from the device-tree
> or the bootloader ?
> 
> Ben.

I added "mem=32M" to linux command line of the bootloader, and got the
same machine check.

Best Wishes

Zhou Rui
2008-09-01

> 
> >     Afterwards, we call kmalloc() instead and it works basically as what
> > we want. But problems of the memory management still exist because
> > therea are program check exception sometimes and page always:
> > ....
> > -bash-3.2# PROGRAM: reason: 0x8000000, nip: 0xc028bf20
> > Oops: Exception in kernel mode, sig: 4 [#1]
> > NIP: C028BF20 LR: C028BF20 CTR: C31C6078
> > REGS: c028be80 TRAP: 0700   Not tainted  (2.6.19.2-eldk-xm.1.0)
> > MSR: 00029030 <EE,ME,IR,DR>  CR: 00000000  XER: 00000000
> > TASK = c0228a30[0] 'swapper' THREAD: c028a000
> > GPR00: 00000000 C028BF30 C0228A30 C034B7B0 C028BF20 00000000 00000001
> > 00000000 
> > GPR08: 00000003 C31D0000 22000082 00029030 2BDD9FE1 C03B3164 0000066F
> > 2B1F1DC8 
> > GPR16: C03B3050 0FFEA478 10010000 C31D0000 C028BEF0 C31CA2E4 00021030
> > C028A000 
> > GPR24: C028BEF0 C0228B44 C0228468 C03B3050 C028BF10 C31C60C4 00029030
> > C03B3050 
> > NIP [C028BF20] init_thread_union+0x1f20/0x2000
> > LR [C028BF20] init_thread_union+0x1f20/0x2000
> > Call Trace:
> > [C028BF30] [0FFEA478] 0xffea478 (unreliable)
> > Instruction dump:
> > XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
> > XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
> > Kernel panic - not syncing: Attempted to kill the idle task!
> >  <0>Rebooting in 180 seconds..
> > 
> > And there is bad page:
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: Backtrace:
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: Bad page state in process 'loader.xm'
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: Trying to fix it up, but a reboot is needed
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: Bad page state in process 'loader.xm'
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: Trying to fix it up, but a reboot is needed
> > Message from syslogd@ at Thu Jan  1 01:32:00 1970 ...
> > 405 kernel: page:c02f0e60 flags:0x00000400 mapping:00000000 mapcount:0
> > count:1
> > 
> > I will do some traces for fixing those problems.
> > 
> > And could anyone like to give some explanation between vmalloc() and
> > kmalloc()? Based on our work, there seems to be great difference.
> > 
> > Thank you very much!
> > 
> > Best Wishes
> > 
> > Zhou Rui
> > 2008-08-31
> > 
> > Âú® 2008-08-25‰∏ÄÁöÑ 21:16 +0200ÔºåZhou RuiÂÜôÈÅìÔºö
> > > Hi,
> > > I think maybe you have known this project named XtratuM
> > > (http://www.xtratum.org). I'm porting it from x86 to PPC405. The
> > > implementation on PPC440 has been basically finished
> > > (ftp://dslab.lzu.edu.cn/pub/xtratum/xtratum-ppc/snapshots/xtratum-ppc-20071205.tar.bz2) and I know there was discussion about it in this mail list before. XtratuM is an ADEOS based nano kernel. It aims for realtime and is designed to provide virtual timer, virtual interrupt and memory space sperations for domains. Each domain is loaded by a userspace program (instead of the root domain as a kernel module) and the loader will load the domain's (ELF staticly excutable) PT_LOAD section into memory, and then raise a properly system call (passing the structurized loaded data as arguments) to load the domain via load_domain_sys() of XtratuM, and at the last step of loading the domain, xtratum will jump to the entry code of the new domain(asm wrappered start() routine) and then everything should be fine. 0x100000a0 is the entry point of the test domain, and that is why I need to start execution from it.
> > > 
> > > I think I can say something of my analysis so far for the cause of my
> > > problem. Thanks for the mention of memory size. Once the kernel module
> > > of XtratuM is loaded, the symbols of it are placed to virtual addresses
> > > like 0xc3xxxxxx. Because in normal state, address translation is enabled
> > > (MSR[IR, DR] = [1, 1]), these addresses are okay. However, when loading
> > > the domain, because the entry point 0x100000a0 is not in TLB and it
> > > should be reloaded, Data TLB Miss Exception arises and DTLBMiss is
> > > called. The exception clears MSR[IR, DR], so address translation is
> > > disabled and physical address should be used at this moment. If we want
> > > something at the virtual address of 0xc3xxxxxx, we must access the
> > > physical addresses like 0x03xxxxxx. Nevertheless, the limitation of 32MB
> > > memory makes the valid physical address range from 0x0 to 0x1ffffff.
> > > Therefore, during the exception handling, the addresses out of range
> > > should not be accessed, but the instructions cannot know the memory
> > > limitation in advance and tries to do something in addresses such as
> > > 0x03072da0 based on the address translation mechanism, which leads to
> > > machine check.
> > > I haved tried to append "mem=32M" to kernel command line but no help. I
> > > think it is because when loading the kernel in normal state, address
> > > translation is enabled and the virtual addresses are okay. Kernel cannot
> > > foresee that there is going to be a TLB miss exception and the illegal
> > > physical addresses like 0x03xxxxxx may be accessed.
> > > 
> > > So any ideas for this problem are welcome.
> > > 
> > > Thank you very much for taking care.
> > > 
> > > Best Wishes
> > > 
> > > Zhou Rui
> > > 2008-08-25
> > > 
> > > Âú® 2008-08-24Êó•ÁöÑ 20:55 +0200ÔºåWolfgang DenkÂÜôÈÅìÔºö
> > > > Dear Zhou Rui,
> > > > 
> > > > In message <1219479992.7565.17.camel@localhost> you wrote:
> > > > >
> > > > > > >    I am running a kernel module which will execute a user space
> > > > > > >application. The entry point of the application is 0x100000a0. At the
> > > > > > 
> > > > > > That should be the first clue that you are doing it wrong.  Don't do
> > > > > > stuff like that in modules...
> > > > > 
> > > > > Oh, but our project needs a function like that ...
> > > > 
> > > > You should really think about this. Why do you think you  need  this?
> > > > What  exactly  are  you  trying  to  do?  [Probably  there are better
> > > > approaches to solve your problem...]
> > > 
> > > > > It is physical address at this moment. Address translation is disabled
> > > > > automatically (MSR[IR, DR] = [0, 0]) because of TLB Miss Exception and
> > > > > Instrunction Storage Exception.
> > > > 
> > > > Hm.. are you absolutely sure that the 0x100000a0 mentioned above is a
> > > > physical address?
> > > > 
> > > > > > Do you have enough DRAM to cover that?  Some of those boards only come
> > > > > > with 32MiB of DRAM.
> > > > > 
> > > > > My board only has 32MB DRAM. Do you mean 32MB is not enough for that?
> > > > 
> > > > Well, 0x1000'00A0 is above 256 MB, while you  have  only  32  MB  RAM
> > > > which is most probably mapped from 0x0000'0000...0x01FF'FFFF... So
> > > > what you claim to be a physical address (and I think your claim is
> > > > wrong) is far outside available physical memory.
> > > > 
> > > > > The same codes can run well in a PPC440EP (Yosemite Board) which owns
> > > > > 256MB DRAM. At the beginning of my work, I thought memory size may be
> > > > > the cause of failure. But I did not know how to demonstrate it. So if
> > > > > the limitation of 32MB DRAM leads to the failure, are there any methods
> > > > > for the codes to solve it?
> > > > 
> > > > I think you got lost on the wrong track. Please describe  which  task
> > > > you  want  to  implement, and there might be another, better approach
> > > > for it.
> > > > 
> > > > Best regards,
> > > > 
> > > > Wolfgang Denk
> > > 
> > > __________________________________________________
> > > œø◊¢≈ª?
> > > http://cn.mail.yahoo.com
> > > 
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > 
> > __________________________________________________
> > œø◊¢≈ª?
> > http://cn.mail.yahoo.com
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
