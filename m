Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40804091250u1f532cddj9e3897969a98349c@mail.gmail.com>
Date: Wed, 9 Apr 2008 13:50:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Bonesio" <john.bonesio@xilinx.com>
Subject: Re: ppc440 caches - change proposal [RFC]
In-Reply-To: <20080409180042.511531370055@mail134-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
	<1207695415.14711.11.camel@pasglop>
	<fa686aa40804081615n284aa750n12ceb0bf1d1bcce1@mail.gmail.com>
	<20080409180042.511531370055@mail134-sin.bigfish.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 9, 2008 at 12:00 PM, John Bonesio <john.bonesio@xilinx.com> wrote:
> Hi Grant,
>
>  I have a question about your patch. It appears as if the cache setup code is
> in a file that would be used only on Xilinx FPGA devices.

That is correct.

>
>  I understand that many people are using a bootloader that already sets up the
> cache for the kernel, but I'm wondering if Xilinx boards are really a special
> case, or if there may be other non-Xilinx related systems that would also not
> be using a bootloader.

I think there are very few cases of platforms not using some form of firmware.

>
>  I also understand the desire to avoid code that does the same work more than
> once, but I wonder if in this case, it's creating too strong a dependence on
> the specific behavior of a certain bootloader.
>  I also wonder if arch/powerpc is being made more complex by trying to split
>  out this code change into a Xilinx specific area, when the change could just
> be rolled into head_40x.S and we could do away with virtex405-head.S.

In general, I think that the wrapper does not want to touch the cache
settings.  In the common case where firmware exists and sets up the
cache then to turn off the cache again would throw away what firmware
already had in cache and slow down the boot.

That being said, I'm not the bootwrapper expert.  If other think that
it belongs in head_40x.S then I have no objections.

Josh, any thoughts?

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
