Message-Id: <5.1.0.14.0.20020522093711.0317ec58@sgss.com>
Date: Wed, 22 May 2002 09:50:47 -0400
To: Julien Eyries <julien.eyries@thales-bm.com>,
	linuxppc-embedded@lists.linuxppc.org
From: Dean McBride <dmcbride@sgss.com>
Subject: Re: Un-killable process???
In-Reply-To: <3CEB62F0.2080302@thales-bm.com>
References: <5.1.0.14.0.20020521144711.0312fc28@sgss.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the response!

I'm actually using wait_event_interruptible() in my driver.  I also setup a
timeout timer to wake me up if for some reason the interrupt doesn't occur.
When I see the problem (Note it doesn't always happen ;(), I notice my
timer executes, but the process still seems to be hung.  One other note,
I'm also using kernel semaphores to protect the registers of the hardware
I'm communicating with during this time.  I've added ioctl()'s to the
driver to
issue up()'s to attempt to release the semaphore and also
wake_up_interruptible()
ioctls to attempt to wakeup the task.  These seem to execute fine, but the
process stay's hung!

Are there any tools, /proc files that can tell me where my task is hung?

The PMC card I'm communicating with is a LM1 ADC/DAC card, where I
have 2 task reading from & writing to the card.

Thanks again for your reply, any other suggestions are greatly appreciated!

Dean


At 11:20 AM 5/22/2002 +0200, Julien Eyries wrote:

>I have had the same problem when writing a driver for my custom hardware
>; It's a well known problem, I found it explained in "Linux Device
>Drivers" by Rubini & Corbet. (i have the french version , it's in chapter 5)
>your driver should use the function "interruptible_sleep_on()" instead
>of "sleep_on()" to block the process .
>if you use "sleep_on()", your process will not receive any signal while
>blocked and then could become "un-killable" .
>
>bye.
>
>
>Julien
>
>
>Dean McBride wrote:
>
>>
>>Hello,
>>
>>I have a process I can't kill (kill -9) without rebooting the system.  I've
>>attempted
>>attaching strace, gdb, etc. to the process, but each of those task just
>>hang.  I
>>can however kill those task (strace, gdb).  I've looked through the
>>/proc/<pid>
>>area, but don't really know what I'm looking for or at!  The task seems
>>to be
>>somehow stuck on some resource, but I don't know which one or how to find
>>out.  I'm running with Linux 2.4.10-pre10 on a 4 processor Power PC with
>>512Mbytes of memory.  The process is reading data from a PMC card.
>>
>>Any ideas or suggestions?  I've include some more information below!
>>
>>Thanks
>>Dean
>>
>>Here's the output from the ps command:
>>    74 root     root     R /opt/ds/src/lm1/bin/lm1_read -s 4 -m 255 -f 4000
>>-a -r -u 2 -g 1
>>
>>
>>Heres the /proc/74/status file
>>
>>sh-2.03# more /proc/74/status
>>Name:   lm1_read
>>State:  R (running)
>>Pid:    74
>>PPid:   62
>>TracerPid:      0
>>Uid:    0       0       0       0
>>Gid:    0       0       0       0
>>FDSize: 256
>>Groups: 0
>>VmSize:     2580 kB
>>VmLck:      2580 kB
>>VmRSS:      2580 kB
>>VmData:     1128 kB
>>VmStk:        16 kB
>>VmExe:        20 kB
>>VmLib:      1188 kB
>>SigPnd: 0000000000044102
>>SigBlk: 0000000000000000
>>SigIgn: 8000000000000000
>>SigCgt: 0000000000004002
>>CapInh: 0000000000000000
>>CapPrm: 00000000fffffeff
>>CapEff: 00000000fffffeff
>>
>>/proc/74/statm file
>>
>>sh-2.03# more /proc/74/statm
>>645 645 317 17 0 628 328
>>
>>
>
>
>--
>Julien Eyries
>R&D engineer
>Thales Broadcast & Multimedia (ex-thomcast)
>email: julien.eyries@thales-bm.com
>fax: 33(0) 1 34 90 31 10
>tel: 33(0) 1 34 90 31 01
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
