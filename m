Message-ID: <031401bf8056$678deb00$571170c1@honda.isltd.insignia.com>
From: "jjs" <Jerry.Sexton@insignia.com>
To: "Kevin Buettner" <kev@primenet.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gdb and multi-threaded applications.
Date: Sat, 26 Feb 2000 12:38:37 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Feb 23, 10:09am, jjs wrote:
>
>> I recently installed linuxppc-1999 on my beige G3. The main motivation
for
>> doing this was to debug a multi-threaded application, which I could not
do
>> under the Release 4 that I previously had installed.
>>
>> The version of gdb that comes with the distribution (which I got from
>> ftp.linuxppc.org) is 4.17.0.11, which is not multi-thread aware. I
therefore
>> got hold of the sources for 4.17 from ftp.gnu.org and H.J.Lu's patches
for
>> 4.17.0.14 and compiled up the resulting sources. According to the release
>> notes for 4.17.0.14, the change form 4.17.0.11 to 4.17.0.12 adds support
for
>> LinuxThreads on PowerPC, so the version I have should work for
>> multi-threaded applications. However, typing 'info threads' on the
>> resultingexecutable, just returns me to the gdb prompt. Typing 'thread
1',
>> yields the message 'Thread ID 1 not known. Use the "info threads" command
to
>> see the IDs of currently known threads.'. According to the gdb info, this
is
>> typical behaviour of a gdb that does not have multi-threaded support.
>>
>> Also, running the gdb.threads test in the testsuite that comes with the
>> distribution, tells me that my gdb does not support pthreads for this
>> machine.
>>
>> All the evidence points to my gdb build not supporting multiple threads.
Can
>> anybody tell me what I am doing wrong?
>
>I'm not sure that you're doing anything wrong.  Was the program in
>question multithreaded?  I see the same behavior on linux/x86 when
>debugging a single threaded program.
>
>Regardless, you may want to try the latest gdb sources from the CVS
>repository at sourceware.cygnus.com.  I've recently merged the gdb
>patches for linux/ppc into the "official" source base and need help
>testing this code.  This version is thread aware and passes all of the
>thread related tests in the test suite.  In fact overall, I'm seeing
>only 31 failures.  (This number rises to 70 if you also build/test
>insight (gdbtk)).
>
>See http://sourceware.cygnus.com/gdb/ for information on how to obtain
>the sources.
>
>Kevin
>
>--
>Kevin Buettner
>kev@primenet.com, kevinb@redhat.com
>

Kevin,

Thanks for your reply the other day, I have tried taking the gdb-000222
snapshot from the ftp site and compiled it, but I am getting the same
behaviour as I was with 4.17.0.14, which unfortunately I did not fully
describe in my original message. I am seeing the described behaviour with
'info threads' but also when I run my program under gdb, it hangs when
trying to create a new thread via a call to pthread_create. It works as
expected outside the debugger, creating the thread and continuing.

I have tried attaching gdb to the gdb process that is hanging and get the
following stack trace:

#0  0x15c64c0 in __syscall_rt_sigsuspend () at soinit.c:59
#1  0x15c51f0 in __sigsuspend (set=0x19da444)
    at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
#2  0x184aa88 in linux_child_wait (pid=-1, rpid=0x7fffe0f0,
status=0x7fffe0f4)
    at linux-thread.c:1338
#3  0x184ad14 in linuxthreads_wait (pid=-1, ourstatus=0x7fffe150)
    at linux-thread.c:1415
#4  0x18316e4 in wait_for_inferior () at infrun.c:1261
#5  0x18314ec in proceed (addr=1, siggnal=TARGET_SIGNAL_DEFAULT, step=1)
    at infrun.c:1058
#6  0x182e5a8 in step_1 (skip_subroutines=0, single_inst=27131904,
    count_string=0x0) at infcmd.c:542
#7  0x182e230 in step_command (count_string=0x1 <Address 0x1 out of bounds>,
    from_tty=8) at infcmd.c:423
#8  0x186e814 in execute_command (p=0x19efbc1 "", from_tty=1) at top.c:1502
#9  0x183a5fc in command_handler (command=0x19efbc0 "s") at event-top.c:508
#10 0x183adb8 in command_line_handler (rl=0x19d9864 "") at event-top.c:810
#11 0x192d094 in rl_callback_read_char () at callback.c:122
#12 0x1839980 in rl_callback_read_char_wrapper (client_data=0xfffffffc)
    at event-top.c:166
#13 0x183a464 in stdin_event_handler (error=-4, client_data=0xfffffffc)
    at event-top.c:415
#14 0x188e2dc in handle_file_event (event_file_desc=-4) at event-loop.c:726
#15 0x188de70 in process_event () at event-loop.c:381
#16 0x188dec8 in gdb_do_one_event (data=0xfffffffc) at event-loop.c:418
#17 0x186d66c in catch_errors (func=0x188de94 <gdb_do_one_event>, args=0x0,
    errstring=0x1960d80 "", mask=3) at top.c:612
#18 0x188df10 in start_event_loop () at event-loop.c:442
#19 0x1839a84 in cli_command_loop () at event-top.c:196
#20 0x1802768 in captured_command_loop (data=0xfffffffc) at main.c:99
#21 0x186d66c in catch_errors (func=0x180273c <captured_command_loop>,
    args=0x0, errstring=0x193bcf4 "", mask=3) at top.c:612
#22 0x18031c8 in captured_main (data=0xfffffffc) at main.c:737
#23 0x186d66c in catch_errors (func=0x18027a8 <captured_main>,
    args=0x7ffff4f8, errstring=0x193bcf4 "", mask=3) at top.c:612
#24 0x18031fc in main (argc=-4, argv=0x8) at main.c:749
#25 0x15bd7d4 in __libc_start_main (argc=2, argv=0x7ffff564,
envp=0x7ffff570,
    auxvec=0x7ffff664, rtld_fini=0xfffffffc, stinfo=0x193bbb0,
    stack_on_entry=0x16bdc90) at ../sysdeps/powerpc/elf/libc-start.c:106

I am running with kernel 2.2.6-15apmac, which came with the linuxppc-1999
distribution.

Any assistance you can give me will be gratefully received.

Cheers, Jerry.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
