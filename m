Return-Path: <khali@linux-fr.org>
Date: Tue, 1 Jul 2008 18:35:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701183509.0d2f0274@hyperion.delvare>
In-Reply-To: <9e4733910807010929k7088f97ekbadf854c949fbc64@mail.gmail.com>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010929k7088f97ekbadf854c949fbc64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 12:29:29 -0400, Jon Smirl wrote:
> On 7/1/08, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Jon,
> >
> >
> >  On Mon, 30 Jun 2008 19:01:28 -0400, Jon Smirl wrote:
> >  > Add the of_find_i2c_device_by_node function. This allows you to
> >  > follow a reference in the device to an i2c device node and then
> >  > locate the linux device instantiated by the device tree. Example
> >  > use, an i2s codec controlled by i2c.
> >  > ---
> >  >
> >  >  drivers/i2c/i2c-core.c |    2 +-
> >  >  drivers/of/of_i2c.c    |   37 ++++++++++++++++++++++++++-----------
> >  >  include/linux/i2c.h    |    3 +++
> >  >  include/linux/of_i2c.h |    2 ++
> >  >  4 files changed, 32 insertions(+), 12 deletions(-)
> >  >
> >  > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> >  > index d0175f4..e3abe1b 100644
> >  > --- a/drivers/i2c/i2c-core.c
> >  > +++ b/drivers/i2c/i2c-core.c
> >  > @@ -208,7 +208,7 @@ static struct device_attribute i2c_dev_attrs[] = {
> >  >       { },
> >  >  };
> >  >
> >  > -static struct bus_type i2c_bus_type = {
> >  > +struct bus_type i2c_bus_type = {
> >  >       .name           = "i2c",
> >  >       .dev_attrs      = i2c_dev_attrs,
> >  >       .match          = i2c_device_match,
> >
> >
> > What if i2c-core is built as a module? Don't you need to export the
> >  symbol then?
> 
> Jean, can you re-export i2c_bus_type and then I'll drop that part from
> the patch? That way the patch won't hit multiple maintainers.

Just send me a patch doing just that and I will be glad to push early in
the 2.6.27 merge window.

-- 
Jean Delvare
