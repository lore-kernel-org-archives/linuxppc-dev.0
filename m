Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Thu, 15 Nov 2001 17:23:10 -0500
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111151649150.27274-100000@www.cgsoftware.com>
In-Reply-To: <Pine.LNX.4.33.0111151649150.27274-100000@www.cgsoftware.com>
MIME-Version: 1.0
Message-Id: <20011115222028.CWJE7882.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

> No, it's actually the setting of dfp parameters from the EDID that
> causes problems
>
> If i remove of_edid from the command line, it works great.
> Add it back, and i get the flashing.
> If i change the if (use_OF_EDID) in radeon_get_dfpinfo to if (0), all is
> good again.
>
> So something is wrong.

Can you send me a copy of your /proc EDID1 one file (use hexdump to
convert it to hex) and I can run xxd -r to convert it back to binary and
run my edid parser on it.

That way we can compare your timings and dotclock in the EDID1 block to
the timing you use normally.  Perhaps your EDID block has numerous timing
and the first is not the right one to use.  My code only looks at the
first set of detailed timings but could be easily changed to grab them all.

My guess it is defintely timing related.  You also might want to turn
debug on in radeonfb.c so that we can see what timings are actually being
used under both methods.

Thanks for testing it!

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
