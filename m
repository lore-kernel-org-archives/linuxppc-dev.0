Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id C689367A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 21:24:30 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so354260wri
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 02:24:29 -0800 (PST)
Message-ID: <528646bc05021202175e967842@mail.gmail.com>
Date: Sat, 12 Feb 2005 03:17:49 -0700
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <528646bc05021201091a106a96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <EF7A806FA57EF5448A0885E06E1DB5CC07DEAE@noifps03.barco.com>
	<528646bc05021201091a106a96@mail.gmail.com>
Subject: Fwd: Memory Size Requirement to Run Linux on Embedded Environment
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Forgot to include list in reply; oops.

g.


---------- Forwarded message ----------
From: Grant Likely <glikely@gmail.com>
Date: Sat, 12 Feb 2005 02:09:13 -0700
Subject: Re: Memory Size Requirement to Run Linux on Embedded Environment
To: "David, Albert" <Albert.David@barco.com>


On Sat, 12 Feb 2005 09:19:19 +0100, David, Albert
<Albert.David@barco.com> wrote:
>
>
> Hi everyone!
> I am new to linux and my current project is to port linux on our custom
> hardware based on PPC405EP(AMCC).
> Currently we are in a hardware design phase but I am finding it hard to
> decide the Flash and SDRAM Memory size.
> We are planning to us 2.6 Kernel, with minimum hardware interfaces.
>
> Should we use Kernel 2.4 or 2.6?
Use 2.6 unless you have a ready to go 2.4 port for your board which
you do not need to modify.  This also assumes that you don't need any
of the new 2.6 features.
>
> I assume the binary size of my application that will run on linux would be
> around 2 to 3 MB. By considering these facts of my hardware, what would be
> the size of kernel? And how many drivers I may require? What would be the
> size of my root file system?
2 to 3 MB if all you put on it is your app, slightly larger otherwise.
 A very minimal system w/ busybox will easily fit into 1 or 2 MB.
>
> There will be parameters of about 65KB are to be used and these parameters
> can be changed in the field. This parameter block will have 2 copies to
> avoid data corruption due to power fail. Hence to avoid the use of NAND
> Flash I will be using 2 Parameter files to read and write(into flash) in a
> linux environment during normal operation. Am I right??
You could map the FLASH as a MTD device and write to two different
sectors directly; then you can use a RAM disk instead of going with
JFFS on your flash.  Use a separate RedBoot partition for each
parameter sector.  (Note; using RedBoot partitions does not preclude
using u-boot)
>
> In this mailing list I have read the typical size of U-BOOT will be around
> 256KB as suggested by Wolfgang Denk.
U-boot will live at the beginning of flash.  The u-boot environment
will take up another sector.  Your parameter files will take up at
least one sector each.  The rest can be dedicated to the kernel and
initrd images.  Set up a RedBoot partition for each.
>
> A rough approximation of Flash and SDRAM size would help me a lot to proceed
> with my hardware design.
How much RAM does your app need?  32M is gobs for a simple system.  If
it's ultra simple you may even be able to go down to 16 (don't quote
me though).  Add more if your app is RAM hungry.  16M of flash should
also be gobs.  (Assuming 1-2M for the kernel and the rest for the
initrd image)

Make sure you use uClibc and busybox if you want to keep your system small.

Cheers,
g.
