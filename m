Date: Fri, 12 Feb 1999 15:07:01 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Brad Midgley <brad@pht.com>
Subject: modes "default" solutions
In-Reply-To: <Pine.LNX.4.03.9902041637590.9956-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.95.990212145306.1563A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


geert,

I have been experimenting to try to find out when and why modes "default"
doesn't work with Xfb.

1. modes default is incompatible with acceleration provided by Xfb.
problems range from messed up colormaps to a white screen pocked with
artifacts. if you need modes default, turn off acceleration:

Section "Device"
    Identifier "Linux Frame Buffer Device"
    Option "noaccel"
EndSection

2. if you run vmode and it reports something like "0 32" for the current
mode, Xfb will come up with an oversize virtual screen if it's run with
modes default. however, if vmode comes up with something like "15 32" then
the virtual screen size will match the real screen size. 

unfortunately, the os is not setting the first parameter correctly at
startup, so the only way to have vmode return something sensible is to use
it to set the value, eg by running vmode 15 32 at startup.

i am going to look into why the os isn't setting the first value properly.

i'm observing both these behaviors on an imac and on a 7500 with an ati
xclaim vr board.

Brad
brad@pht.com | http:/www.pht.com/~brad/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
