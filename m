Message-ID: <3F4329AB.2090902@2net.co.uk>
Date: Wed, 20 Aug 2003 08:56:27 +0100
From: Chris Simmonds <chris@2net.co.uk>
MIME-Version: 1.0
To: Richard Williams <richard_williams@stratexnet.com>
Cc: "'Todd'" <to_dd@yahoo.com>,
	linux <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: syslog opinion
References: <8D7C5F56B409554D9D46AC22195807F3156FF0@exchwenz01.dmcwave.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Why not use busybox syslogd, which has precisely this feature. Busybox
is at www.busybox.net. Get the latest stable version, 0.60.5, edit the
Config.h file and make sure you enable BB_FEATURE_IPC_SYSLOG. Start
syslogd with the -C switch and all messages are held in a circular
buffer. Its only 16KB by default, but you can patch the code to make it
bigger if necessary. You read the log using the command logread. I use
it a lot in my embedded projects.

Hope this helps,
Chris Simmonds

Richard Williams wrote:

>We are using busybox syslog. It is quite slow compared with writing to a
>file although so far it is coping. Syslog remote logging uses UDP and I have
>found it to be useless as many messages are lost. We log to a local file on
>our embedded ramdisk and then telnet in and cat or tail to look at it. You
>still need a way to limit the log file size. I have thought about writing a
>driver that implements a circular buffer to send syslog output to but for
>now I just delete the file if it gets too big.
>
>Richard
>
>-----Original Message-----
>From: Todd [mailto:to_dd@yahoo.com]
>Sent: Wednesday, 20 August 2003 3:25 a.m.
>To: linux
>Subject: syslog opinion
>
>
>
>I was wondering if anyone has an opinion on using the
>syslog function to log events in an embedded system.
>What the pros and cons might be between using syslog
>(with its large feature set) vs. writing a simple
>logging utility.  I'm not giving too many deatils
>about what I'm trying to accomplish, since I'd rather
>hear about other people's experiences have been.
>
>
>
>


--
Chris Simmonds                        2net Limited
chris@2net.co.uk                      http://www.2net.co.uk/
Tel:   +44 (0)1962 869003             Fax:   +44 (0)870 056 7556
"If it's not connected, it's not effective"(tm)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
