Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711281554q235c5b36x96d17ea046924600@mail.gmail.com>
Date: Wed, 28 Nov 2007 18:54:52 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: MPC5200 I2C and 2.6 kernel
In-Reply-To: <20071128202245.90051247C1@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <474BEC4F.3080800@sympatec.com>
	<20071128202245.90051247C1@gemini.denx.de>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/28/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <474BEC4F.3080800@sympatec.com> you wrote:
> >
> > Regardless what I'm doing in the 2.6 kernel configuration I can't get
> > this RTC running (I activated RTC support and the driver for the M41T00
> > in the configuration).
> > hwclock --debug tells me:


You have to add the i2c device to this table in arch/powerpc/sysdev/fsl_soc.c

static struct i2c_driver_device i2c_devices[] __initdata = {
        {"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
        {"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
        {"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
        {"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
        {"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
        {"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
        {"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
        {"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
        {"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
        {"stm,m41t00",     "rtc-ds1307",  "m41t00"},
        {"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
};

Then make a device tree node for it with the address.

		i2c@3d40 {
			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
			reg = <3d40 40>;
			interrupts = <2 10 0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;

			rtc@51 {
				compatible = "epson,rtc8564";
				reg = <51>;
			};
		};
		
The device will be named /dev/rtc0. A more update to date version of
hwclock will find it or you can make a symlink from rtc to rtc0.

When it works right:
rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0
rtc-pcf8563 1-0051: setting system clock to 2007-11-28 16:53:12 UTC (1196268792)

I have a pending series of patches that removes this table and moves
the aliasing into the i2c drivers. It is waiting for a core change to
go into the i2c subsystem.


> > hwclock: Open of /dev/rtc failed, errno=19: No such device.
>
> Well... did you check how your /dev/rtc is set up? It used  to  be  a
> misc  device with MAJ=10 MIN=135 in old kernel versions, but now it's
> MAJ=254 MIN=4, i. e. it should look like this:
>
> crw-r--r-- 1 root root 254,   0 Jun 22 18:30 /dev/rtc
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> For every complex problem, there is a solution that is simple,  neat,
> and wrong.                                           -- H. L. Mencken
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
