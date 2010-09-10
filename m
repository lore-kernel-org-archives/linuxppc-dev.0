Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 054FFB70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 21:29:06 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20100909173735.503c4cc0@schlenkerla.am.freescale.net>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<1284069534.6515.36.camel@pasglop>
	<20100909171116.1b9b6e44@schlenkerla.am.freescale.net>
	<1284070433.6515.39.camel@pasglop>
	<20100909173735.503c4cc0@schlenkerla.am.freescale.net>
Date: Fri, 10 Sep 2010 13:29:01 +0200
Message-Id: <20100910112901.0BACA1506AA@gemini.denx.de>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Scott Wood,

In message <20100909173735.503c4cc0@schlenkerla.am.freescale.net> you wrote:
>
> It actually can load an ELF file, but it doesn't currently support
> passing a device tree to it (only argc/argv text arguments, or some
> vxworks stuff).

I see no problems to extend U-Boot such that we support booting Linux
kernel images in form of ELF files. Ideally these should be wrapped
into FIT images to allow for easy combination of kernel and FDT into a
single file (useful for netboot).

> > I've never understood the reasoning for that uImage wrapper
> > thingy. Definitely causes more problems than it solves in my experience.
> 
> Wolfgang was just defending it on the U-Boot list the past couple
> days...  seems like the main thing in its favor is the CRC, especially
> as a final check before reflashing an image.

The additional file header serves a number of purposes; even if they
seem of little use to a developer they are really helpful in
production and maintenance/repair.

Assume you were to find out why a system (returned from a customer)
does not boot any more. Being able to identify the kernel image in
flash, with information about version (name string), image build time
and size is really, really helpful then. Of course it's also helpful
to be able to check if the image is OK or for example has been
(partially) overwritten.


The checksum protection is indeed a VERY useful thing.


If we hade similar checksum protection on the device tree we would
have been able to recognize the memory corruption that triggered this
thread MUCH easier.


Acutally this is my biggest critique on the FDT blob: that we cannot
detect corruptions like this.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is a good thing for an uneducated man to read books of quotations.
                        - Sir Winston Churchill _My Early Life_ ch. 9
