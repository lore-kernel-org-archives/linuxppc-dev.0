Message-ID: <388FB1FD.A75F048A@huawei.com.cn>
Date: Thu, 27 Jan 2000 10:48:29 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Jesper Skov <jskov@cygnus.co.uk>,
        Brendan John Simon <brendan@dgs.monash.edu.au>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: How to gdbserver...
References: <3889220B.2BD1CB63@huawei.com.cn> <otu2k6tn9h.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Jesper Skov wrote:

> >>>>> "dony" == dony  <dony.he@huawei.com.cn> writes:
>
> dony> Hello,
>
> dony>        Now I want to use gdbserver to debug my test app.
> dony> Running "gdbserver :6666 ./mytest" on the target (Powerpc 860)
> dony> show a message: Process ./mytest created :pid=8 But I don't know
> dony> how to run gdb on the host (X86). The README doesn't seem to
> dony> explain clearly . It says first running "gdb mytest" on the host
> dony> and then "target remote mytarget:6666".  But I don't understand
> dony> something about "gdb mytest" . At this time should I run a x86
> dony> "gdb" or something like "powerpc-linux-gdb"? And the "mytest"?
>
> mytest is the same executable you run on the target. gdb you run on
> the host would be powerpc-linux-gdb (i.e., cross-debugger), thus:
>
> target:> gdbserver :6666 ./mytest
>
> host:> powerpc-linux-gdb mytest
> [...]
> (gdb) target remote mytarget:6666

Hi, Jesper:
      Following the above steps, now my host can connect with target.
Because I can see the following messages from host and target
respectively:

[target]  IP=10.11.27.244
 ./gdbserver :6666 ./mytest
Process ./mytest created; pid=19
Remote debugging using :6666

[host] which is a x86 box
powerpc-linux-gdb --baud 9600 mytest
(gdb)target remote 10.11.27.244:6666
Remote debugging using 10.11.27.244:6666
0x30016a7c in ??()
(gdb)

Has the host and the target been connected via network yet?
If so, I type "run" after (gdb) at host side, then
(gdb)run
The program being debugged has been started already
Start it from the begging?(y or n) y
Starting program: /mytest/mytest
Don't know how to run. Try "help target".

I don't know why the program is running at this time.
type "list" can show my source code.
type "b main" can set breakpoint .
(gdb) b main
Breakpoint 1 at 0x10000328:file mytest.c, line 4.
(gdb) s
Cannot find bounds of current function

I don't know why I cannot run the program at host side. Am I missing
something?
I am pretty new with "GDB" debug.
Can some gurus give me some advices?
Thanks very much.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
