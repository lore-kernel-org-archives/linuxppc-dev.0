Return-Path: <martineschen@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 7061FDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 05:01:29 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so3204105ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Jan 2007 10:01:27 -0800 (PST)
Message-ID: <3acfce80701091001u27cac269q2fa227daf543a7d4@mail.gmail.com>
Date: Tue, 9 Jan 2007 16:01:26 -0200
From: "Daniel Martineschen" <martineschen@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 + boa webserver + CGI + broken pipe
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
I'm working in a MPC5200-based board with Denx Linux, kernel 2.4.25,
ELDK 3.1.1. The board uses the boa webserver to handle CGI scripts,
which communicate to a proprietary application and read data from a
database. The problem is that sometimes (actually, very often) these
CGI scripts end up causing a "pipe write: Broken pipe" message from
boa when the requested page is reloaded too fast on the web browser or
the user clicks "too fast" on links of the page. ("too fast" would be
to click a link 5 or 6 times within a second)

The "broken pipe" message is as follows:

10.0.0.3 - - [09/Jan/2007:12:50:09 +0000] request "GET
/.../index.cgi?run=command HTTP/1.1"  "/.../index.cgi"): pipe write:
Broken pipe

After that, no page can be loaded.
Additionally, the system breaks (but it doesn't happen all the time)
and reports following message (repeated 3 or 4 times before total
freeze):

Machine check in kernel mode.
Caused by (from SRR1=41030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00089B8 XER: 00000000 LR: C00089E8 SP: C0841DE0 REGS: c0841d30
TRAP: 0200    Not tainted
MSR: 00041030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0840000[737] 'application' Last syscall: 162
last math c08e4000 last altivec 00000000
GPR00: 402FF520 C0841DE0 C0840000 C0131D20 00001032 00000001 FFFFD49C 00000001
GPR08: FFFFD49C 00000000 C01600EF C0841CF0 C0180000 101820C8 00000000 3D126FC0
GPR16: 00000000 000002AC 10180000 10180000 00001032 00841E60 00000000 C0005CC8
GPR24: C0005EC8 C0130000 C0130000 92492493 0D000000 00000002 402FF520 00000000
Call backtrace:
C00089E8 C000856C C0005E48 C0005CC8 C0006E24 C0005A7C

I've googled and found some emails regarding this problem, but I
couldn't figure out what caused this crash. Some said that this
problem occurs when boa receives a SIGPIPE, and because boa simply
ignores this signal.
These crashes are too frequent and even if the board uses root
filesystem via NFS this problem appears. Then, when I try to re-run
the proprietary application and refresh the page from browser, the
system freezes with either a "Bus error" signal or a SIGSEG.

Does anyone have any idea about this problem? I don't know if I
described the problem properly, but it seems that the source is the
boa webserver. I don't have much time to test other webservers, so if
someone has a clue to solve (even partially) this, please let me
know... If the solution is to change the webserver (maybe because boa
is really not reliable)

thanks in advance
Daniel

-- 
---
Daniel Martineschen
