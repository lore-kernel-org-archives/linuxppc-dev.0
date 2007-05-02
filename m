Return-Path: <glikely@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id A88EEDDF7A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 01:59:39 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so187863wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 May 2007 08:59:38 -0700 (PDT)
Message-ID: <528646bc0705020859u3f15315v907759d4ea8c71a5@mail.gmail.com>
Date: Wed, 2 May 2007 09:59:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
In-Reply-To: <87wszr48sc.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4636C836.4050502@itee.uq.edu.au>
	<528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
	<4636E142.8010104@itee.uq.edu.au>
	<528646bc0705012247p4a0fff63oa8d98364d5f639b0@mail.gmail.com>
	<87wszr48sc.fsf@sleipner.barco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/2/07, Peter Korsgaard <peter.korsgaard@barco.com> wrote:
> >>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
> GL> Hmm, I think I was smoking something last night.
>
> ;)
>
> GL>  Address used for 8 bit access should not be affected by CPU
> GL> endianess.  After David's comments, I reread the uartlite
> GL> documentation.  The current design is definately for 32bit OPB bus
> GL> connections, but it looks like there is a posibility for xilinx to
> GL> add a 16 or 8 bit attachment.  Since the uartlite design
> GL> explicitly supports 8, 16 and 32 bit access, sticking with 8 bit
> GL> io may be the safest.  However, I still think the application of
> GL> the 3 byte offset should be done in the driver, and not in the
> GL> platform bus registration.
>
> That would effectively make the driver big endian only. What if Xilinx
> would come out with a FPGA with a ARM core in it?

It shouldn't.  When doing byte-wise access, byte 3 is *always* byte 3;
regardless of the endianess of the processor.  It's the endianess of
the device that determines where the individual bytes show up.  The
opb_uartlite documentation defines the registers as big endian,
therefore if you do a bytewise access to address 0x3, you'll always
get the least significant byte of the first register.

Since the 3 byte offset does not change between little endian and big
endian processors then I think the knowledge of the offset should be
kept in the driver, not the device registration.

>
> GL> I've reworked the patch with the following changes - remove 3 byte
> GL> offset from platform bus registration.  - added ulite_in/ulite_out
> GL> macros to make changing bus attachment details simpler if xilinx
> GL> changes the uartlite design.  - stick with 8 bit IO.
>
> Russell didn't like those accessor macros back when it was submitted
> last year:

 >> +static inline void serial_out(struct uart_port *port, int offset, int
 Russell> Since there's no additional complication here, do you need separate
 Russell> serial_in/serial_out inline functions?

As I think the driver should know about the 3 byte offset; the
accessor macro makes sense again.  Plus if Xilinx ever adds a uartlite
varient w/ bytewise or halfword wise registers it becomes much easier
to taylor in the future.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
