Date: Thu, 28 Jun 2001 12:03:46 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: addresses in xmon trace output?
Message-ID: <20010628120346.A627@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

what are the addresses you see in an xmon trace output? I had a crash
yesterday with benh 2.4.6-pre3 (rsynced two days ago) where typing x in xmon
didnt recover normal operation of the machine.

So the T command seemed to give some interesting numbers I assumed were
addresses in the system map I could look up once I rebooted.

[11:35:34] 22 shiva sjh ~>cat mon_crash
c67b2098 c00e1bd8 c00e1080 c011f9df c00de590 c00de7ec c003b6a4 c0003b3c
exception:c00 [c67a1e90] fe0f640 feeff40 feeff44 fecef4f4 fecfd4c feca62c feaaab8 10001808 fd9675c 0
[11:35:47] 23 shiva sjh ~>for i in c67b2098 c00e1bd8 c00e1080 c011f9df c00de590 c00de7ec c003b6a4 c0003b3c ; do grep -i $i /boot/System.map-2.4.6-pre3 ; done
c0003b3c T ret_from_syscall_1
[11:36:25] 24 shiva sjh ~>for i in fe0f640 feeff40 feeff44 fecef4f4 fecfd4c feca62c feaaab8 10001808 fd9675c ; do grep -i $i /boot/System.map-2.4.6-pre3 ; done
[11:37:18] 25 shiva sjh ~>grep c67a1e90 /boot/System.map-2.4.6-pre3
[11:37:34] 26 shiva sjh ~>

so they are not addresses in there (well except possibly for the
ret_from_syscall_1

This is on a pismo, the crash happened when I opened the lid (woke up form
sleep) in X (4.1.0), the mosue wasnt appearing and I couldnt change desktops
with the control arrow combo (sawfish) so I switched to console, then back to
X, as I came back to X the xmon console appeared overwriting my X display.

I will see if this is reporducable tonight (currently I am running 2.4.4 benh
as it doesnt exhibit this crash) as I expect to see paulus tonight so can
maybe show him the xmon console after the crash and get hi mto look at it.

Anyway what are the addresses in the xmon trace?

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
