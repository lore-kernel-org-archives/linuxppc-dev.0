Message-ID: <3B55FFA9.2050204@hadess.net>
Date: Wed, 18 Jul 2001 22:29:13 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
References: <Pine.LNX.4.33.0107182204380.2441-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I reckoned that some people would like to see this. I didn't look into
this much yet, but would like to hear if somebody plans to work on it
(and if not, I like to take a look at it this week-end).

This is an edit I did for myself of a conversation I had on IRC with
Franz Sirlz... I'm the one asking the stupid questions ;)
Oh, and you have to use the linux_keycodes, not the adb conversion layer

<hadess> franzo: hmm, any code on using the new input layer, or anything ?
<franzo> you mean the event devices? just look into the  sample codes in
the linuxconsole-dev cvs on sourceforge
        http://linuxconsole.sourceforge.net/
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linuxconsole/ruby/

<hadess> franzo: what is the output of evtest supposed to be when tested
on a keyboard ?
<franzo> Event: time 994192244.334929, type 1 (Key), code 28 (Enter),
value 0
<franzo>  Event: time 994192246.286645, type 1 (Key), code 57 (Space),
value 1

<franzo> hadess, so  no key works with evtest?
<franzo> hadess, iif the keys don't show up, they are probably missing
in the  USB  table in the kernel
<hadess> franzo: the "volume" and eject keys don't show up in any of the
kbd event devices
<hadess> franzo: how could i add these keys then ?
<franzo> hadess, add more known keys to static unsigned char
hid_keyboard[256] in usb/hid.c, that iis the  USBB-to-linux keycode mapping
<hadess> franzo: hehe, how do i get the usb keycodes ?
* hadess annoys franzo
<franzo> hadess, any kernel messages in /var/log/messages?
<hadess> franzo: not if i load the evdev
<hadess> franzo: it showed some unknow keycodes before, yes

Cheers

---
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
