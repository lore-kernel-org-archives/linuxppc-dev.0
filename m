Message-ID: <3EF1BAE5.8060004@mvista.com>
Date: Thu, 19 Jun 2003 08:30:13 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: j.rakesh@gdatech.co.in
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux porting to IBM405 based board
References: <8ghhrs77sa7f6mu.190620030917@gda-server>
In-Reply-To: <8ghhrs77sa7f6mu.190620030917@gda-server>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rakesh jagota wrote:
> Hi all,
> I am able to port linux in IBM based power pc 405. I have few issues. I am
> not able to kill the process using "ctrl-c". I am not able to use "backspace"
> key to delete the character. Can anyone help me out sort out these silly
> issues.

This problem comes up often.

You can NOT use /dev/console as your interactive login device without
first calling the ioctl to make it a "controlling tty".  (Sorry I don't
have which ioctl handy.)

The correct thing to do is use the serial port, or virtual TTY as your
console device.. i.e.:

/bin/sh < /dev/console > /dev/console   is _WRONG_.  It works for
testing, but you don't have a controlling terminal.

You need to do something like:

/bin/sh < /dev/ttyS0 > /dev/ttyS0

(and if you want to see error messages, redirect that as well)  :)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
