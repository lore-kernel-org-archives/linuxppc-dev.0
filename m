To: Matt Porter <porter@cox.net>
Cc: "Montgomery, Tim" <timm@artesyncp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC RTC on I2C 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Nov 2002 16:12:40 MST."
             <20021125161239.A20831@home.com>
Date: Tue, 26 Nov 2002 00:07:26 +0100
Message-Id: <20021125230731.43D9DC58BF@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021125161239.A20831@home.com> you wrote:
>

[Tim]
> > I'm working on getting i2c support working on a module that has its
> > RTC on i2c.

Nothing new. Has been done before.

> > I've got my i2c client written, but i2c-core and friends don't load
> > until very late in the game; setting ppc_md.get/set (at least in
> > platform_init) is not very useful.

So delay the initialization until I2C is available.

> > Any thoughts on a graceful way to implement kernel RTC support using
> > an i2c-based RTC (w/o bypassing the kernel's i2c layer)?

See for example the CU824, CPU86,  or  PM826  configurations  in  our
kernel tree which all use a PCF8563 RTC.

[Matt]
> I always thought that one would implement some low-level ppc-specific
> i2c master access functions.  These would be available via a few
> ppc_mds and one could have a generic i2c 'adapter' to call the
> functions.  For RTC access, one would then have a i2c RTC implementation
> using these access functions rather than using the generic PPC RTC
> device.  This does bypass the bloated i2c layer, however.  If done

IMHO the whole I2C system is  (1)  overkill  and  (2)  unusable.  For
example, we often have to deal with PICs and other devices on the I2C
bus  where  you  must  first  issue a write operation (for example to
select a register) followed  by  one  or  more  read  operations  (to
receive  the  data).  This is difficult to implement application code
that perform such accesses when there is more than  one  device,  and
more  than one application process. Things get worse if you also have
to provide simultaneous access tot he  I2C  bus  from  one  ore  more
device drivers.

But this is a different story...

> One could modify the i2c layer to hook up early access of i2c master
> devices.  This would be similar to the early initialization of 550

You can also just delay the initialization of the RTC until  the  I2C
RTC driver loads...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We are Microsoft. Unix is irrelevant. Openness is futile.  Prepare to
be assimilated.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
