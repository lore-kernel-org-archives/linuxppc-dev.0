To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Another try at the run-from-Flash issue for MPC8xx/MBX/custom
References: <38E27471.83CCAC10@innocon.com>
From: Markus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 30 Mar 2000 10:51:52 +0200
In-Reply-To: Doug Rogers's message of "Wed, 29 Mar 2000 16:24:01 -0500"
Message-ID: <kfyg0t8yh5j.fsf@kieraypc25.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Doug Rogers <rogers@innocon.com> writes:

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
> I was hoping that Linux was to that point, but apparently not.

I haven't seen anyone say it couldn't be done. I wrote:

  Well, I see no reason why it shouldn't be possible, but not without
  modifying things.

  You'd need to link the .data, .data.cacheline_aligned, .data.init
  and .bss sections so they are located in RAM, and the former
  three plus the exception vectors would have to be copied from flash
  to their linked location.

I haven't tried it myself though.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
