Message-ID: <3F02537C.1090801@stinkfoot.org>
Date: Tue, 01 Jul 2003 23:37:32 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx panics (long)
References: <3EFFD86B.7060007@stinkfoot.org>	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org> <1057053589.32576.310.camel@gaston>
In-Reply-To: <1057053589.32576.310.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

Even with your suggestions, I was unable to get xmon to output
correctly, the framebuffer became too corrupted to get anything useful,
  and the sysmap option couldn't have worked if we couldn't mount
anything anyway, no?

However, I was able to capture the oops, albeit in an interesting way.

Here:

http://www.stinkfoot.org/oops.html

the System.map to go along with it is:

http://www.stinkfoot.org/System.map.ben

and gzipped
http://www.stinkfoot.org/System.map.ben.gz


I apologize for the size, but this sure beats scratching this down on
paper.  If this is not useful, I'm still willing to try whatever you
suggest. I'll have a go at your `devel' tree eventually as well. I
appreciate your time.

Ethan


Benjamin Herrenschmidt wrote:
>
> Edit arch/ppc/xmon/start.c, line 133, change use_screen = 0 to
> use_screen = 1. At least, xmon will display it's full message on screen
> though you'll still won't be able to type commands.
>
> If you additionally load your kernel with it's system.map (that is add
> a line that says "sysmap=/boot/System.map" to /etc/yaboot.conf, and make
> sure /boot/System.map is what was produced when you built the kernel),
> then you'll have at least some symbolic output that can be useful.
>
> Additionally, you can tweak xmon to force display of a stack backtrace
> when it is entered. Edit arch/ppc/xmon/xmon.c, line 394, just before
> "last_cmd = NULL;", add "backtrace(excp);".
>
> Finally, you can also disable xmon in the kernel config and see if you
> get an Oops message you can copy manually.
>
>
>>The aic7xxx driver's output is as usual, it begins to initialize... and
>>then we get the crash.
>>
>>Is there anything else I can do here?  I've heard I can replace the
>>internal modem with a third party serial interface.  I'd be willing to
>>try this to get a serial console for debugging.
>
>
> Additionally, you can try upgrading to Justin Gibbs latest driver
> (I don't have the URL at hand right now though, but I'll soon update
> my "devel" rsync with a 2.4.22-pre snapshot that contains that latest
> version)
>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
