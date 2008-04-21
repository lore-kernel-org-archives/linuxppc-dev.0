Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 0DB08DE1A0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:41:30 +1000 (EST)
Date: Mon, 21 Apr 2008 20:41:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080421164128.GA28561@polina.dev.rtsoft.ru>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
	<fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
	<20080421143313.GB18008@polina.dev.rtsoft.ru>
	<20080421144938.GA25627@polina.dev.rtsoft.ru>
	<fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 08:58:09AM -0600, Grant Likely wrote:
> On Mon, Apr 21, 2008 at 8:49 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> >  > > Should this really be a arch_initcall()?  Would it be better for
> >  > > platforms needing it to call it explicitly from one of the platform's
> >  > > machine_arch_initcall()?  Otherwise it gets called for all platforms
> >  > > in a multiplatform kernel.
> >  >
> >  > Ok, I'll place it into qe_reset().
> >
> >  Ugh, no, I can't. qe_reset() is called too early. And I don't like
> >  having every QE board file to call this through machine_arch_initcall...
> >  Hmm, what to do.. well, is this thaat bad to call this for every
> >  platform?..
> 
> Its not great.  It has a boot time impact for every platform compiled
> into the kernel.  The problem gets worse every time another block of
> code uses this method.  Personally I prefer platform code calling it
> explicitly.
> 
> Making it an of_platform device would also eliminate that problem, but
> you'd need a method to synchronize the driver with its users.
> 
> I'm not going to raise a big stink about it, but the issue should not
> be ignored.

Heh.. how QE GPIO is different from FSL GTM then? Should I call
fsl_gtm_init() from the board file too? For the every board? I do
believe that years later someone will show up with something like this:


 From: J. Random Hacker
 Subject: [POWERPC] cleanup board initialization code

 This patch removes vast amount of machine_arch_initcall()s that were
 used to solely initialize some hardware, like this:

 qe_add_gpio_chips();
 fsl_gtm_init();
 fsl_spi_init();
 ...

 So, instead of calling this stuff from the board files, we implement
 own arch_initcalls for these functions.

 This causes negligible run-time overhead for the boards that aren't
 using that hardware, but this overhead isn't measurable anyway. Also,
 this patch shrinks .text size a bit, and produces nice looking diffstat.

 12 file changed, 6 insertions(+), 140 deletions(-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
