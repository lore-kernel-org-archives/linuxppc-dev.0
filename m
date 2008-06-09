Return-Path: <evangelion1122001@yahoo.com.cn>
Received: from n6.bullet.re3.yahoo.com (n6.bullet.re3.yahoo.com
	[68.142.237.91]) by ozlabs.org (Postfix) with SMTP id 8F1EBDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 00:23:30 +1000 (EST)
Subject: Is there any significant difference of memory management between
	PPC 405 and 440?
From: Evangelion <evangelion1122001@yahoo.com.cn>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 09 Jun 2008 16:34:53 +0200
Message-Id: <1213022093.6785.49.camel@zr.gii.upv.es>
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
    It may be a silly question.

    There is a 405 and a 440 board. We create a kernel module which will
allocate 3MB memory every time it is loaded. It runs basically well in
440 board, which owns 256MB memory. However, in 405 board, which only
has 32MB memory, loading the module always results in "Data machine
check in kernel mode":

....
Data machine check in kernel mode.
PLB0: BEAR= 0x03016004 ACR=   0x00000000 BESR=  0x00c00000
PLB0 to OPB: BEAR= 0x04000000 BESR0= 0x00000000 BESR1= 0x00000000
Oops: machine check, sig: 7 [#1]
NIP: 00002D10 LR: 000010A8 CTR: C3170160
REGS: c0282f50 TRAP: 0202   Not tainted  (2.6.19.2)
MSR: 00021000 <ME>  CR: 24000088  XER: 00000000
TASK = c3016000[0] '' THREAD: c0264000
GPR00: 08000000 C08ABCB0 C3016000 C08ABCC0 C3177250 C3016000 C3018000
00000000 
GPR08: C3018000 00000000 00021032 008ABCB0 030161B0 10019DA8 00000000
00000000 
GPR16: 10102260 1009DF98 100F0000 100F7998 C3170000 00000002 00000028
C3170000 
GPR24: 00000001 C3170000 C3170000 00000000 00000001 00000001 00000000
00000000 
NIP [00002D10] 0x2d10
LR [000010A8] 0x10a8
Call Trace:
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Rebooting in 180 seconds..<NULL>
....

    We have checked that once the 405 board boots successfully, there is
only about 5MB free memory. So we have tried to change the memory
allocated size in the module to smaller than 3MB, e.g. 1KB, 3KB, 1.5MB
etc., but got the same results.
    Here we run the same codes in these two boards but get totally
different results, therefore, we wonder what the exact cause of "Data
machine check in kernel mode". We think it relates to memory management,
but is there any other potential reasons?
    If there is significant difference of memory management between 405
and 440, would anyone like to tell us something about it? And what
should we pay attention to in our implementation for these two boards?

    Thank you very much!

Best Regards

Evangelion

June 9th, 2008

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
