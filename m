From: Jesper Skov <jskov@cygnus.co.uk>
Message-ID: <14476.2913.868456.408641@thinktwice.zoftcorp.dk>
Date: Mon, 24 Jan 2000 09:20:49 +0100 (CET)
To: dony <dony.he@huawei.com.cn>
Cc: Jesper Skov <jskov@cygnus.co.uk>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver
In-Reply-To: <388BB007.D0BF32C4@huawei.com.cn>
References: <3889220B.2BD1CB63@huawei.com.cn>
	<otu2k6tn9h.fsf@thinktwice.zoftcorp.dk>
	<388BB007.D0BF32C4@huawei.com.cn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "dony" == dony  <dony.he@huawei.com.cn> writes:

dony> Jesper Skov wrote:

>> >>>>> "dony" == dony <dony.he@huawei.com.cn> writes:
>>
dony> Hello,
>>
dony> Now I want to use gdbserver to debug my test app.  Running
dony> "gdbserver :6666 ./mytest" on the target (Powerpc 860) show a
dony> message: Process ./mytest created :pid=8 But I don't know how to
dony> run gdb on the host (X86). The README doesn't seem to explain
dony> clearly . It says first running "gdb mytest" on the host and
dony> then "target remote mytarget:6666".  But I don't understand
dony> something about "gdb mytest" . At this time should I run a x86
dony> "gdb" or something like "powerpc-linux-gdb"? And the "mytest"?
>>  mytest is the same executable you run on the target. gdb you run
>> on the host would be powerpc-linux-gdb (i.e., cross-debugger),
>> thus:
>>
>> target:> gdbserver :6666 ./mytest
>>
>> host:> powerpc-linux-gdb mytest [...]  (gdb) target remote
>> mytarget:6666
>>
dony> Is it compiled with x86 gcc or cross-compiled with
dony> "powerpc-linux-gcc"? Really I am very confused at this point:-((
>>  mytest is compiled with powerpc-linux-gcc.

dony> "powerpc-linux-gdb" is compiled with gcc or powerpc-linux-gcc?

gcc. You should look at one of the FAQ/HOWTO/READMEs/Home pages on the
sucject of embedded development. I think there was posted a small
howto on compiling the components a few days back. Check the archive.


One question: you are using an x86 host, right? If you use a PPC host,
you can just use the preinstalled GDB/GCC when building/debugging the
target binary.


dony>How do you build you powerpc-linux-gdb?
dony>I copy a gdb-4.17.tar.gz from LinuxPPC R4 CD.
dony>When I untar and decompress it, I type the following  under gdb-4.17/gdb
dony>directory:
dony>
dony>	./configure --target=powerpc-linux
dony>	make
dony>
dony>	It fails to compile and say:
dony> make:*** No rule to make target `../bfd/bfd.h`, needed by `blockframe.o`.Stop.
dony>
dony>Yes, there is not bfd.h under gdb-4.17/bfd directory.
dony>Do you know why?
dony>Thank you very much.


I don't know why. It's an old debugger. I think we keep a more recent
version / CVS tree on sourceware.cygnus.com. It may work better. The
howto I mentioned before included links to the archives used, as far
as I remember.

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
