Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8B432C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 05:41:50 +1100 (EST)
Message-ID: <5304FB19.4050208@windriver.com>
Date: Wed, 19 Feb 2014 13:42:33 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: John Donnelly <john.d@servergy.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: Anyone using SysRQ key sequences on console serial port ?
References: <CAGtOQbTRSk32p7U=v9V9GPb_ro+WYbKLLCCfrmdypePcHA++mw@mail.gmail.com>	<CAP=VYLpgMYaSVjTwJ2Q15XB+nozz=OhAPU85Nb9xG_FdP5dcyA@mail.gmail.com>	<1392665821.6733.630.camel@snotra.buserror.net>
 <CAGtOQbQXLpdzAzxgwtzisEJ1MAeND8057103oUO-v9x4Ki8qYQ@mail.gmail.com>
In-Reply-To: <CAGtOQbQXLpdzAzxgwtzisEJ1MAeND8057103oUO-v9x4Ki8qYQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[BTW, your html mail may be ignored by most people ; for example most of
 the linux lists on vger.kernel.org actively reject it; top posting isn't
 going to help either... ]

On 14-02-18 02:47 PM, John Donnelly wrote:
> I am enable to get one keyboard sequence responded to with the noted change
> in the dts .
> 
>  for instance:
> 
>    SysRQ ( Break)   c
> 
>   Panics .. Which is a good response, and since it doesn't require a return
> to user mode ( I suspect )  it appears to work.
> 
> Any other requests fail to report any information :
> 
>  SysRQ (break )  l - list active processes
>                          m - list memory
> 
>   Any additional SysRQ are ignored., and the system appears hung.

It must be something specific about your particular platform, or the
custom patches you have applied then.  I just tested today's linux-next
tree (i.e. the latest bleeding edge stuff) and it still works for the
sbc8548 (defconfig + enable magic SYSRQ option).  I did "s" (sync) multiple
times and "?" then "m" for memory dump (obviously those chars don't get
echo'd to the console....

 ---------------------------------------
root@sbc8548:~# cat /proc/cpuinfo |grep cpu
cpu             : e500v2
root@sbc8548:~# SysRq : Emergency Sync
Emergency Sync complete
SysRq : Emergency Sync
Emergency Sync complete
SysRq : HELP : loglevel(0-9) reboot(b) crash(c) terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) sync(s) show-task-states(t) unmount(u) show-blocked-tasks(w)
SysRq : Show Memory
Mem-Info:
DMA per-cpu:
CPU    0: hi:  186, btch:  31 usd: 132
active_anon:738 inactive_anon:29 isolated_anon:0
 active_file:915 inactive_file:2219 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:188325 slab_reclaimable:488 slab_unreclaimable:778
 mapped:1006 shmem:44 pagetables:83 bounce:0
 free_cma:0
DMA free:753300kB min:3520kB low:4400kB high:5280kB active_anon:2952kB inactive_anon:116kB active_file:3660kB inactive_file:8876kB unevictable:0kB isolated(anon):0kB isolated(file):0kB 
present:786432kB managed:775916kB mlocked:0kB dirty:0kB writeback:0kB mapped:4024kB shmem:176kB slab_reclaimable:1952kB slab_unreclaimable:3112kB kernel_stack:264kB pagetables:332kB uns
table:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 403*4kB (UEM) 271*8kB (UEM) 131*16kB (UM) 35*32kB (UM) 15*64kB (UEM) 1*128kB (M) 1*256kB (M) 1*512kB (U) 1*1024kB (U) 3*2048kB (UEM) 180*4096kB (MR) = 753300kB
3178 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
196608 pages RAM
0 pages HighMem/MovableOnly
2629 pages reserved
 ---------------------------------------


Paul.
--

> 
>  On an reference Intel platform, multiple SyqRQ can be issued and the
> system remains healthy .
> 
> 
> 
> 
> 
> 
> 
> 
> 
> On Mon, Feb 17, 2014 at 1:37 PM, Scott Wood <scottwood@freescale.com> wrote:
> 
>> On Sun, 2014-02-16 at 10:56 -0500, Paul Gortmaker wrote:
>>> On Fri, Feb 14, 2014 at 3:42 PM, John Donnelly <john.d@servergy.com>
>> wrote:
>>>> Hi,
>>>>
>>>>  I tried using the SysRq hotkey sequence on a serial console -
>>>> 3.11.0-5-powerpc-e500mc system, by issuing a " break " and the system
>>>> immediately wedges after displaying "SysRQ : HELP : " using both
>> "Putty" and
>>>> "Teraterm"  terminal emulators. I know the system is dead because my
>> ssh
>>>> sessions stopped too.
>>>
>>> Yes it does work -- or at least it _did_ work.  Make sure your dts has
>> an entry
>>>
>>>                         compatible = "fsl,ns16550", "ns16550";
>>>
>>> since that enables a workaround I'd added for a hardware errata relating
>>> to sending breaks over the serial console.   What you describe above
>>> makes me think you aren't getting the workaround enabled.
>>
>> Also make sure CONFIG_SERIAL_8250_FSL is enabled.
>>
>> -Scott
>>
>>
>>
> 
> 
