Date: Fri, 20 Apr 2001 11:46:19 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Steven Hein <ssh@sgi.com>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
In-Reply-To: <3ADF4386.3DCF6725@sgi.com>
Message-ID: <Pine.HPX.4.10.10104201111430.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 19 Apr 2001, Steven Hein wrote:

> I know this isn't under your control, but......
>
> If this is the case (that setting the RTC is properly done through
> /dev/rtc using hwclock, etc.), then doing a "date --set" no longer
> sets the RTC, correct?  And it will never cause the RTC to be set?

stime/settimeofday never set the RTC on other archs, PPC was the
exception and as such the one to change.

> .....Seems to me that separating the setting of the RTC from setting
> the kernel/system time is a Bad Idea.....There's probably more to it
> than that, or maybe "date --set" isn't considered a proper way to
> manipulate the system clock anymore (maybe it never was   :).

It never was, and actually it's better like this. You have the RTC and the
kernel notion of time which are not necessarily the same. Explicit
synchronization is better than implicit one, especially for tests.

While it's over now, two years ago people were setting the clock at
1999/12/31 23:xx:xx to check for Y2K effects. In this case you didn't want
the RTC be updated to be able to use clock -s when tests are finished and
you're back to fixing problems (unless you enjoy wrong timestamps on your
files and confusing Make). Besides that some old RTC had problems on
their own AFAIR, but not updating them kept the problems separate.

Right now, for astronomical source tracking I am going to test leap second
handling, so I need to set the date just before midnight after setting the
right flags, run some code touching as few files as possible, and using
ntpdate to go back to normal while hacking. I certainly prefer the RTC not
to be updated back and forth for these tests (they involve kernel code, in
case of crash early rc scripts would be executed with the wrong date and
play havoc with my logs/whatever).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
