Message-ID: <3EB76257.6000407@paulidav.org>
Date: Tue, 06 May 2003 00:20:55 -0700
From: Vladimir Gurevich <vag@paulidav.org>
MIME-Version: 1.0
To: None Atall <linux_meis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Kernel generic question (procedure queue)
References: <20030506064428.74357.qmail@web9704.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Dimitrios,

There are a number of mechanisms in the Linux kernel
that allow you to schedule execution of some code at
a later time as well as to wait for something to
happen. Wait queues, tasklets, kernel timers are
the most important ones.

The problem is that to choose and to use them properly
you need to know how they work, how they differ from
each other and how they are supposed to be used (because
they can easily be misused and this usually leads to
disasters). It is definitely not possible to go over
it in an email, so I'd refer you to the excellent book
by Rubini and Corbet that discusses all these (and many
other) issues.

As for your question goes, there are two main mechanisms
you should look at:
   -- wait queues are usually used in drivers to
      return the control to the scheduler until the
      HW operation is finished. Look for
      interruptible_sleep_on() and wake_up_interruptible()

   -- I don't know exactly how do you plan to use your GPIOs
      to implement SPI, but if you plan to use interrupts
      you might be better of by using the write_buff()
      function to fill your driver's buffer, submit
      the first byte to the device via write_byte() and then go
      to sleep on a wait queue. Then use the interrupt handler
      to drain the buffer and wake up the process after
      you have finished sending data (you can also use kernel
      timers to wake it up in case there was a timeout).

But my main advise will be to get yourself a copy of
"Linux Device Drivers" by Rubini and Corbet first.

Happy hacking,
Vladimir Gurevich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
