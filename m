Date: Sun, 13 May 2001 12:46:01 -0400
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel bug 
Message-ID: <20010513124601.A24522@kybl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Tomas Jura <tjura@binghamton.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, everybody

I probably hit some kernel bug, which apply to load
accounting and/or task creation.  This happens me three
times this week.  Can somebody help me to prepare trap for
it and find what has happens ? I'm not kernel guru and not
very familiar with ppc assembler.

Thanks.
Tomas

Hardware, Software and Symptoms:

HW: PPC G3 beige, 160 MB of memory, (CONFIG_HIGHMEM off)
SW: Debian 2.2 unstable, kernel 2.2.5-pre1 (gcc 2.95.4)
Do kernel debug options included ( sysmon,....)
Also happened with kernel 2.2.4-x.
Loaded machine (>1)( running package instalation or
compilation). Then dies a wmtop (Window Maker top). It is not
suid program. In this moment apperars in syslog

Oops: kernel access of bad area, sig: 11
NIP: C0058B90 XER: 00000000 LR:
C00563A8 SP: C87C7D50 REGS: c87c7ca0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0
ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 40000000
TASK = c87c6000[18224] 'wmtop'
Last syscall: 3
.......
than any attempt of process listing fails (never finish
and stay hooked) and every time there is three proceses at the
end of listnig:

24459 ?        S      0:00 /USR/SBIN/CRON
24460 ?        S      0:00 /bin/sh -c   if [ -x /usr/sbin/exim -a -f /etc/exim/exim.conf ]; then /usr/s
24461 ?        S      0:00 /usr/sbin/exim -q
<end of list, frozen forever>

Yes, exim mailer is suid ;-(

Load measurement is still possible but, shows number of
frozen processes.
Any ideas where is a mistake or how to solve it?

Just happen again. Going to reboot....

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
