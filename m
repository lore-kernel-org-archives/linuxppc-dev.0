Return-Path: <mgessner@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 5A59ADDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 07:18:40 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so722386qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 12:18:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4989E8FC.9090002@nishioka.com>
References: <4989C635.1050605@trimble.com> <4989E8FC.9090002@nishioka.com>
Date: Wed, 4 Feb 2009 15:18:37 -0500
Message-ID: <85a5c2010902041218p6bc652d5j486448f5f7031881@mail.gmail.com>
Subject: Re: kernel 2.6.24 USB wi fi device firmware loading issue(s):
	rt73.bin...
From: Matt Gessner <mgessner@gmail.com>
To: mike_timmons@trimble.com, alan@nishioka.com, linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0015175d670836801604621d7e2a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175d670836801604621d7e2a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2009 at 2:14 PM, Alan Nishioka <alan@nishioka.com> wrote:

> request_firmware uses the hotplug code so the kernel doesn't have any
> sourceless binaries compiled into it.  on init, the driver requests the
> firmware, user mode hotplug daemon loads the firmware from disk and gives
> the driver a pointer to it.
>
> since this is a short term problem, i would suggest converting rt73.bin to
> a header file and compiling it into the kernel.  you have to make a few
> minor changes to where request_firmware is called, but in the end firmware
> is just an array of bytes with a pointer to it.  this is what i did when i
> was testing usb wifi a little while ago.
>
> i am probably going to open source hell for suggesting this, but i'm a
> hardware engineer, so i am in hell already.
>
> alan nishioka


Yes, you will certainly burn for this.  :-)

Mike Timmons:

I'll show you how MINE works (and if someone out there can point out errors,
fire away -- I'm not making the claim that this is completely correct).  I
hope that this will be new and helpful information for you.  If it's not, my
apologies; feel free to dump this in the bit bucket.

In my /sbin/hotplug I have a bunch of stuff for doing field updates, but at
the very bottom, I have this:

if [ "$1" == "firmware" ] && [ "$ACTION" == "add" ]; then
  echo 1 > /sys/$DEVPATH/loading
  cat /lib/firmware/$FIRMWARE > /sys/$DEVPATH/data
  echo 0 > /sys/$DEVPATH/loading
  echo "RT73 firmware loaded." > /dev/console
fi

That's how the firmware is loaded.

caveat: I am using 2.6.25 in my system.  I have no idea what's changed from
.24 to .25 that might be getting in your way.  You could consider moving
just the section in .25 that deals with the chipsets in question (ralink, I
think??).

I put all this together in about an hour after doing a little reading.  It
all works very well.

Now if I could just get that pesky AP mode working...

Also in my hotplug script is

if [ "$1" == "net" ] && [ "$ACTION" == "add" ] && [ "$INTERFACE" == "wlan0"
]; then
  iwconfig wlan0 mode managed
  iwconfig wlan0 channel auto
  iwconfig wlan0 key DADADADADADADADADADADADADA
  iwconfig wlan0 essid mlxwap
fi

You will want to get the sources for the wifi utilities compiled for your
target, too.  Not hard to do.  I don't think I had to make any changes to
it.

Those who wish, feel free to post suggestions, etc.  I'm doing all of my
work on an ARM target, so I don't know if there are any gotchas in the rt
drivers for the rt73 usb stuff.

Also, you could check out rt2x00.serialmonkey.com if you haven't found it.
They are live (well, mostly dead) on #rt2x00 on freenode.

Good luck; if you have questions, feel free to email me directly.

--0015175d670836801604621d7e2a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Feb 4, 2009 at 2:14 PM, Alan Nis=
hioka <span dir=3D"ltr">&lt;<a href=3D"mailto:alan@nishioka.com">alan@nishi=
oka.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
request_firmware uses the hotplug code so the kernel doesn&#39;t have any s=
ourceless binaries compiled into it. &nbsp;on init, the driver requests the=
 firmware, user mode hotplug daemon loads the firmware from disk and gives =
the driver a pointer to it.<br>

<br>
since this is a short term problem, i would suggest converting rt73.bin to =
a header file and compiling it into the kernel. &nbsp;you have to make a fe=
w minor changes to where request_firmware is called, but in the end firmwar=
e is just an array of bytes with a pointer to it. &nbsp;this is what i did =
when i was testing usb wifi a little while ago.<br>

<br>
i am probably going to open source hell for suggesting this, but i&#39;m a =
hardware engineer, so i am in hell already.<br><font color=3D"#888888">
<br>
alan nishioka</font></blockquote><div><br>Yes, you will certainly burn for =
this.&nbsp; :-)<br><br>Mike Timmons:<br><br>I&#39;ll show you how MINE work=
s (and if someone out there can point out errors, fire away -- I&#39;m not =
making the claim that this is completely correct).&nbsp; I hope that this w=
ill be new and helpful information for you.&nbsp; If it&#39;s not, my apolo=
gies; feel free to dump this in the bit bucket.<br>
<br>In my /sbin/hotplug I have a bunch of stuff for doing field updates, bu=
t at the very bottom, I have this:<br><br>if [ &quot;$1&quot; =3D=3D &quot;=
firmware&quot; ] &amp;&amp; [ &quot;$ACTION&quot; =3D=3D &quot;add&quot; ];=
 then<br>
&nbsp; echo 1 &gt; /sys/$DEVPATH/loading<br>&nbsp; cat /lib/firmware/$FIRMW=
ARE &gt; /sys/$DEVPATH/data<br>&nbsp; echo 0 &gt; /sys/$DEVPATH/loading<br>=
&nbsp; echo &quot;RT73 firmware loaded.&quot; &gt; /dev/console<br>fi<br><b=
r>That&#39;s how the firmware is loaded.<br>
<br>caveat: I am using 2.6.25 in my system.&nbsp; I have no idea what&#39;s=
 changed from .24 to .25 that might be getting in your way.&nbsp; You could=
 consider moving just the section in .25 that deals with the chipsets in qu=
estion (ralink, I think??).<br>
<br>I put all this together in about an hour after doing a little reading.&=
nbsp; It all works very well.<br><br>Now if I could just get that pesky AP =
mode working...<br><br>Also in my hotplug script is<br><br>if [ &quot;$1&qu=
ot; =3D=3D &quot;net&quot; ] &amp;&amp; [ &quot;$ACTION&quot; =3D=3D &quot;=
add&quot; ] &amp;&amp; [ &quot;$INTERFACE&quot; =3D=3D &quot;wlan0&quot; ];=
 then<br>
&nbsp; iwconfig wlan0 mode managed<br>&nbsp; iwconfig wlan0 channel auto<br=
>&nbsp; iwconfig wlan0 key DADADADADADADADADADADADADA<br>&nbsp; iwconfig wl=
an0 essid mlxwap<br>fi<br><br>You will want to get the sources for the wifi=
 utilities compiled for your target, too.&nbsp; Not hard to do.&nbsp; I don=
&#39;t think I had to make any changes to it.<br>
<br>Those who wish, feel free to post suggestions, etc.&nbsp; I&#39;m doing=
 all of my work on an ARM target, so I don&#39;t know if there are any gotc=
has in the rt drivers for the rt73 usb stuff.<br><br>Also, you could check =
out <a href=3D"http://rt2x00.serialmonkey.com">rt2x00.serialmonkey.com</a> =
if you haven&#39;t found it.&nbsp; They are live (well, mostly dead) on #rt=
2x00 on freenode.<br>
<br>Good luck; if you have questions, feel free to email me directly.<br></=
div></div><br>

--0015175d670836801604621d7e2a--
