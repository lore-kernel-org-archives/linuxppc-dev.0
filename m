From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Mark Abene <phiber@radicalmedia.com>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: Re: 7200/platinum with 2.2.7 kernel...
Date: Mon, 24 May 1999 13:46:47 +0200
Content-Type: text/plain
References: <19990524072457.B26885@radicalmedia.com>
MIME-Version: 1.0
Message-Id: <99052414191900.00642@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Mon, 24 May 1999 schrieb Mark Abene:
>I don't know if anyone has noticed, but as of 2.2.7 (which is what I just 
>checked), the platinum video driver still has the annoying line about three
>inches above the bottom of the screen, from the middle to the right edge.
>This is in modes 19 and 20 at 16bpp, (with the "scale" hack to fix the 
>colormap).  The line was there without the scale-hack, so that's not it.
>I was about to start digging in platinumfb.c to see what the deal is (it's
>changed quite a bit), and unfortunately the first thing I noticed was that
>my name was removed from the opening comments(!).  Rather uncool.  That driver
>and it's header file are still chock-full of a lot of my code, and even my
>comments.  I spent a good deal of time helping Paul M. get that driver working,
>and am confused as to why its current maintainer saw fit to expunge my name.

Hmm, then it was probably not there in the old platinum.c file or I missed to
copy it. But the comments at the top are correct, platinumfb is based on the
controlfb driver, not on the old platinum.c. I only ripped out and modified the
hardware info from platinum.c. And why didn't you stand up ~1 year ago, when
there was lot's of discussion on the lists about the platinumfb and controlfb
drivers? Dan and I could have need help back then.

>Besides which, it looks like a few things were broken when it was "rewritten"
>for fbconsole-style support, which makes me uneasy, since it originally worked
>fine, and as expected.  I know there's a lot of focus on the G3 machines now,
>but I'm sure there're still a decent number of us 7200/8200/PT120 users out
>there who give a damn.  I'll look into the current problems which I'm seeing
>on the list, and I'd welcome anyone's input who's messed with the driver in
>its current state.  Remember, 601 users are people too.

I'm still on my 7200/75 too :-), I just switched a ATI Xclaim3D, cause it's
cheaper to get such a card than to upgrade videomem. That explains why 16bit
and higher modes possibly don't work correctly, it's simply because I can only
test with 1MB on platinunm.

I know only about 3 problems right now, the
color scaling, a typo in the invalidate_cache macro, it should
use dcbf instead of dcbi. Both I haven't forwarded yet to Geert.
The other one is that 832*624*16 won't work with 1MB videomem, cause I had to
align the framebuffer on a 4K boundary.

 Feel free to fix platinumfb as you like, including the copyright. In
fact I would happily hand over "maintainership" to you, as I currently don't use
platinum anymore, except for testing. BTW, what did you test? console, Xpmac or
FBDev?

Franz.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
