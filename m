Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 01D2167C37
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 08:18:34 +1100 (EST)
Subject: Re: Best location for call to spi_register_board_info () on PPC
	(MPC5200)
From: Ben Warren <bwarren@qstreams.com>
To: Henk Stegeman <henk.stegeman@gmail.com>
In-Reply-To: <ae4f76fd0612131259h6df7b20fi68561d7878f49483@mail.gmail.com>
References: <ae4f76fd0612131259h6df7b20fi68561d7878f49483@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 16:18:31 -0500
Message-Id: <1166044711.2627.95.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Henk,

On Wed, 2006-12-13 at 21:59 +0100, Henk Stegeman wrote:
> I'm working on an SPI procol driver on the MPC52XX.
> I spend some time in trying to find the best location for calling
> spi_register_board_info () (which basically registers the relations
> between protocol drivers and the SPI chip selects). 
> 
> I wish to call this function from my copy of the
> arch/ppc/platforms/Lite5200.c file  since these relations are
> board-specific, however I found that placing the call in any of these
> functions (eg. lite5200_setup_arch) results in an -ENOMEM from the
> spi_register_board_info () call. 
> 
> Now I'm calling spi_register_board_info () from the spi controller
> driver which is soo ugly.
> 
> Thanks in advance,

Here's how I do it, in my board-specific /arch/powerpc/platforms/83xx
file.  Somebody please comment if I'm doing it wrong:

struct spi_board_info qsPrism_spi_devices[2] = 
{
	{
		.modalias = "SPI_SWITCH",
		.bus_num = 0,
		.chip_select = 0,
		.max_speed_hz = 2000000,
	},
	{
		.modalias = "SPI_SWITCH",
		.bus_num = 0,
		.chip_select = 1,
		.max_speed_hz = 2000000,
	},
};

static int __init qsPrism_spi_board_init(void)
{
	return spi_register_board_info(qsPrism_spi_devices, 2);
}

arch_initcall(qsPrism_spi_board_init);

*********************
SPI_SWITCH is my protocol driver.  The 'arch_initcall' adds this to a
list of functions that gets called at init time.  There is a hierarchy
of these registrations that you can research, but 'arch' is somewhere in
the middle, IIRC, and is a point where memory should be available.

regards,
Ben
