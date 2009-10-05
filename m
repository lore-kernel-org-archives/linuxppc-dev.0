Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <132676.44242.qm@web30102.mail.mud.yahoo.com>
References: <132676.44242.qm@web30102.mail.mud.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Oct 2009 08:30:44 -0600
Message-ID: <fa686aa40910050730m6a98b156p7b1240b7560f1aab@mail.gmail.com>
Subject: Re: Help with SPI node
To: Joe Shmo <spamreceptor@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 1, 2009 at 10:19 AM, Joe Shmo <spamreceptor@yahoo.com> wrote:
>
> =A0I'm attempting to get SPI to work on my embedded design
> =A0that is based on the mpc8313erbd reference board wiht a
> =A02.6.27 kernel.=A0 I cannot open the SPI device.
> =A0Tracing through the kernel code, it looks like the device is
> =A0not being found in the DTB file.=A0 However there is a
> =A0SPI node in there already described.=A0 Our boards is a
> =A0SPI master, and the device we will attach is a SPI
> =A0slave.=A0 Could someone elaborate on what is needed in
> =A0the DTS file to have our SPI driver work and respond to an
> =A0open() call?

Some notes:
- you should also cc: the linuxppc-dev@lists.ozlabs.org when asking
questions about powerpc platforms.
- Please post in plain text only, not HTML.  Yahoo should have an
option for posting in plain text instead of formated.
- "Joe Shmo"?  It's not against the rules to use a pseudoname, but
it's not very polite.

Things to check:
- Once the system is booted, look in /sys/bus/of_platform/devices to
see if the SPI bus device is registered.  If it isn't there then it
means that the 8xxx platform code (arch/powerpc/platforms/) isn't
registering the device.
- Look in /sys/bus/of_platform/drivers/ to see if the mpc8xxx_spi
driver is loaded into the kernel.  If it isn't there, then you need to
load the driver into the kernel.
- If both are present, then look in
/sys/bus/of_platform/devices/e0007000.spi (I think; the name might be
slightly different) for a 'driver' symlink.  If the symlink is there,
then it means that the driver is bound to the device.  Most likely it
means that the "compatible" value in the node doesn't match what the
driver is looking for.

Look at those things and report back.

g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
