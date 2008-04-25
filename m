Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0BB7BDDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 18:16:17 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3P8GB0Z000635
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 10:16:12 +0200
Message-ID: <08de01c8a6ac$9f503a40$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <07c101c8a5e6$13670980$ad289e86@LPSC0173W>
Subject: Re: ML405 failed reboot
Date: Fri, 25 Apr 2008 10:16:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm posting a little more info 'cause no-one took the bait:

# tail -f /tmp/messages  &
# reboot
The system is going down NOW!
Sending SIGTERM to all processes
Requesting system reboot
[ 2021.926957] Restarting system.
[ 2021.9[ 2021.931063] Kernel stack overflow in process c7c52c10, 
r1=c01fc25b
[ 2021.935935] NIP: c7503dc8 LR: 00000001 CTR: 00000000
[ 2021.940871] REGS: c7503d40 TRAP: c000b3b8   Not tainted 
(2.6.24-rc8-xlnx)
[ 2021.947679] MSR: fee1dead <EE,PR,ME,IR>  CR: c01d0000  XER: 00000000
[ 2021.953996] TASK = c7c52c10[261] 'init' THREAD: c7502000
[ 2021.959084] GPR00: 00001001 c01fc25b 00000012 c7503d72 c7503db0 c0017020 
00000000 000007e5
[ 2021.967376] GPR08: 3c343e5b 20323032 312e3932 38373530 5d2000d0 c0017020 
00000000 000007e5
[ 2021.975669] GPR16: 3c303e5b 20323032 312e3932 36393537 5d2000b0 00000000 
00000000 0000004d
[ 2021.983963] GPR24: 00000000 fee1dead 28121969 00000000 c7503df0 c00170a8 
02002222 c7503df8
[ 2021.992430] NIP [c7503dc8] 0xc7503dc8
[ 2021.996059] LR [00000001] 0x1
[ 2021.998997] Call Trace:
[ 2022.001423] Kernel panic - not syncing: kernel stack overflow
[ 2022.007142] Rebooting in 180 seconds..

[ 2201.477426]   Code:   30001
[ 2201.477437]   Addr:   c01e5f28
[ 2201.484367] Oops: Exception in kernel mode, sig: 4 [#1]
[ 2201.489548] NIP: c01e5f28 LR: 000001d6 CTR: 00000000
[ 2201.494480] REGS: c01e5ea0 TRAP: c000b3b8   Not tainted 
(2.6.24-rc8-xlnx)
[ 2201.501293] MSR: 20323032 <FP,ME,IR,DR>  CR: 000001d6  XER: d07870f8
[ 2201.507609] TASK = c7c52c10[261] 'init' THREAD: c7502000
[ 2201.512698] GPR00: c01e5eb0 c01fc25b c01b1634 c01e5f18 c01e5f10 c0017020 
00000012 000019e7
[ 2201.520990] GPR08: c01e5ee0 c0016820 00000030 00021030 c01e5ee0 c01fc271 
00000012 c01e5f02
[ 2201.529284] GPR16: c01e5f40 c0017020 00000000 000007e6 3c303e5b 20323032 
322e3030 0000004d
[ 2201.537578] GPR24: 0002bf20 00000001 28121969 00000000 c01e5f50 c00170a8 
02000000 c01e5f58
[ 2201.546044] NIP [c01e5f28] 0xc01e5f28
[ 2201.549673] LR [000001d6] 0x1d6
[ 2201.552783] Call Trace:
[ 2201.555202] Instruction dump:
[ 2201.558142] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX
[ 2201.565826] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX

And now it's truly well hung.
Problem with init ? The wait reboot is compiled ? The reset vector ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
