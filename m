To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB on PPC440GP (cache incoherent)
References: <52hekebq2a.fsf@topspin.com>
	<200206080845.g588jvX11858@fachschaft.cup.uni-muenchen.de>
From: Roland Dreier <roland@topspin.com>
Date: 08 Jun 2002 13:43:26 -0700
In-Reply-To: <200206080845.g588jvX11858@fachschaft.cup.uni-muenchen.de>
Message-ID: <52ptz1a4cx.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Oliver" == Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> writes:

    Oliver> This can be used in error handling by storage devices. You
    Oliver> must use GFP_NOIO.  And you should check for a failure due
    Oliver> to OOM.

Yep, I caught those missed checks for allocation failure.  And I will
change to using GFP_NOIO where appropriate.

    Roland> -		srb->request_buffer = srb->sense_buffer;
    Roland> +		srb->request_buffer = kmalloc(18, in_interrupt() ? GFP_ATOMIC :

    Oliver> However, why do you do this ? The srb is kmalloced.

Yes, but srb->sense_buffer is not aligned on a cache line boundary.
My feeling is that this could corrupt the rest of the cache line,
though others have questioned whether this is strictly necessary.  I
just posted a question on lkml to try to and get an authoritative
answer on DMA into unaligned buffers is OK.

Thanks for the comments,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
