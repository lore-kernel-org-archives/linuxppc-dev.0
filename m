Subject: EP405 Kernel module problem
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: linuxppc-embedded@lists.linuxppc.org
To: PPC Mailinglist <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1066052227.3005.4.camel@toni>
Mime-Version: 1.0
Date: Mon, 13 Oct 2003 15:37:07 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I try to run the next module on my systems, but I get a kernel Oops.

Module code:
#include <linux/module.h>
#include <linux/version.h>

#include <rtai.h>
#include <rtai_sched.h>

#define DCRN_CPC0_CR0  (0xb1)
#define GPIO0_REG_BASE (0xEF600700)
#define GPIO0_OR  (0x00)
#define GPIO0_TCR (0x04)
#define GPIO0_ODR (0x18)
#define GPIO0_IR  (0x1C)

RT_TASK task;
u8* gpio_baseptr;

#define PERIOD 1000

void rt_control(int data) {
	// Output a square wave on GPIO0
	u32 cnt = 0x00000001;
	for(;;)	{
		// Output the cnt value
		writeb( (u32)cnt , (u32)gpio_baseptr+GPIO0_OR);
		// Invert the cnt bit
		cnt ^= 0x00000001;
		// Wait for the next period
		rt_task_wait_period();
	};
};

int init_module(void) {
	u32 tmp32;
	u32* gpio_base_addr;
	printk("PPC405GP on EP405 rt_mod\n");

	// read register
	tmp32 = mfdcr( DCRN_CPC0_CR0 );
	// bit TRE in CPC0_CR0 = 0  ==> GPIO1-9 enabled
	tmp32 &= ~0x08000000;
	// write register
	mtdcr( DCRN_CPC0_CR0, tmp32 );

	// remap
	gpio_base_addr=(u32*)ioremap(GPIO0_REG_BASE,0x20);
	// set GPIO outputs at a safe default value (TBD)
	writel( 0x00000000, (u32)gpio_baseptr+GPIO0_OR );
	// configure GPIO outputs 1..3 as not tri-state
	writel( 0xffffffff, (u32)gpio_baseptr+GPIO0_TCR );
	// configure GPIO outputs 1..3 as not open-drain
	writel( 0x00000000, (u32)gpio_baseptr+GPIO0_ODR );


	// set RTAI timer mode to 'one shot'
	rt_set_oneshot_mode();
	// Start the timer
	start_rt_timer(0);
	// Initialise the task
	rt_task_init(&task, rt_control, 0, 1000, 10, 0, 0);
	// Make the task periodic
	rt_task_make_periodic(&task,rt_get_time()+10*PERIOD,PERIOD);

	return 0;
}

void cleanup_module(void) {
	// unmap when module is unloaded
	iounmap(gpio_baseptr);

	// Stop the RTAI timer
	stop_rt_timer();
	// Remove the task
	rt_task_delete(&task);
};


Kernel message:
# insmod ./rtai_mod.o
Using ./rtai_modOops: kernel access of bad area, sig: 11
NIP: C000FA9C XER: 00000000 LR: C001620C SP: C0B91ED0 REGS: c0b91e20
TRAP: 0800d
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000000, ESR: 00000000
TASK = c0b90000[34] 'exe' Last syscall: 166
last math 00000000 last altivec 00000000
PLB0: bear= 0xfd189df5 acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x01524021 besr0= 0x00000000 besr1= 0x00000000

GPR00: 7FFFFF90 C0B91ED0 C0B90000 00000000 FFFFFFFF 00000400 7FFFB9E8
7FFFB9E8
GPR08: C01B5200 00000001 C00166CC 0000000E 44000088 100668A8 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 00B91F40 7FFFB9E8
C201F000
GPR24: 00000000 00000390 10071B68 00000070 10071BD8 10071B68 C2025504
FFFFFFFE
Call backtrace:
10071B68 C00166E0 C000479C 10012A38 100145BC 1003AF0C 1003AB44
0FECAD14 00000000
.o
SIGSEGV


The needed RTAI modules are loaded (rtai, rtai_fifos, rtai_sched). It's
not an RTAI problem, because this module is based on a working example
for Coldfire.
Probably I use wrong registers somewhere, but I don't see a mistake yet.

PS: I gonna use 3 GPIO's, but now it's just a test.

Some suggestions?
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
