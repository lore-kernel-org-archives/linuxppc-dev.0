Subject: Re: Asiliantfb (Frame Buffer) Driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: Dieu Morales <dieumorales@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040621212131.61159.qmail@web60405.mail.yahoo.com>
References: <20040621212131.61159.qmail@web60405.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1087887950.1547.98.camel@newt>
Mime-Version: 1.0
Date: Tue, 22 Jun 2004 08:05:51 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-06-21 at 22:21, Dieu Morales wrote:
> My firmware does initialize the CT69000 as an
> environment option that allows what looks like VGA
> mode consisting of a simple black screen with
> white text.  As per some suggestions I have removed
> vga_con and added fb_con but received different(worse)
> results.  Without conswitchp = &fb_con I get an
> exception shortly after the asiliant driver has been
> initialized. And with conswitchp = &fb_con the system
> hangs immediately after ppc.md.setup_arch in setup.c.

What I do is to have this in my platform setup code:

#ifdef CONFIG_DUMMY_CONSOLE
	conswitchp = &dummy_con;
#endif

Then I select the console from the command line.

I can't vouch for the modified version in the kernel tree. My original
driver for the 69030 had a bug that made it fail if the VGA firmware had
already initialised the card. That wasn't a problem on the target
platform, but it is why I never submitted the driver to the kernel.


- Adrian Cox
Humboldt Solutions Ltd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
