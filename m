Date: Sun, 14 Jan 2001 15:51:44 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: console battery meter
Message-ID: <20010114155144.A8028@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

well I ended up finding rather often I wanted to know the details about
power left and such on my powerbook when in console mode or when ssh'd into
the computer.

I wrote this little library this morning that can give you a nice parsed
structure for any app that may want to check the battery status, and also
wrote a three line or so program using the library and the pretty print
function I added to the library to output information about usage when in a
console.

It can handle left battery or right battery or both. It doesnt handle the
older powerbooks (non g3) as I dont have one so didnt add the parsing of
that, though it woudl probably be easy to add if anyone wants it.

The library depends on the pcre2 library.

If anyone wants to use it I put it up on http://wibble.net/~sjh/powerbook or
http://svana.org/sjh/powerbook called readpmud

Anyway I like it, however I do have a few questions about the pmud output
and such.

Why is it when working out time remaining both paulus' Batmon and the
gkrellm plugin use a figure that is not exactly 60*60, they both use 3552
seconds (or in Batmon 59.2 minutes).

My guess is it is something to do with the hardware not feeding cvalues that
are perfectly on the hour and pmud just passes the information straight on
to us.

Also why is the ac not seperate from the individual battery status' ?

I can understand why the charging and the battery present flags are on a per
battery basis, but I dont see how the ac being plugged in makes sense on a
per battery basis rather than machine wide basis. For now I left my library
using it on a per battery basis, but I am wondering.

Anyway the output of the cli program is like this

when full
[15:31:58] 279 shiva sjh ~>readpmud
pmud 0.6, pb model 12, batteries (left (full) 12.38mV)
when just unplugged and in use
[15:34:41] 280 shiva sjh ~>readpmud
pmud 0.6, pb model 12, batteries (left (in use) 99%, 55:01  -86mA 12.25mV)
when just plugged back in to charge
[15:44:08] 13 shiva sjh ~>readpmud
pmud 0.6, pb model 12, batteries (left (charging) 98%, 54:07  -86mA 12.38mV)
as above but with the battery in the other side
[15:44:14] 14 shiva sjh ~>readpmud
pmud 0.6, pb model 12, batteries (right (charging) 98%, 00:10  434mA 12.32mV)

etc etc

I cant test it in both sides as I dont have two batteries, however it should
work (tm)

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
