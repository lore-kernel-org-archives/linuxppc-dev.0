From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14231.11325.439987.587932@gargle.gargle.HOWL>
Date: Thu, 22 Jul 1999 10:35:41 -0400 (EDT)
To: Lucas Vergnettes <lucas@promac.org>
Cc: LinuxPPC Developpers <linuxppc-dev@lists.linuxppc.org>
Subject: Bug Report : Kernel Panic w/ PPP & Netscape
In-Reply-To: <19990722142841.A811@promac.org>
References: <19990722142841.A811@promac.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



lv> Hi everyone.
lv> 
lv> Iwolud like to submit a bug report. This problem happens on my box something
lv> like 2 times a day, and is ~quite~ annoying ;)
lv> 
lv> I hope this is the good place for this kind of messages.
lv> 
lv> The situation :
lv> A powermac 7300/166, YellowDog 1.0, an ATI video card (the one from the 9500s
lv> ATY,MACH64) and an Olitec 56k modem.
lv> 
lv> When I startup ny internet connexion (ala redhat : ifup ppp0), everything is
lv> ok, but when i start browsing with netscape, the problems begin... This is a
lv> typical log :
lv> 
lv> Jul 22 14:01:14 wip ifup-ppp: pppd started for ppp0 on /dev/ttyS1 at 115200
lv> Jul 22 14:01:15 wip kernel: registered device ppp0
lv> Jul 22 14:01:15 wip pppd[614]: pppd 2.3.5 started by root, uid 0
lv> Jul 22 14:01:16 wip chat[617]: send (AT&F1M0^M)
lv> Jul 22 14:01:16 wip chat[617]: expect (OK)
lv> Jul 22 14:01:16 wip chat[617]: ^M
lv> Jul 22 14:01:16 wip chat[617]: OK
lv> Jul 22 14:01:16 wip chat[617]:  -- got it
lv> Jul 22 14:01:16 wip chat[617]: send (ATDT0836019301^M)
lv> Jul 22 14:01:16 wip chat[617]: expect (CONNECT)
lv> Jul 22 14:01:16 wip chat[617]: ^M
lv> Jul 22 14:01:47 wip chat[617]: ATDT0836019301^M^M
lv> Jul 22 14:01:47 wip chat[617]: CONNECT
lv> Jul 22 14:01:47 wip chat[617]:  -- got it
lv> Jul 22 14:01:47 wip chat[617]: send (^M)
lv> Jul 22 14:01:47 wip chat[617]: send (AT&F1^M)
lv> Jul 22 14:01:47 wip pppd[614]: Serial connection established.
lv> Jul 22 14:01:48 wip pppd[614]: Using interface ppp0
lv> Jul 22 14:01:48 wip pppd[614]: Connect: ppp0 <--> /dev/ttyS1
lv> Jul 22 14:01:48 wip pppd[614]: Remote message:
lv> Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-21
lv> Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-26
lv> Jul 22 14:01:48 wip modprobe: can't locate module ppp-compress-24
lv> Jul 22 14:01:49 wip pppd[614]: local  IP address 193.250.81.28
lv> Jul 22 14:01:49 wip pppd[614]: remote IP address 193.251.116.157
lv> Jul 22 14:02:00 wip kernel: FB. overflow: 1
lv> Jul 22 14:02:00 wip kernel: FB. overflow: 2
lv> Jul 22 14:02:00 wip kernel: FB. overflow: 3

I can't say that I know what your overflow problem is.  However, you are
missing compression.  I ran into problems when I didn't tell pppd to turn off
compression when modprobe wasn't able to find the compress modules.

If you have the modules (bsd-compress.o and ppp-deflate.o) for your kernel
version in the right place (/lib/modules/<version>/ppp I think), then you need 
to add the following to /etc/conf.modules:

ppp-compress-21 = bsd-compress
ppp-compress-24 = ppp-deflate
ppp-compress-26 = ppp-deflate


Paul Mackerras has added the definitions to the latest modutils package, so
installing that will solve the problem.

In the meantime, try telling pppd to use no compression and see if your
problems go away.  If not, it will at least remove a confounding variable.

lv> Lucas Vergnettes  -- Osteopathy Student --  mailto:lucas@promac.org

Hope this is helpful

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
