Return-Path: <orutsch@sympatec.com>
Message-ID: <48CA243D.8020701@sympatec.com>
Date: Fri, 12 Sep 2008 10:11:41 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
Subject: Re: TQM8349 and ARCH = powerpc
References: <48C68763.6030606@sympatec.com>	<20080909112253.c9c9617f.kim.phillips@freescale.com>	<48C7D5C6.1070507@sympatec.com>
	<20080910092631.07d5c1cc.kim.phillips@freescale.com>
In-Reply-To: <20080910092631.07d5c1cc.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> On Wed, 10 Sep 2008 16:12:22 +0200
> Oliver Rutsch <orutsch@sympatec.com> wrote:
> 
>>    model = "tqc,tqm834x";
>>    compatible = "tqc,tqm834x";
> 
> you need a arch/powerpc/platforms/83xx/tqm834x.c file that matches this.
> 
> Kim

O.K. I read "booting-without-of.txt" the third (or fourth?) time and
so I made the entries for this board in the KConfig and the Makefile
and I created tqm834x.c, which is essentially a copy of mpc834x_itx.c.
As I did not found any board specific details, the most significant
change is the of_device_id:

static struct of_device_id tqm834x_ids[] = {
	{ .type = "soc", },
	{ .compatible = "soc", },
	{ .compatible = "simple-bus", },
	{},
};

I hope that this is correct.
And so I selected the board and the kernel just compiled fine. But the
result was always the same. So I warmed up my BDI2000 and debugged
the kernel. I can stop the kernel in the "start_here" function but
it seems to run wild after line 1012. As the kernel dies at a
very early stage, I don't think that it is device tree related.
Here's my gdb session:

-----------------------------------------------------
start_here () at arch/powerpc/kernel/head_32.S:1011
1011            lis     r1,init_thread_union@ha
(gdb)
start_here () at arch/powerpc/kernel/head_32.S:1012
1012            addi    r1,r1,init_thread_union@l
(gdb)

Program received signal SIGSTOP, Stopped (signal).
0x000006fc in ?? ()
(gdb) bt
#0  0x000006fc in ?? ()
#1  0x000003e0 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) si

Program received signal SIGSTOP, Stopped (signal).
0x000012fc in ?? ()
(gdb)

Program received signal SIGSTOP, Stopped (signal).
0x000006fc in ?? ()
-----------------------------------------------------

Then it toggles between 0x6fc and 0x12fc. These addresses
look totally wrong.

As always, all ideas are welcome.

Thanks for all suggestions so far!


Bye,
-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
