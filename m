Message-ID: <38E3BB77.890DB46D@email.sps.mot.com>
Date: Thu, 30 Mar 2000 14:39:19 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another try at the run-from-Flash issue for MPC8xx/MBX/custom
References: <38E27471.83CCAC10@innocon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doug,
  Do you have the I-Cache enabled when decompressing?  What about
disabling serialization? (Set ICTRL to 0x7)

Doug Rogers wrote:
>
> I, too, would like to run from Flash. The question for me isn't speed,
> isn't cost, nor EMI effects. It is simply a matter of size. We have a
> very small area in which to squeeze the parts, and the best we could do
> is 32M RAM and 16M ROM. Our application code is in the 10M range (text
> only, even after chopping over half of it out!), but it is expected to
> grow. So for us it's not really a matter of cost or (running) speed,
> since the Flash runs fast enough for our purposes.
>
> As another constraint, our card needs to be able to run very soon after
> power-up. I've hacked the LynxOS startup monitor to detect either gzip'd
> or bzip2'd KDI's. I've timed the decompression of our smaller test image
> and it takes over 40 seconds on a 40MHz MBX860 board. That's too slow.
> We could live with 20, perhaps, but not much more than that. For now I
> boot my images over the network since our MBX board has only 4M Flash.
> It's faster than decompressing!
>
> With LynxOS, we're able to keep in Flash both the text sections of the
> kernel AND of all binaries on the filesystem. Wow! That allows us to put
> only the RAM disk and vector/data/bss sections into RAM. Shweet!
>
> I was hoping that Linux was to that point, but apparently not. Just
> having the kernel run from ROM would be helpful for now, so if anyone
> out there has done so, I'd be very appreciative of any feedback.
>
> Thanks!
>
> Doug
>
> --
> --_._-__-____------_--_-_-_-___-___-____-_--_-___--____-___--_-__--___-_
> Doug Rogers, ICI   | The strongest reason for the people to retain the
> V:703.893.2007x220 | right to keep and bear arms is, as a last resort,
> www.innocon.com    | to protect themselves against tyranny in
> ___________________| Government. [Thomas Jefferson]
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
