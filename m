To: Dan Malek <dan@netx4.com>
Cc: "Brown, David (dbrown03)" <DBrown03@harris.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is it normal for serial ports to drop characters at the end?
References: <BE1C564723B3D21191FD0000F840E39801D814F1@rfcmx2.rfc.comm.harris.com> <veya5rv3gj.fsf@lipta.cendio.se> <391083CC.7E08CC54@embeddededge.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 03 May 2000 22:05:37 +0200
In-Reply-To: Dan Malek's message of "Wed, 03 May 2000 15:53:48 -0400"
Message-ID: <veu2gfv1pq.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Marcus Sundberg wrote:
>
> > Right on target.
> > rs_8xx_wait_until_sent() will wait for the *first* buffer descriptor
> > to be finished, instead of waiting for the last one as it should.
> > This patch fixes that problem:
>
> That's part of it, but we also need to perform a graceful shutdown
> of the port so we wait until the hardware FIFOs are empty.  Waiting
> for the buffer descriptor just means the CPM moved the last data
> from the buffer, not that it has gone out the wire.

Sure, but the above "works perfect for me(tm)", at least in 9600bps.

> I thought I did this once.....but, why are you closing devices anyway :-).

I think I experienced this first when using the busybox init
implementation, which IIRC opens and closes /dev/console for each
message. Otherwise I've never seen it in a real application.

/Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
