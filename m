From: mikejc@us.ibm.com
Subject: Re: ld bug?
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Date: Fri, 15 Sep 2000 08:09:20 -0500
Message-ID: <OF954719CC.9BC9FB60-ON8625695B.0047A35F@rchland.ibm.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I believe that ld has done the right thing here.

The lwz instruction sign extends the displacement when calculating r9 +
0xc3e4.

at the lwz instruction:

lis r9,-16326        r9 = 0xc03a0000

lwz r0,-15388(r9)         0xc03a0000   (r9)
                        + 0xffffc3e4   (displacement)
                          ----------
                     ea = 0xc039c3e4


Mike Corrigan



Hi,

Well, I've just had a kernel hang at "Freeing unused kernel memory:..."
with linux-2.4.0-test8 + numerous patches, and I've traced the hang to
what apears (to me) to be a ld bug.

The kernel hangs at the call to spin_unlock_irq() in schedule() of
kernel/sched.c.  For me (UP kernel), spin_unlock_irq() is defined to be

struct int_control_struct
{
     void (*int_cli)(void);
     void (*int_sti)(void);
     void (*int_restore_flags)(unsigned long);
     void (*int_save_flags)(unsigned long *);
     void (*int_set_lost)(unsigned long);
};
extern struct int_control_struct int_control;

extern void __no_use_sti(void);

#define __sti()               int_control.int_sti()
#define local_irq_enable()    __sti()
#define spin_unlock(lock)     do { } while (0)
#define spin_unlock_irq(lock) \
     do { spin_unlock(lock);  local_irq_enable();       } while (0)


>From objdump output of kernel/sched.o:

     458:       3d 20 00 00     lis     r9,0
                        45a: R_PPC_ADDR16_HA    int_control+0x4
     45c:       80 09 00 04     lwz     r0,4(r9)
                        45e: R_PPC_ADDR16_LO    int_control+0x4
     460:       7c 08 03 a6     mtlr    r0
     464:       4e 80 00 21     blrl

So, if I'm reading this correctly, the compiler is generating correct
assembly.  Now, objdump output of vmlinux (kernel) for the same segment
says:

c02164c4:       3d 20 c0 3a     lis     r9,-16326
c02164c8:       80 09 c3 e4     lwz     r0,-15388(r9)
c02164cc:       7c 08 03 a6     mtlr    r0
c02164d0:       4e 80 00 21     blrl

However, from "nm vmlinux | grep int_control", "int_control" is at

c039c3e0 D int_control

as opposed to c03ac3e0 used in vmlinux.  So, it appears that ld or
something is acting up.  I've tried various version of binutils from
2.9.1.0.990418 to 2.10.0.18, but all have produced the same output.
Except for 2.9.1.0.990414, all 2.10.x versions that I tried are from
ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/.

gcc is 2.95.3-2c (also from fsirl directory).

If I change some totally (and seemingly) unrelated files a bit, vmlinux
produced may be correct.  I tried to look at if any section's size
matters, but I don't see any pattern unfortunately.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
