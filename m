From: "Ira K. Weiny" <iweiny@kdat.csc.calpoly.edu>
Message-Id: <199908130629.XAA20290@kdat.csc.calpoly.edu>
Subject: pppd and netscape crashes
To: linuxppc-user@lists.linuxppc.org (linuxppc),
        linuxppc-dev@lists.linuxppc.org (linuxdev)
Date: Thu, 12 Aug 1999 23:29:04 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok more on this subject...  This is long so please forgive me.
BTW I am sending this to linuxppc-dev because Paul asked me what was wrong
with ppp.  Thanks for being patient.
(I don't want to offend anyone here but I don't know where to begin on this.)

Ok as some of you know the pppd and kernel crash for some of us whenever we
are logged on.  From others comments this mainly happens when running
Netscape but for me it happend when I was running rlogin.

My first question is am I running pppd right?  I have just run an expierment
and it appears that ppp will work the first time I run it and fail the
second?  So here are the scripts I am running.

ppp-izap:
#!/bin/sh
/usr/sbin/pppd nobsdcomp nodeflate connect '/usr/sbin/chat -v -f /home/root/System/ppp/izap.cua1' defaultroute 115200 /dev/ttyS0 &

/home/root/System/ppp/izap.cua1:
ABORT BUSY ABORT 'NO CARRIER' '' '\n\n' '' AT OK ATDT5800155 CONNECT ''
login: 5037iweiny
ssword: <password>

ppp-stop: (using this to quit ppp)
#!/bin/sh
if [ -s /var/run/ppp0.pid ]
then
   echo "Stopping pppd"
   kill `cat /var/run/ppp0.pid`
fi

echo "Hanging up Modem"
/usr/sbin/chat "" "\p+\p+\p+\c" '' "\d\dATH0" > /dev/ttyS0
/usr/sbin/chat "" "\p+\p+\p+\c" '' "\d\dATH0" > /dev/ttyS0



After running ppp-izap, ppp-stop, and then ppp-izap again.  I run netscape
and I can almost ALWAYS crash it by going...  (In my expierment I did this
2 time in a row and both times the next thing the system did was give me the
OF prompt!)
www.linuxppc.org -> Frequently Asked Questions -> Interactive FAQ

At this point the watch cursor freezes.  NO movement whatsoever...  I have
tried to log into the box over the eth0 but it does not respond.

After a minute or so...  (I went and washed dishes.)  The computer rebooted
itself and I was back at the OF prompt.

I have syslogd logging all messages and there is nothing there past.
Aug 12 22:37:00 batcave2 kernel: registered device ppp0

And one final note, on bootup kernel reports this.
Aug 12 22:51:13 batcave2 kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Aug 12 22:51:13 batcave2 kernel: Inspecting /boot/System.map-2.2.6-15apmac
Aug 12 22:51:15 batcave2 kernel: Loaded 16761 symbols from
/boot/System.map-2.2.6-15apmac.
Aug 12 22:51:15 batcave2 kernel: Symbols match kernel version 2.2.6.
Aug 12 22:51:15 batcave2 kernel: No module symbols loaded.

Am I intrepreting this correctly to say that the System.map is ok and the
log file should report anything the kernel has to say?

Indeed I am running vmlinux-2.2.6-15apmac just as it was installed by
the installer.
A PowerMac 8500 604 120Mhz
176MB ram
Diamond Supra Express Modem...  (I know this does not make a difference.)

Any ideas?

Thanks
Ira Weiny
iweiny@acm.org



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
