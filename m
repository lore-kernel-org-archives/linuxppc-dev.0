Message-ID: <19990525104937.F26885@radicalmedia.com>
Date: Tue, 25 May 1999 10:49:37 -0400
From: Mark Abene <phiber@radicalmedia.com>
To: Jerry Quinn <jquinn@nortelnetworks.com>
Cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: turbo mouse driver fix...
References: <19990525024524.D26885@radicalmedia.com> <374AA46D.A1A4BAFC@americasm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <374AA46D.A1A4BAFC@americasm01.nt.com>; from Jerry Quinn on Tue, May 25, 1999 at 09:23:57AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't THINK it should break anything, since it's only being done after the
Kensington is being properly identified through its register 1 signature.
The problem is that the TurboMouse 5 takes up two adb id's.  When it first
comes up, they're typically both on 3, then one gets moved to 15.
Maybe I could have the driver check itself, if we're currently using id 15,
then the control id is definitely 3?  There really aren't any clean privisions
in the driver for dealing with mice/trackballs that use two id's.  I just
assume that if we already detected our signature, then assume the control
id is 3.  I know it's not clean, but unless me or someone else thinks of a 
better way, it works...  without mousemode or mousehack needed.

-Mark

On Tue, May 25, 1999 at 09:23:57AM -0400, Jerry Quinn wrote:
> 
> Naive question here:  Does id 3 refer to the adb device?  The reason I
> ask is that when I had the 2.2.0/1 kernel, 3-button detection wasn't
> working properly in my setup.  At the time the answer was supposed to be
> running 
> 
> mousemode 3 4
> 
> However, in my setup I also had a joystick connected.  So in reality I
> sometimes had to do mousemode 15 4 randomly.  I guess it was whichever
> device got recognized first.
> 
> Anyway, my point is that if this is the device id, assuming id 3 may not
> be the correct thing to do in general.
> 
> If it's not device id, just ignore me :-)
> 
> -- 
> Jerry Quinn                             Tel: (514) 761-8737
> jquinn@nortelnetworks.com               Fax: (514) 761-8505
> Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
