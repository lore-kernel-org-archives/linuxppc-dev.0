Message-ID: <F9102D41F595D311ACA7009027DE2C840527B194@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: "Johnson, Stephen" <stevebj@artesyncp.com>,
	"'Wolfgang Denk'" <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Opps...with ELDK-2.1.0 (ppc_4xx) 
Date: Tue, 22 Apr 2003 14:38:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here's the results of ksymoops for the ppc_4xx kernel. Hopefully this is consistent with what has been observed.
----------------------------------------------------------------------
ksymoops < oops.txt
ksymoops 2.4.8 on ppc 2.4.21-pmppc440.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pmppc440/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c0009f0c,
 System.map says c00059dc.  Ignoring ksyms_base entry
NIP: C000F2DC XER: 00000000 LR: C000F2DC SP: C0170C00 REGS: c0170b50 TRAP: 0700
   Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c016f070[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C000F2DC C0170C00 C016F070 0000001B 00001030 00000001 00000020 C01C0000
GPR08: 00000E4F 00000000 00000000 C0170B20 C0170D98 100215B0 07FA8300 007FFF9C
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 C0170F30 00000000 00000009
GPR24: C0170D68 C01DBA3C 00000000 C01C0000 0001D333 C0170C38 00000000 C0170C00
Call backtrace:
C000F2DC C000F1EC C000FCEC C00DC510 C00DC860 C00DCF74 C00DA7A0
C00DB5CC C00DB720 C00DB110 C00DD664 C00DD7E4 C0004F04 C000376C
C00228C8 C0004D04 C0004D2C C00011D0 C0181598 C0000224
Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available


>>NIP; c000f2dc <schedule+94/57c>   <=====

>>GPR0; c000f2dc <schedule+94/57c>
>>GPR1; c0170c00 <init_task_union+1b90/2000>
>>GPR2; c016f070 <init_task_union+0/2000>
>>GPR7; c01c0000 <log_buf+282c/4000>
>>GPR11; c0170b20 <init_task_union+1ab0/2000>
>>GPR12; c0170d98 <init_task_union+1d28/2000>
>>GPR21; c0170f30 <init_task_union+1ec0/2000>
>>GPR24; c0170d68 <init_task_union+1cf8/2000>
>>GPR25; c01dba3c <iic_wait+0/24>
>>GPR27; c01c0000 <log_buf+282c/4000>
>>GPR29; c0170c38 <init_task_union+1bc8/2000>
>>GPR31; c0170c00 <init_task_union+1b90/2000>

Trace; c000f2dc <schedule+94/57c>
Trace; c000f1ec <schedule_timeout+98/cc>
Trace; c000fcec <interruptible_sleep_on_timeout+68/ac>
Trace; c00dc510 <iic_wait_for_irq+88/1b0>
Trace; c00dc860 <iic_sendbytes+228/29c>
Trace; c00dcf74 <iic_xfer+1bc/1d0>
Trace; c00da7a0 <i2c_transfer+8c/e0>
Trace; c00db5cc <i2c_smbus_xfer_emulated+218/298>
Trace; c00db720 <i2c_smbus_xfer+d4/f0>
Trace; c00db110 <i2c_smbus_write_byte_data+34/44>
Trace; c00dd664 <rtc_write+28/58>
Trace; c00dd7e4 <m41t00_set_rtc_time+150/1b0>
Trace; c0004f04 <timer_interrupt+1c4/254>
Trace; c000376c <ret_from_intercept+0/8>
Trace; c00228c8 <check_pgt_cache+20/30>
Trace; c0004d04 <idled+58/70>
Trace; c0004d2c <cpu_idle+10/24>
Trace; c00011d0 <rest_init+30/40>
Trace; c0181598 <start_kernel+168/17c>
Trace; c0000224 <skpinv+1b8/1f0>


4 warnings issued.  Results may not be reliable.



-----Original Message-----
From: Johnson, Stephen
Sent: Tuesday, April 22, 2003 2:26 PM
To: 'Wolfgang Denk'
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Opps...with ELDK-2.1.0 (ppc_4xx)



Thanks for the help.  I was happy to see the Oops go away by shutting down ntpd.

The ELDK has been awesome to use... I've recommended it to many of my customers.  Keep up the good work and you have a large community of developers out here working and testing it. I'll still be trying 2.1.0 on the different platforms and post anything that I find.

Actually this Oops will be a good training exercise for some of our support engineers. It's not often that they get an Oops to debug.





-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tuesday, April 22, 2003 2:16 PM
To: Johnson, Stephen
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Opps...with ELDK-2.1.0 (ppc_4xx)


In message <F9102D41F595D311ACA7009027DE2C840527B192@c3po.heurikon.com> you wrote:
> Stopping ntpd seems to have eliminated the "Oops"
>
> I'll still look at the Oops with ksymoops for completeness and then look to see what ntpd is doing to cause it.

I am aware of the NTPD problems.  We  are  working  on  a  fix.  This
problem  is  the  reason why there hasn't been an official release of
the new version of the ELDK yet.

I'm sorry...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I program, therefore I am.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
