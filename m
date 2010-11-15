Return-Path: <cbouatmailru@gmail.com>
Date: Tue, 16 Nov 2010 00:24:32 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
Message-ID: <20101115212432.GA17754@oksana.dev.rtsoft.ru>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
	<20101115173250.GA22104@oksana.dev.rtsoft.ru>
	<4CE1A0E4.5030505@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4CE1A0E4.5030505@firmworks.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 11:06:44AM -1000, Mitch Bradley wrote:
[...]
> >>  			eeprom@52 {
> >>  				compatible = "catalyst,24c32";
> >>  				reg =<0x52>;
> >>+				pagesize =<32>;
> >
> >I think you'd better drop the pagesize property altogether, and
> >instead make the compatible string more specific (if needed at
> >all. are there any 'catalyst,24c32' chips with pagesize != 32?)
> 
> Microchip makes a 24c32 part that looks pretty similar to the
> catalyst part, but Microchip's has a 64-byte page size compared to
> Catalyst's 32.

Well, when using microchip part, the compatible string would be
"microchip,24c32", correct? Then we have all the information
already, no need for the pagesize.

> It would probably be feasible to have a generic I2C EEPROM driver
> that could handle many different parts, parameterized by total size,
> block size, and page size.

I guess it can do this already via I2C ID table. The problem
is that I2C core is only using part ID (no vendor ID matching).

So, the current driver may just implement quirks like this:

if (of_device_is_compatible(np, "catalyst,24c32"))
	pagesize = 32;

Or, if it's some generic pattern, something like

if (of_device_is_compatible_vendor(np, "catalyst"))
	pagesize /= 2;

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
